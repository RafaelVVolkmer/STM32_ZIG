const regmap = @import("regmap.zig").regmap;

// ------------------------ Base e offsets (RM0454) ------------------------- //
pub const SYSCFG_BASE   : usize = 0x4001_0000;

pub const SYSCFG_CFGR1  : usize = 0x00;
pub const SYSCFG_CFGR2  : usize = 0x18;

pub const ITLINE_BASE   : usize = 0x80;
pub const ITLINE_OFFSET : usize = 4;

inline fn itLineOffset(num: u6) usize
{
  return (ITLINE_BASE + (@as(usize, num) * ITLINE_OFFSET));
}

// ----------------------------- Select Enums ------------------------------- //
pub const MemMode = enum(u2)
{
  FLASH   = 0,
  SYSTEM  = 1,
  SRAM    = 3
};

pub const IRMod = enum(u2)
{
  TIM16   = 0,
  USART1  = 1,
  USART4  = 2,
  _RES    = 3
};

pub const I2cFmpTarget = enum
{
  PB6   = 0,
  PB7   = 1,
  PB8   = 2,
  PB9   = 3,
  PA9   = 4,
  PA10  = 5,
  I2C1  = 6,
  I2C2  = 7,
};

pub const CdenPad = enum
{
  PA1   = 0,
  PA3   = 1,
  PA5   = 2,
  PA6   = 3,
  PA13  = 4,
  PB0   = 5,
  PB1   = 6,
  PB2   = 7,
};

// -------------------------------- CFGR1 ----------------------------------- //
const RegCFGR1 = regmap(packed struct(u32)
{
        MEM_MODE      : u2,
  const _RES2         : u1 = 0,
        PA11_RMP      : u1,
        PA12_RMP      : u1,
        IR_POL        : u1,
        IR_MOD        : u2,
        BOOSTEN       : u1,
        UCPD1_STROBE  : u1,
        UCPD2_STROBE  : u1,
  const _RES11_15     : u5 = 0,
        I2C_PB6_FMP   : u1,
        I2C_PB7_FMP   : u1,
        I2C_PB8_FMP   : u1,
        I2C_PB9_FMP   : u1,
        I2C1_FMP      : u1,
        I2C2_FMP      : u1,
        I2C_PA9_FMP   : u1,
        I2C_PA10_FMP  : u1,
  const _RES24_31     : u8 = 0,
});

// -------------------------------- CFGR2 ----------------------------------- //
const RegCFGR2 = regmap(packed struct(u32)
{
        LOCKUP_LOCK       : u1,
        SRAM_PARITY_LOCK  : u1,
        PVD_LOCK          : u1,
        ECC_LOCK          : u1,
  const _RES4_7           : u4 = 0,
        SRAM_PEF          : u1,
  const _RES9_15          : u7 = 0,
        PA1_CDEN          : u1,
        PA3_CDEN          : u1,
        PA5_CDEN          : u1,
        PA6_CDEN          : u1,
        PA13_CDEN         : u1,
        PB0_CDEN          : u1,
        PB1_CDEN          : u1,
        PB2_CDEN          : u1,
  const _RES24_31         : u8 = 0,
});

// ------------------------------ ITLINEx ----------------------------------- //
const RegITLINE0  = regmap(packed struct(u32)
{
        WWDG      : u1,
  const _RES1_31  : u31 = 0,
});

const RegITLINE1  = regmap(packed struct(u32)
{
        PVDOUT    : u1,
  const _RES1_31  : u31 = 0,
});

const RegITLINE2  = regmap(packed struct(u32)
{
        TAMP      : u1,
        RTC       : u1,
  const _RES2_31  : u30 = 0,
});

const RegITLINE3  = regmap(packed struct(u32)
{
        FLASH_ITF   : u1,
        FLASH_ECC   : u1,
  const _RES2_31    : u30 = 0,
});

const RegITLINE4  = regmap(packed struct(u32)
{
        RCC       : u1,
  const _RES1_31  : u31 = 0,
});

const RegITLINE5  = regmap(packed struct(u32)
{
        EXTI0     : u1,
        EXTI1     : u1,
  const _RES2_31  : u30 = 0,
});

