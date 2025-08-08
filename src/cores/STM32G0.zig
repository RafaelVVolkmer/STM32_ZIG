const GPIO = @import("GPIO.zig");

pub const STM32G0 = struct
{
    pub const Ports = struct 
    {
        A: GPIO.InterfaceT = GPIO.makeRegister(0x4800_0000),
        B: GPIO.InterfaceT = GPIO.makeRegister(0x4800_0400),
        C: GPIO.InterfaceT = GPIO.makeRegister(0x4800_0800),
        D: GPIO.InterfaceT = GPIO.makeRegister(0x4800_0C00),
    };

    pub const ports: Ports = .{};
};
