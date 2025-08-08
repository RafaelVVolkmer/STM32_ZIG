const std = @import("std");
const assert = std.debug.assert;

const BITS_PER_BYTE     : u64 = @bitSizeOf(u8);
const EVAL_BRANCH_QUOTA : u32 = 2_000;

pub fn mmio(comptime PackedT: type) type
{
  @setEvalBranchQuota(EVAL_BRANCH_QUOTA);

  const bit_count = @bitSizeOf(PackedT);
  const size_bits:  u64 = @as(u64, @intCast(bit_count));
  const size_bytes: u64 = (size_bits / BITS_PER_BYTE);

  const IntT = std.meta.Int(.unsigned, bit_count);

  if ((size_bits % BITS_PER_BYTE) != 0)
    @compileError("register bit-size must be a multiple of one byte!");

  if (!std.math.isPowerOfTwo(size_bytes))
    @compileError("size must encode a power-of-two number of bytes!");

  if (@as(u64, @intCast(@sizeOf(PackedT))) != size_bytes)
    @compileError("IntT and PackedT must have the same size!");

  return extern struct
  {
    const Self = @This();

    raw: IntT,

    pub const underlying_type = PackedT;

    comptime
    {
      assert(@sizeOf(PackedT) == size_bytes);
      assert(@bitSizeOf(PackedT) == @bitSizeOf(IntT));
      assert(@sizeOf(Self) == @sizeOf(IntT));
    }

    pub inline fn regPtr(comptime addr: usize) *volatile Self
    {
      return @as(*volatile Self, @ptrFromInt(addr));
    }

    pub inline fn regPtrRuntime(addr: usize) *volatile Self
    {
      return @as(*volatile Self, @ptrFromInt(addr));
    }

    pub inline fn writeRaw(addr: *volatile Self, val: IntT) void
    {
      addr.raw = val;
    }
  
    pub inline fn readRaw(addr: *volatile Self) IntT
    {
      return addr.raw;
    }

    pub inline fn read(addr: *volatile Self) PackedT
    {
      const raw: IntT = addr.readRaw();
  
      return @bitCast(raw);
    }

    pub inline fn write(addr: *volatile Self, val: PackedT) void
    {
      addr.writeRaw(@bitCast(val));
    }

    pub inline fn modifyOne(addr: *volatile Self,
                              comptime field_name: []const u8,
                              value: anytype) void
    {
      var val: PackedT = @bitCast(@as(IntT, 0));
    
      val = read(addr);
    
      const FieldT = @TypeOf(@field(val, field_name));
      @field(val, field_name) = @as(FieldT, value);
    
      write(addr, val);
    }

    pub inline fn modify(addr: *volatile Self, fields: anytype) void
    {
      var val: PackedT = @bitCast(@as(IntT, 0));

      comptime
      {
        if (@typeInfo(@TypeOf(fields)) != .@"struct")
          @compileError("modify: 'fields' must be .{ .Field = value, ... }");
      }

      val = read(addr);
  
      inline for (@typeInfo(@TypeOf(fields)).@"struct".fields) |field|
      {
        const FieldT = @TypeOf(@field(val, field.name));
        @field(val, field.name) = @as(FieldT, @field(fields, field.name));
      }

      write(addr, val);
    }

    inline fn toggleField(val_ptr: *PackedT, 
                            comptime field_name: []const u8,
                            value: anytype) void
    {
      const FieldType = @TypeOf(@field(val_ptr.*, field_name));

      switch (@typeInfo(FieldType))
      {
        .int =>
        {
          @field(val_ptr.*, field_name) =
            @field(val_ptr.*, field_name) ^ @as(FieldType, value);
        },
        .@"enum" => |enum_info|
        {
          const Tag = enum_info.tag_type;
          const cur  = @as(Tag, @intFromEnum(@field(val_ptr.*, field_name)));
          const mask = @as(Tag, @intFromEnum(@as(FieldType, value)));

          @field(val_ptr.*, field_name) = @as(FieldType, @enumFromInt(cur ^ mask));
        },
        else => |T|
        {
          @compileError("unsupported register type '" ++ @typeName(T) ++ "'");
        },
      }
    }

    pub inline fn toggleOne(addr: *volatile Self,
                              comptime field_name: []const u8,
                              value: anytype) void
    {
      var val: PackedT = @bitCast(@as(IntT, 0));

      val = read(addr);

      toggleField(&val, field_name, value);

      write(addr, val);
    }

    pub inline fn toggle(addr: *volatile Self, fields: anytype) void
    {
      var val: PackedT = @bitCast(@as(IntT, 0));

      val = read(addr);

      inline for (@typeInfo(@TypeOf(fields)).@"struct".fields) |field|
      {
        toggleField(&val, field.name, @field(fields, field.name));
      }

      write(addr, val);
    }
  };
}