const RegITLINE6  = regmap(packed struct(u32)
{
        EXTI2     : u1,
        EXTI3     : u1,
  const _RES2_31  : u30 = 0,
});

const RegITLINE7  = regmap(packed struct(u32)
{
        EXTI4     : u1,
        EXTI5     : u1,
        EXTI6     : u1,
        EXTI7     : u1,
        EXTI8     : u1,
        EXTI9     : u1,
        EXTI10    : u1,
        EXTI11    : u1,
        EXTI12    : u1,
        EXTI13    : u1,
        EXTI14    : u1,
        EXTI15    : u1,
  const _RES12_31 : u20 = 0,
});

const RegITLINE8  = regmap(packed struct(u32)
{
        UCPD1     : u1,
        UCPD2     : u1,
  const _RES2_31  : u30 = 0,
});

const RegITLINE9  = regmap(packed struct(u32)
{
        DMA1_CH1 : u1,
  const _RES1_31 : u31 = 0,
});

const RegITLINE10 = regmap(packed struct(u32)
{
        DMA1_CH2 : u1,
        DMA1_CH3 : u1,
  const _RES2_31 : u30 = 0,
});

const RegITLINE11 = regmap(packed struct(u32)
{
        DMAMUX   : u1,
        DMA1_CH4 : u1,
        DMA1_CH5 : u1,
        DMA1_CH6 : u1,
        DMA1_CH7 : u1,
  const _RES5_31 : u27 = 0,
});

const RegITLINE12 = regmap(packed struct(u32)
{
        ADC       : u1,
        COMP1     : u1,
        COMP2     : u1,
  const _RES3_31  : u29 = 0,
});

const RegITLINE13 = regmap(packed struct(u32)
{
        TIM1_CCU : u1,
        TIM1_TRG : u1,
        TIM1_UPD : u1,
        TIM1_BRK : u1,
  const _RES4_31 : u28 = 0,
});

const RegITLINE14 = regmap(packed struct(u32)
{
        TIM1_CC  : u1,
  const _RES1_31 : u31 = 0,
});

const RegITLINE15 = regmap(packed struct(u32)
{
        TIM2     : u1,
  const _RES1_31 : u31 = 0,
});

const RegITLINE16 = regmap(packed struct(u32)
{
        TIM3     : u1,
  const _RES1_31 : u31 = 0,
});

const RegITLINE17 = regmap(packed struct(u32)
{
        TIM6      : u1,
        DAC       : u1,
        LPTIM1    : u1,
  const _RES3_31  : u29 = 0,
});

const RegITLINE18 = regmap(packed struct(u32)
{
        TIM7      : u1,
        LPTIM2    : u1,
  const _RES2_31  : u30 = 0,
});

const RegITLINE19 = regmap(packed struct(u32)
{
        TIM14     : u1,
  const _RES1_31  : u31 = 0,
});

const RegITLINE20 = regmap(packed struct(u32)
{
        TIM15     : u1,
  const _RES1_31  : u31 = 0,
});

const RegITLINE21 = regmap(packed struct(u32)
{
        TIM16     : u1,
  const _RES1_31  : u31 = 0,
});

const RegITLINE22 = regmap(packed struct(u32)
{
        TIM17     : u1,
  const _RES1_31  : u31 = 0,
});

const RegITLINE23 = regmap(packed struct(u32)
{
        I2C1      : u1,
  const _RES1_31  : u31 = 0,
});

const RegITLINE24 = regmap(packed struct(u32)
{
        I2C2      : u1,
  const _RES1_31  : u31 = 0,
});

const RegITLINE25 = regmap(packed struct(u32)
{
        SPI1      : u1,
  const _RES1_31  : u31 = 0,
});

const RegITLINE26 = regmap(packed struct(u32)
{
        SPI2      : u1,
  const _RES1_31  : u31 = 0,
});

const RegITLINE27 = regmap(packed struct(u32)
{
        USART1    : u1,
  const _RES1_31  : u31 = 0,
});

const RegITLINE28 = regmap(packed struct(u32)
{
        USART2    : u1,
  const _RES1_31  : u31 = 0,
});

