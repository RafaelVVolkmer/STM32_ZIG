const reg_map = @import("regmap.zig").regmap;

pub const GPIO_PIN_COUNT    : u5 = 16;
pub const BITS_PER_FIELD_1  : u5 = 1;
pub const BITS_PER_FIELD_2  : u5 = 2;
pub const BITS_PER_AF       : u5 = 4;
pub const AFR_PIN_SPLIT     : u5 = 8;

pub const FIELD1_MASK_U32   : u32 = 0b1;
pub const FIELD2_MASK_U32   : u32 = 0b11;
pub const AF_MASK_U32       : u32 = 0xF;

const VALID_MASK        : u16 =
  @intCast((@as(u32, FIELD1_MASK_U32) << GPIO_PIN_COUNT) - FIELD1_MASK_U32);

pub const GPIO_Errno = enum(u8)
{
    SUCCESS           = 0,
    INVALID_PIN       = 1,
    INVALID_AF        = 2,
    INVALID_MODE      = 3,
    INVALID_PULL      = 4,
    INVALID_SPEED     = 5,
    CLOCK_DISABLED    = 6,
    PORT_LOCKED       = 7,
    NULL_PTR          = 8,
    OUT_OF_RANGE      = 9,
    READ_FAIL         = 10,
    WRITE_FAIL        = 11,
    BUSY              = 12,
    TIMEOUT           = 13,
    NOT_SUPPORTED     = 14,
    UNKNOWN           = 255,
};

pub const GPIO_Mode = enum(u2) 
{
  IO_INPUT  = 0,
  IO_OUTPUT = 1,
  IO_ALT    = 2,
  IO_ANALOG = 3
};

pub const GPIO_OType = enum(u1)
{
  PUSH_PULL   = 0,
  OPEN_DRAIN  = 1
};

pub const GPIO_Speed = enum(u2)
{
  LOW_SPEED       = 0,
  MEDIUM_SPEED    = 1,
  HIGH_SPEED      = 2,
  VERY_HIGH_SPEED = 3
};

pub const GPIO_Pull  = enum(u2)
{
  PULL_NONE   = 0,
  PULL_UP     = 1,
  PULL_DOWN   = 2,
  __RESERVED  = 3
};

pub const GPIO_PORT = extern struct
{
  MODER:   reg_map(u32),
  OTYPER:  reg_map(u32),
  OSPEEDR: reg_map(u32),
  PUPDR:   reg_map(u32),
  IDR:     reg_map(u32),
  ODR:     reg_map(u32),
  BSRR:    reg_map(u32),
  LCKR:    reg_map(u32),
  AFRL:    reg_map(u32),
  AFRH:    reg_map(u32),
  BRR:     reg_map(u32),
};

pub inline fn gpioAtRuntime(base: usize) *volatile GPIO_PORT
{
    return @ptrFromInt(base);
}

pub inline fn gpioAtComptime(comptime base: usize) *volatile GPIO_PORT
{
    return @ptrFromInt(base);
}

