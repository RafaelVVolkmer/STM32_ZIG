const RCC_module    = @import("RCC_G0.zig");
const SYSCFG_module = @import("SYSCFG_G0.zig");
const GPIO_module   = @import("ST_GPIO.zig");

pub const STM32G0 = struct
{
  pub const RCC     = RCC_module.RCC;
  pub const SYSCFG  = SYSCFG_module.SYSCFG;

  pub const Ports = struct 
  {
    A: GPIO_module.InterfaceT = GPIO_module.makeRegister(0x4800_0000),
    B: GPIO_module.InterfaceT = GPIO_module.makeRegister(0x4800_0400),
    C: GPIO_module.InterfaceT = GPIO_module.makeRegister(0x4800_0800),
    D: GPIO_module.InterfaceT = GPIO_module.makeRegister(0x4800_0C00),
    E: GPIO_module.InterfaceT = GPIO_module.makeRegister(0x4800_1000),
    F: GPIO_module.InterfaceT = GPIO_module.makeRegister(0x4800_1400),
  };

    pub const ports: Ports = .{};
};