const RegITLINE29 = regmap(packed struct(u32)
{
        USART3    : u1,
        USART4    : u1,
        LPUART1   : u1,
  const _RES3_31  : u29 = 0,
});

// -------------------------------- Struct ---------------------------------- //
pub const SYSCFG = struct
{
  pub const CFGR1  = RegCFGR1.regPtr(SYSCFG_BASE + SYSCFG_CFGR1);
  pub const CFGR2  = RegCFGR2.regPtr(SYSCFG_BASE + SYSCFG_CFGR2);

  pub const ITLINE0  = RegITLINE0.regPtr(SYSCFG_BASE + itLineOffset(0));
  pub const ITLINE1  = RegITLINE1.regPtr(SYSCFG_BASE + itLineOffset(1));
  pub const ITLINE2  = RegITLINE2.regPtr(SYSCFG_BASE + itLineOffset(2));
  pub const ITLINE3  = RegITLINE3.regPtr(SYSCFG_BASE + itLineOffset(3));
  pub const ITLINE4  = RegITLINE4.regPtr(SYSCFG_BASE + itLineOffset(4));
  pub const ITLINE5  = RegITLINE5.regPtr(SYSCFG_BASE + itLineOffset(5));
  pub const ITLINE6  = RegITLINE6.regPtr(SYSCFG_BASE + itLineOffset(6));
  pub const ITLINE7  = RegITLINE7.regPtr(SYSCFG_BASE + itLineOffset(7));
  pub const ITLINE8  = RegITLINE8.regPtr(SYSCFG_BASE + itLineOffset(8));
  pub const ITLINE9  = RegITLINE9.regPtr(SYSCFG_BASE + itLineOffset(9));
  pub const ITLINE10 = RegITLINE10.regPtr(SYSCFG_BASE + itLineOffset(10));
  pub const ITLINE11 = RegITLINE11.regPtr(SYSCFG_BASE + itLineOffset(11));
  pub const ITLINE12 = RegITLINE12.regPtr(SYSCFG_BASE + itLineOffset(12));
  pub const ITLINE13 = RegITLINE13.regPtr(SYSCFG_BASE + itLineOffset(13));
  pub const ITLINE14 = RegITLINE14.regPtr(SYSCFG_BASE + itLineOffset(14));
  pub const ITLINE15 = RegITLINE15.regPtr(SYSCFG_BASE + itLineOffset(15));
  pub const ITLINE16 = RegITLINE16.regPtr(SYSCFG_BASE + itLineOffset(16));
  pub const ITLINE17 = RegITLINE17.regPtr(SYSCFG_BASE + itLineOffset(17));
  pub const ITLINE18 = RegITLINE18.regPtr(SYSCFG_BASE + itLineOffset(18));
  pub const ITLINE19 = RegITLINE19.regPtr(SYSCFG_BASE + itLineOffset(19));
  pub const ITLINE20 = RegITLINE20.regPtr(SYSCFG_BASE + itLineOffset(20));
  pub const ITLINE21 = RegITLINE21.regPtr(SYSCFG_BASE + itLineOffset(21));
  pub const ITLINE22 = RegITLINE22.regPtr(SYSCFG_BASE + itLineOffset(22));
  pub const ITLINE23 = RegITLINE23.regPtr(SYSCFG_BASE + itLineOffset(23));
  pub const ITLINE24 = RegITLINE24.regPtr(SYSCFG_BASE + itLineOffset(24));
  pub const ITLINE25 = RegITLINE25.regPtr(SYSCFG_BASE + itLineOffset(25));
  pub const ITLINE26 = RegITLINE26.regPtr(SYSCFG_BASE + itLineOffset(26));
  pub const ITLINE27 = RegITLINE27.regPtr(SYSCFG_BASE + itLineOffset(27));
  pub const ITLINE28 = RegITLINE28.regPtr(SYSCFG_BASE + itLineOffset(28));
  pub const ITLINE29 = RegITLINE29.regPtr(SYSCFG_BASE + itLineOffset(29));

  pub usingnamespace attach(@This());
};