pub const GPIO_Handle = struct
{
    regs: *volatile GPIO_PORT,

    pub fn init(base: usize) GPIO_Handle
    {
        return .{ .regs = gpioAtRuntime(base) };
    }
  
    fn set2(self: *const GPIO_Handle, reg: *volatile reg_map(u32),
            pin: u5, val: u2) GPIO_Errno
    {
      var shift     : u5  = 0;
      var register  : u32 = 0;

      if (pin >= GPIO_PIN_COUNT)
        return .INVALID_PIN;

      _ = self;

      shift = (pin * BITS_PER_FIELD_2);

      register = reg.read();
      register &= ~(FIELD2_MASK_U32 << shift);
      register |= (@as(u32, val) << shift);

      reg.write(register);

      return .SUCCESS;
    }

    fn set1(self: *const GPIO_Handle, reg: *volatile reg_map(u32),
            pin: u5, on: bool) GPIO_Errno
    {
      var mask      : u32 = 0;
      var register  : u32 = 0;

      if (pin >= GPIO_PIN_COUNT)
        return .INVALID_PIN;

       _ = self;

      mask = (FIELD1_MASK_U32 << pin);
      register = reg.read();

      if (on)
      {
        register |= mask;
      }
      else
      {
        register &= ~mask;
      }

      reg.write(register);

      return .SUCCESS;
    }

    fn setAF(self: *const GPIO_Handle, pin: u5, af: u4) GPIO_Errno
    {
      var shift     : u5  = 0;
      var idx       : u5  = 0;
      var register  : u32 = 0;
  
      if (pin >= GPIO_PIN_COUNT)
        return .INVALID_PIN;

      if (@as(u32, af) > AF_MASK_U32)
        return .INVALID_AF;

      const reg: *volatile reg_map(u32) =
        if (pin < AFR_PIN_SPLIT)
          &self.regs.AFRL
        else
          &self.regs.AFRH;

      idx =
        if (pin < AFR_PIN_SPLIT)
          pin
        else
          (pin - AFR_PIN_SPLIT);

      shift = (idx * BITS_PER_AF);

      register= reg.read();
      register &= ~(AF_MASK_U32 << shift);
      register |= (@as(u32, af) << shift);

      reg.write(register);

      return .SUCCESS;
    }

    pub fn setMode(self: *const GPIO_Handle, pin: u5, mode: GPIO_Mode) GPIO_Errno
      { return self.set2(&self.regs.MODER, pin, @intFromEnum(mode)); }

    pub fn setOType(self: *const GPIO_Handle, pin: u5, otype: GPIO_OType) GPIO_Errno
      { return self.set1(&self.regs.OTYPER, pin, @intFromEnum(otype) == 1); }

    pub fn setSpeed(self: *const GPIO_Handle, pin: u5, speed: GPIO_Speed) GPIO_Errno
      { return self.set2(&self.regs.OSPEEDR, pin, @intFromEnum(speed)); }

    pub fn setPull(self: *const GPIO_Handle, pin: u5, pull: GPIO_Pull) GPIO_Errno
      { return self.set2(&self.regs.PUPDR, pin, @intFromEnum(pull)); }

    pub fn setAltFunc(self: *const GPIO_Handle, pin: u5, af: u4) GPIO_Errno 
      { return self.setAF(pin, af); }

    pub fn writePin(self: *const GPIO_Handle, pin: u5, high: bool) GPIO_Errno
    {
      if (pin >= GPIO_PIN_COUNT)
        return .INVALID_PIN;

      if (high)
      {
        self.regs.BSRR.write(FIELD1_MASK_U32 << pin);
      }
      else
      {
        self.regs.BSRR.write(FIELD1_MASK_U32 << (pin + GPIO_PIN_COUNT));
      }

      return .SUCCESS;
    }

    pub fn togglePin(self: *const GPIO_Handle, pin: u5) GPIO_Errno
    {
      var mask  : u32 = 0;
      var odr   : u32 = 0;

      if (pin >= GPIO_PIN_COUNT)
        return .INVALID_PIN;

      mask = (FIELD1_MASK_U32 << pin);

      odr = self.regs.ODR.read();

      if ((odr & mask) == 0)
      {
        self.regs.BSRR.write(mask);
      }
      else
      {
        self.regs.BSRR.write(mask << GPIO_PIN_COUNT);
      }

      return .SUCCESS;
    }

    pub fn readPin(self: *const GPIO_Handle, pin: u5, out: *bool) GPIO_Errno
    {
      var mask : u32 = 0;

      if (pin >= GPIO_PIN_COUNT)
        return .INVALID_PIN;

      mask = (FIELD1_MASK_U32 << pin);

      out.* = 
        if ((self.regs.IDR.read() & mask) != 0)
          true
        else
          false;

      return .SUCCESS;
    }
  
    pub fn writePort(self: *const GPIO_Handle, value: u16) GPIO_Errno
    {
      var register    : u32 = 0;

      if ((value & ~VALID_MASK) != 0)
        return .OUT_OF_RANGE;

      register = self.regs.ODR.read();

      register &= ~@as(u32, VALID_MASK);
      register |= @as(u32, value);

      self.regs.ODR.write(register);

      return .SUCCESS;
    }

    pub fn writePortMasked(self: *const GPIO_Handle, set_mask: u16, reset_mask: u16) GPIO_Errno
    {
      var masked      : u32 = 0;
      var combined    : u16 = 0;
  
      combined = set_mask | reset_mask;

      if ((combined & ~VALID_MASK) != 0)
        return .OUT_OF_RANGE;

      if ((set_mask & reset_mask) != 0)
        return .OUT_OF_RANGE;

      masked = (@as(u32, set_mask)) | (@as(u32, reset_mask) << GPIO_PIN_COUNT);

      self.regs.BSRR.write(masked);

      return .SUCCESS;
    }

    pub fn readPort(self: *const GPIO_Handle, out: *u16) GPIO_Errno
    {
      out.* = @as(u16, @truncate(self.regs.IDR.read()));

      return .SUCCESS;
    }
};

pub const InterfaceT = struct
{
    regs    : *volatile GPIO_PORT,
    handle  : GPIO_Handle,
};

pub fn makeRegister(comptime base: usize) InterfaceT
{
    const regs_ptr = gpioAtComptime(base);

    return .{
              .regs   = regs_ptr,
              .handle = .{ .regs = regs_ptr },
            };
}