pub fn attach(comptime Self: type) type
{
  const u1  = u1;
  const u2  = u2;
  const u6  = u6;
  const u12 = u12;

  return struct
  {

    // - CFGR1 -----------------------------------------------------------------
    pub inline fn setMemMode(mode: MemMode) void
    {
      RegCFGR1.modifyOne(Self.CFGR1, "MEM_MODE", @intFromEnum(mode));
    }

    pub inline fn remapPA11(enable: bool) void
    {
      RegCFGR1.modifyOne(Self.CFGR1, "PA11_RMP", @as(u1, @intFromBool(enable)));
    }

    pub inline fn remapPA12(enable: bool) void
    {
      RegCFGR1.modifyOne(Self.CFGR1, "PA12_RMP", @as(u1, @intFromBool(enable)));
    }

    pub inline fn setIR(source: IRMod, inverted: bool) void
    {
      RegCFGR1.modify(Self.CFGR1, .{
        .IR_MOD = @intFromEnum(source),
        .IR_POL = @as(u1, @intFromBool(inverted)),
      });
    }

    pub inline fn setBoost(enable: bool) void
    {
      RegCFGR1.modifyOne(Self.CFGR1, "BOOSTEN", @as(u1, @intFromBool(enable)));
    }

    pub inline fn strobeUCPD1() void
    {
      RegCFGR1.modifyOne(Self.CFGR1, "UCPD1_STROBE", 1);
      RegCFGR1.modifyOne(Self.CFGR1, "UCPD1_STROBE", 0);
    }

    pub inline fn strobeUCPD2() void
    {
      RegCFGR1.modifyOne(Self.CFGR1, "UCPD2_STROBE", 1);
      RegCFGR1.modifyOne(Self.CFGR1, "UCPD2_STROBE", 0);
    }

    pub inline fn setI2cFmp(target: I2cFmpTarget, enable: bool) void
    {
      var value: u1 = 0;

      value = @as(u1, @intFromBool(enable));

      switch (target)
      {
        .PB6  => RegCFGR1.modifyOne(Self.CFGR1, "I2C_PB6_FMP",  value),
        .PB7  => RegCFGR1.modifyOne(Self.CFGR1, "I2C_PB7_FMP",  value),
        .PB8  => RegCFGR1.modifyOne(Self.CFGR1, "I2C_PB8_FMP",  value),
        .PB9  => RegCFGR1.modifyOne(Self.CFGR1, "I2C_PB9_FMP",  value),
        .PA9  => RegCFGR1.modifyOne(Self.CFGR1, "I2C_PA9_FMP",  value),
        .PA10 => RegCFGR1.modifyOne(Self.CFGR1, "I2C_PA10_FMP", value),
        .I2C1 => RegCFGR1.modifyOne(Self.CFGR1, "I2C1_FMP",     value),
        .I2C2 => RegCFGR1.modifyOne(Self.CFGR1, "I2C2_FMP",     value),
      }
    }

    // - CFGR2 -----------------------------------------------------------------
    pub inline fn lockOnLockup(enable: bool) void
    {
      RegCFGR2.modifyOne(Self.CFGR2, "LOCKUP_LOCK", @as(u1, @intFromBool(enable)));
    }

    pub inline fn lockSramParity(enable: bool) void
    {
      RegCFGR2.modifyOne(Self.CFGR2, "SRAM_PARITY_LOCK", @as(u1, @intFromBool(enable)));
    }

    pub inline fn lockPvd(enable: bool) void
    {
      RegCFGR2.modifyOne(Self.CFGR2, "PVD_LOCK", @as(u1, @intFromBool(enable)));
    }

    pub inline fn lockEcc(enable: bool) void
    {
      RegCFGR2.modifyOne(Self.CFGR2, "ECC_LOCK", @as(u1, @intFromBool(enable)));
    }

    pub inline fn isSramParityError() bool
    {
      return RegCFGR2.read(Self.CFGR2).SRAM_PEF == 1;
    }

    pub inline fn clearSramParityError() void
    {
      RegCFGR2.modifyOne(Self.CFGR2, "SRAM_PEF", 1);
    }

    pub inline fn setCapDisconnect(pad: CdenPad, enable: bool) void
    {
      var value: u1 = 0;

      value = @as(u1, @intFromBool(enable));

      switch (pad)
      {
        .PA1  => RegCFGR2.modifyOne(Self.CFGR2, "PA1_CDEN",  value),
        .PA3  => RegCFGR2.modifyOne(Self.CFGR2, "PA3_CDEN",  value),
        .PA5  => RegCFGR2.modifyOne(Self.CFGR2, "PA5_CDEN",  value),
        .PA6  => RegCFGR2.modifyOne(Self.CFGR2, "PA6_CDEN",  value),
        .PA13 => RegCFGR2.modifyOne(Self.CFGR2, "PA13_CDEN", value),
        .PB0  => RegCFGR2.modifyOne(Self.CFGR2, "PB0_CDEN",  value),
        .PB1  => RegCFGR2.modifyOne(Self.CFGR2, "PB1_CDEN",  value),
        .PB2  => RegCFGR2.modifyOne(Self.CFGR2, "PB2_CDEN",  value),
      }
    }

    // - ITLINE ----------------------------------------------------------------
    pub inline fn readITLINE(n: u6) u32
    {
      const p = @intToPtr(*volatile u32, SYSCFG_BASE + itline_off(n));
      return regmap.read(p);
    }

    pub inline fn anyRccIRQ() bool
    {
      return RegITLINE4.read(Self.ITLINE4).RCC == 1;
    }

    pub inline fn exti01Pending() bool
    {
      const r = RegITLINE5.read(Self.ITLINE5);
      return (r.EXTI0 == 1) or (r.EXTI1 == 1);
    }

    pub inline fn exti23Pending() bool
    {
      const r = RegITLINE6.read(Self.ITLINE6);
      return (r.EXTI2 == 1) or (r.EXTI3 == 1);
    }

    pub inline fn exti4_15Mask() u12
    {
      const r = RegITLINE7.read(Self.ITLINE7);
      return (@as(u12, r.EXTI4))
           | (@as(u12, r.EXTI5)  << 1)
           | (@as(u12, r.EXTI6)  << 2)
           | (@as(u12, r.EXTI7)  << 3)
           | (@as(u12, r.EXTI8)  << 4)
           | (@as(u12, r.EXTI9)  << 5)
           | (@as(u12, r.EXTI10) << 6)
           | (@as(u12, r.EXTI11) << 7)
           | (@as(u12, r.EXTI12) << 8)
           | (@as(u12, r.EXTI13) << 9)
           | (@as(u12, r.EXTI14) << 10)
           | (@as(u12, r.EXTI15) << 11);
    }

    pub inline fn whichUsartPending() struct { usart3: bool, usart4: bool, lpuart1: bool }
    {
      const r = RegITLINE29.read(Self.ITLINE29);
      return .{ .usart3 = r.USART3 == 1, .usart4 = r.USART4 == 1, .lpuart1 = r.LPUART1 == 1 };
    }

    pub inline fn whichDma1Pending() struct { ch1: bool, ch2: bool, ch3: bool, ch4: bool, ch5: bool, ch6: bool, ch7: bool, dmamux: bool } {
      const r9  = RegITLINE9.read(Self.ITLINE9);
      const r10 = RegITLINE10.read(Self.ITLINE10);
      const r11 = RegITLINE11.read(Self.ITLINE11);
      return .{
        .ch1    = r9.DMA1_CH1  == 1,
        .ch2    = r10.DMA1_CH2 == 1,
        .ch3    = r10.DMA1_CH3 == 1,
        .ch4    = r11.DMA1_CH4 == 1,
        .ch5    = r11.DMA1_CH5 == 1,
        .ch6    = r11.DMA1_CH6 == 1,
        .ch7    = r11.DMA1_CH7 == 1,
        .dmamux = r11.DMAMUX   == 1,
      };
    }

    pub inline fn waitItlineMask(n: u6, mask: u32, max_loops: usize) bool {
      var i: usize = 0;
      while (i < max_loops) : (i += 1) {
        if ((readITLINE(n) & mask) != 0) return true;
      }
      return false;
    }
  };
}
