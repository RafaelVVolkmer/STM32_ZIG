const regmap = @import("regmap.zig").regmap;

// ------------------------ Base e offsets (RM0454) ------------------------- //
pub const RCC_BASE      : usize = 0x4002_1000;

pub const RCC_CR        : usize = 0x00;
pub const RCC_ICSCR     : usize = 0x04;
pub const RCC_CFGR      : usize = 0x08;
pub const RCC_PLLCFGR   : usize = 0x0C;

pub const RCC_CIER      : usize = 0x18;
pub const RCC_CIFR      : usize = 0x1C;
pub const RCC_CICR      : usize = 0x20;

pub const RCC_IOPRSTR   : usize = 0x24;
pub const RCC_AHBRSTR   : usize = 0x28;
pub const RCC_APBRSTR1  : usize = 0x2C;
pub const RCC_APBRSTR2  : usize = 0x30;

pub const RCC_IOPENR    : usize = 0x34;
pub const RCC_AHBENR    : usize = 0x38;
pub const RCC_APBENR1   : usize = 0x3C;
pub const RCC_APBENR2   : usize = 0x40;

pub const RCC_IOPSMENR  : usize = 0x44;
pub const RCC_AHBSMENR  : usize = 0x48;
pub const RCC_APBSMENR1 : usize = 0x4C;
pub const RCC_APBSMENR2 : usize = 0x50;

pub const RCC_CCIPR     : usize = 0x54;
pub const RCC_CCIPR2    : usize = 0x58;

pub const RCC_BDCR      : usize = 0x5C;
pub const RCC_CSR       : usize = 0x60;

// ------------------------- Enable/Disbale consts -------------------------- //
pub const RCC_EN        : bool = true;
pub const RCC_DS        : bool = false;

// ----------------------------- Select Enums ------------------------------- //
pub const UsartSel = enum(u2)
{
  PCLK    = 0,
  SYSCLK  = 1,
  HSI16   = 2,
  LSE     = 3
};

pub const I2cSel = enum(u2)
{
  PCLK    = 0,
  SYSCLK  = 1,
  HSI16   = 2,
  _RES    = 3
};

pub const AdcSel = enum(u2)
{
  NOCLK   = 0,
  PLLP    = 1,
  SYSCLK  = 2,
  _RES    = 3
};

pub const RtcSel = enum(u2)
{
  NOCLK     = 0,
  LSE       = 1,
  LSI       = 2,
  HSE_DIV32 = 3
};

// ------------------------------- RCC core --------------------------------- //
const RegCR = regmap(packed struct(u32)
{
  const _RES0_7   : u8 = 0,
        HSION     : u1,
        HSIKERON  : u1,
        HSIRDY    : u1,
        HSIDIV    : u3,
  const _RES14_15 : u2 = 0,
        HSEON     : u1,
        HSERDY    : u1,
        HSEBYP    : u1,
        CSSON     : u1,
  const _RES20_23 : u4 = 0,
        PLLON     : u1,
        PLLRDY    : u1,
  const _RES26_31 : u6 = 0,
});

const RegICSCR = regmap(packed struct(u32)
{
        HSICAL    : u8,
        HSITRIM   : u7,
  const _RES15_31 : u17 = 0,
});

const RegCFGR = regmap(packed struct(u32)
{
        SW        : u2,
        SWS       : u2,
        HPRE      : u4,
  const _RES8_9   : u2 = 0,
        PPRE      : u3,
  const _RES13_15 : u3 = 0,
  const _RES16_23 : u8 = 0,
        MCOSEL    : u3,
  const _RES27    : u1 = 0,
        MCOPRE    : u3,
  const _RES31    : u1 = 0,
});

const RegPLLCFGR = regmap(packed struct(u32)
{
        PLLSRC    : u2,
  const _RES2_3   : u2 = 0,
        PLLM      : u3,
  const _RES7     : u1 = 0,
        PLLN      : u8,
  const _RES15    : u1 = 0,
        PLLPEN    : u1,
        PLLP      : u5,
  const _RES22_24 : u3 = 0,
  const _RES25    : u1 = 0,
  const _RES26_27 : u2 = 0,
        PLLREN    : u1,
        PLLR      : u3,
});

// ----------------------------- Resets (RSTR) ------------------------------ //
const RegIOPRSTR = regmap(packed struct(u32)
{
        GPIOARST : u1,
        GPIOBRST : u1,
        GPIOCRST : u1,
        GPIODRST : u1,
        GPIOERST : u1,
        GPIOFRST : u1,
  const _RES6_31 : u26 = 0,
});

const RegAHBRSTR = regmap(packed struct(u32)
{
        DMA1RST   : u1,
        DMA2RST   : u1,
  const _RES2_7   : u6 = 0,
        FLASHRST  : u1,
  const _RES9_11  : u3 = 0,
        CRCRST    : u1,
  const _RES13_31 : u19 = 0,
});

const RegAPBRSTR1 = regmap(packed struct(u32)
{
        TIM3RST   : u1,
  const _RES1_3   : u3 = 0,
        TIM6RST   : u1,
        TIM7RST   : u1,
  const _RES6_9   : u4 = 0,
        RTCAPBRST : u1,
        WWDGRST   : u1,
  const _RES12_12 : u1 = 0,
        USBRST    : u1,
        SPI2RST   : u1,
        SPI3RST   : u1,
  const _RES16    : u1 = 0,
        USART2RST : u1,
        USART3RST : u1,
        USART4RST : u1,
  const _RES20    : u1 = 0,
        I2C1RST   : u1,
        I2C2RST   : u1,
        I2C3RST   : u1,
  const _RES24_27 : u4 = 0,
        DBGRST    : u1,
        PWRRST    : u1,
  const _RES30_31 : u2 = 0,
});

const RegAPBRSTR2 = regmap(packed struct(u32)
{
        SYSCFGRST : u1,
  const _RES1_10  : u10 = 0,
        TIM1RST   : u1,
        SPI1RST   : u1,
  const _RES13    : u1 = 0,
        USART1RST : u1,
        TIM14RST  : u1,
        TIM15RST  : u1,
        TIM16RST  : u1,
        TIM17RST  : u1,
  const _RES19    : u1 = 0,
        ADCRST    : u1,
  const _RES21_31 : u11 = 0,
});

// ----------------------------- Enables (ENR) ------------------------------ //
const RegIOPENR = regmap(packed struct(u32)
{
        GPIOAEN   : u1,
        GPIOBEN   : u1,
        GPIOCEN   : u1,
        GPIODEN   : u1,
        GPIOEEN   : u1,
        GPIOFEN   : u1,
  const _RES6_31  : u26 = 0,
});

const RegAHBENR = regmap(packed struct(u32)
{
        DMA1EN    : u1,
        DMA2EN    : u1,
  const _RES2_7   : u6 = 0,
        FLASHEN   : u1,
  const _RES9_11  : u3 = 0,
        CRCEN     : u1,
  const _RES13_31 : u19 = 0,
});

const RegAPBENR1 = regmap(packed struct(u32)
{
        TIM3EN    : u1,
  const _RES1_3   : u3 = 0,
        TIM6EN    : u1,
        TIM7EN    : u1,
  const _RES6_9   : u4 = 0,
        RTCAPBEN  : u1,
        WWDGEN    : u1,
  const _RES12_13 : u2 = 0,
        USBEN     : u1,
  const _RES15    : u1 = 0,
        SPI2EN    : u1,
        SPI3EN    : u1,
  const _RES18    : u1 = 0,
        USART2EN  : u1,
        USART3EN  : u1,
        USART4EN  : u1,
  const _RES22    : u1 = 0,
        I2C1EN    : u1,
        I2C2EN    : u1,
        I2C3EN    : u1,
  const _RES26_27 : u2 = 0,
        DBGEN     : u1,
        PWREN     : u1,
  const _RES30_31 : u2 = 0,
});

const RegAPBENR2 = regmap(packed struct(u32)
{
        SYSCFGEN  : u1,
  const _RES1_10  : u10 = 0,
        TIM1EN    : u1,
        SPI1EN    : u1,
  const _RES13    : u1 = 0,
        USART1EN  : u1,
        TIM14EN   : u1,
        TIM15EN   : u1,
        TIM16EN   : u1,
        TIM17EN   : u1,
  const _RES19    : u1 = 0,
        ADCEN     : u1,
  const _RES21_31 : u11 = 0,
});

// ----------------------- Sleep/Stop enables (SMENR) ----------------------- //

const RegIOPSMENR = regmap(packed struct(u32)
{
        GPIOASMEN : u1,
        GPIOBSMEN : u1,
        GPIOCSMEN : u1,
        GPIODSMEN : u1,
        GPIOESMEN : u1,
        GPIOFSMEN : u1,
  const _RES6_31  : u26 = 0,
});

const RegAHBSMENR = regmap(packed struct(u32) 
{
        DMA1SMEN  : u1,
        DMA2SMEN  : u1,
  const _RES2_7   : u6 = 0,
        FLASHSMEN : u1,
        SRAMSMEN  : u1,
  const _RES10_11 : u2 = 0,
        CRCSMEN   : u1,
  const _RES13_31 : u19 = 0,
});

const RegAPBSMENR1 = regmap(packed struct(u32)
{
        TIM3SMEN    : u1,
  const _RES1_3     : u3 = 0,
        TIM6SMEN    : u1,
        TIM7SMEN    : u1,
  const _RES6_9     : u4 = 0,
        RTCAPBSMEN  : u1,
        WWDGSMEN    : u1,
  const _RES12_13   : u2 = 0,
        USBSMEN     : u1,
  const _RES15      : u1 = 0,
        SPI2SMEN    : u1,
        SPI3SMEN    : u1,
  const _RES18      : u1 = 0,
        USART2SMEN  : u1,
        USART3SMEN  : u1,
        USART4SMEN  : u1,
  const _RES22      : u1 = 0,
        I2C1SMEN    : u1,
        I2C2SMEN    : u1,
        I2C3SMEN    : u1,
  const _RES26_27   : u2 = 0,
        DBGSMEN     : u1,
        PWRSMEN     : u1,
  const _RES30_31   : u2 = 0,
});

const RegAPBSMENR2 = regmap(packed struct(u32)
{
        SYSCFGSMEN  : u1,
  const _RES1_10    : u10 = 0,
        TIM1SMEN    : u1,
        SPI1SMEN    : u1,
  const _RES13      : u1 = 0,
        USART1SMEN  : u1,
        TIM14SMEN   : u1,
        TIM15SMEN   : u1,
        TIM16SMEN   : u1,
        TIM17SMEN   : u1,
  const _RES19      : u1 = 0,
        ADCSMEN     : u1,
  const _RES21_31   : u11 = 0,
});

// -------------------------------- Control --------------------------------- //

const RegCCIPR = regmap(packed struct(u32)
{
        USART1SEL : u2,
        USART2SEL : u2,
        USART3SEL : u2,
  const _RES0     : u6 = 0,
        I2C1SEL   : u2,
        I2C2SEL   : u2,
  const _RES1     : u6 = 0,
        TIM1SEL   : u1,
  const _RES2     : u1 = 0,
        TIM15SEL  : u1,
  const _RES3     : u5 = 0,
        ADCSEL    : u2,
});

const RegCCIPR2 = regmap(packed struct(u32)
{
  const _RES : u32 = 0;
});

const RegBDCR = regmap(packed struct(u32)
{
        LSEON   : u1,
        LSERDY  : u1,
        LSEBYP  : u1,
        LSEDRV  : u2,
  const _RES0   : u3 = 0,
        RTCSEL  : u2,
  const _RES1   : u5 = 0,
        RTCEN   : u1,
        BDRST   : u1,
  const _RES2   : u7 = 0,
        LSCOEN  : u1,
        LSCOSEL : u1,
  const _RES3   : u6 = 0,
});

const RegCSR = regmap(packed struct(u32)
{
        LSION     : u1,
        LSIRDY    : u1,
  const _RES0     : u21 = 0,
        RMVF      : u1,
  const _RES1     : u1 = 0,
        OBLRSTF   : u1,
        PINRSTF   : u1,
        PWRRSTF   : u1,
        SFTRSTF   : u1,
        IWDGRSTF  : u1,
        WWDGRSTF  : u1,
        LPWRRSTF  : u1,
});

const RegCIER = regmap(packed struct(u32)
{
        LSIRDYIE  : u1,
        LSERDYIE  : u1,
  const _RES0     : u1 = 0,
        HSIRDYIE  : u1,
        HSERDYIE  : u1,
        PLLRDYIE  : u1,
  const _RES1     : u26 = 0,
});

const RegCIFR = regmap(packed struct(u32)
{
        LSIRDYF : u1,
        LSERDYF : u1,
  const _RES0   : u1 = 0,
        HSIRDYF : u1,
        HSERDYF : u1,
        PLLRDYF : u1,
  const _RES1   : u2 = 0,
        CSSF    : u1,
        LSECSSF : u1,
  const _RES2   : u22 = 0,
});

const RegCICR = regmap(packed struct(u32)
{
        LSIRDYC : u1,
        LSERDYC : u1,
  const _RES0   : u1 = 0,
        HSIRDYC : u1,
        HSERDYC : u1,
        PLLRDYC : u1,
  const _RES1   : u2 = 0,
        CSSC    : u1,
        LSECSSC : u1,
  const _RES2   : u22 = 0,
});

// -------------------------------- Structs --------------------------------- //
pub const RCC = struct
{
  pub const CR        = RegCR.regPtr(RCC_BASE + RCC_CR);
  pub const ICSCR     = RegICSCR.regPtr(RCC_BASE + RCC_ICSCR);
  pub const CFGR      = RegCFGR.regPtr(RCC_BASE + RCC_CFGR);
  pub const PLLCFGR   = RegPLLCFGR.regPtr(RCC_BASE + RCC_PLLCFGR);

  pub const CIER      = RegCIER.regPtr(RCC_BASE + RCC_CIER);
  pub const CIFR      = RegCIFR.regPtr(RCC_BASE + RCC_CIFR);
  pub const CICR      = RegCICR.regPtr(RCC_BASE + RCC_CICR);

  pub const IOPRSTR   = RegIOPRSTR.regPtr(RCC_BASE + RCC_IOPRSTR);
  pub const AHBRSTR   = RegAHBRSTR.regPtr(RCC_BASE + RCC_AHBRSTR);
  pub const APBRSTR1  = RegAPBRSTR1.regPtr(RCC_BASE + RCC_APBRSTR1);
  pub const APBRSTR2  = RegAPBRSTR2.regPtr(RCC_BASE + RCC_APBRSTR2);

  pub const IOPENR    = RegIOPENR.regPtr(RCC_BASE + RCC_IOPENR);
  pub const AHBENR    = RegAHBENR.regPtr(RCC_BASE + RCC_AHBENR);
  pub const APBENR1   = RegAPBENR1.regPtr(RCC_BASE + RCC_APBENR1);
  pub const APBENR2   = RegAPBENR2.regPtr(RCC_BASE + RCC_APBENR2);

  pub const IOPSMENR  = RegIOPSMENR.regPtr(RCC_BASE + RCC_IOPSMENR);
  pub const AHBSMENR  = RegAHBSMENR.regPtr(RCC_BASE + RCC_AHBSMENR);
  pub const APBSMENR1 = RegAPBSMENR1.regPtr(RCC_BASE + RCC_APBSMENR1);
  pub const APBSMENR2 = RegAPBSMENR2.regPtr(RCC_BASE + RCC_APBSMENR2);

  pub const CCIPR     = RegCCIPR.regPtr(RCC_BASE + RCC_CCIPR);
  pub const CCIPR2    = RegCCIPR2.regPtr(RCC_BASE + RCC_CCIPR2);
  pub const BDCR      = RegBDCR.regPtr(RCC_BASE + RCC_BDCR);
  pub const CSR       = RegCSR.regPtr(RCC_BASE + RCC_CSR);

  pub usingnamespace attach(@This());
}

pub fn attach(comptime Self: type) type
{
  return struct
  {
    // - GPIO clocks by name ---------------------------------------------------
    pub inline fn enableGPIOA() void
    {
      RegIOPENR.modifyOne(Self.IOPENR, "GPIOAEN", RCC_EN);
    }

    pub inline fn enableGPIOB() void
    {
      RegIOPENR.modifyOne(Self.IOPENR, "GPIOBEN", RCC_EN);
    }

    pub inline fn enableGPIOC() void
    {
      RegIOPENR.modifyOne(Self.IOPENR, "GPIOCEN", RCC_EN);
    }

    pub inline fn enableGPIOD() void
    {
      RegIOPENR.modifyOne(Self.IOPENR, "GPIODEN", RCC_EN);
    }

    pub inline fn enableGPIOE() void
    {
      RegIOPENR.modifyOne(Self.IOPENR, "GPIOEEN", RCC_EN);
    }

    pub inline fn enableGPIOF() void
    {
      RegIOPENR.modifyOne(Self.IOPENR, "GPIOFEN", RCC_EN);
    }

    // - APB1 clocks by name ---------------------------------------------------
    pub inline fn enableTIM3() void
    {
      RegAPBENR1.modifyOne(Self.APBENR1, "TIM3EN", RCC_EN);
    }

    pub inline fn enableTIM6() void
    {
      RegAPBENR1.modifyOne(Self.APBENR1, "TIM6EN", RCC_EN);
    }

    pub inline fn enableTIM7() void
    {
      RegAPBENR1.modifyOne(Self.APBENR1, "TIM7EN", RCC_EN);
    }

    pub inline fn enableSPI2() void
    {
      RegAPBENR1.modifyOne(Self.APBENR1, "SPI2EN", RCC_EN);
    }

    pub inline fn enableSPI3() void
    {
      RegAPBENR1.modifyOne(Self.APBENR1, "SPI3EN", RCC_EN);
    }

    pub inline fn enableUSART2() void
    {
      RegAPBENR1.modifyOne(Self.APBENR1, "USART2EN", RCC_EN);
    }

    pub inline fn enableUSART3() void
    {
      RegAPBENR1.modifyOne(Self.APBENR1, "USART3EN", RCC_EN);
    }

    pub inline fn enableUSART4() void
    {
      RegAPBENR1.modifyOne(Self.APBENR1, "USART4EN", RCC_EN);
    }

    pub inline fn enableI2C1() void
    {
      RegAPBENR1.modifyOne(Self.APBENR1, "I2C1EN", RCC_EN);
    }

    pub inline fn enableI2C2() void
    {
      RegAPBENR1.modifyOne(Self.APBENR1, "I2C2EN", RCC_EN);
    }

    pub inline fn enableI2C3() void
    {
      RegAPBENR1.modifyOne(Self.APBENR1, "I2C3EN", RCC_EN);
    }

    // - APB2 clocks by name ---------------------------------------------------
    pub inline fn enableSYSCFG() void
    {
      RegAPBENR2.modifyOne(Self.APBENR2, "SYSCFGEN", RCC_EN);
    }

    pub inline fn enableTIM1() void
    {
      RegAPBENR2.modifyOne(Self.APBENR2, "TIM1EN", RCC_EN);
    }

    pub inline fn enableSPI1() void
    {
      RegAPBENR2.modifyOne(Self.APBENR2, "SPI1EN", RCC_EN);
    }

    pub inline fn enableUSART1() void
    {
      RegAPBENR2.modifyOne(Self.APBENR2, "USART1EN", RCC_EN);
    }

    pub inline fn enableADC() void
    {
      RegAPBENR2.modifyOne(Self.APBENR2, "ADCEN", RCC_EN);
    }

    // - AHB clocks by name ----------------------------------------------------
    pub inline fn enableDMA1() void
    {
      RegAHBENR.modifyOne(Self.AHBENR, "DMA1EN", RCC_EN);
    }

    pub inline fn enableDMA2() void
    {
      RegAHBENR.modifyOne(Self.AHBENR, "DMA2EN", RCC_EN);
    }

    pub inline fn enableCRC() void
    {
      RegAHBENR.modifyOne(Self.AHBENR, "CRCEN", RCC_EN);
    }

    pub inline fn enableFLASH() void
    {
      RegAHBENR.modifyOne(Self.AHBENR, "FLASHEN", RCC_EN);
    }

    // - Generic by Bit/Mask ---------------------------------------------------
    pub inline fn enableGPIO_byIndex(idx: u5) void
    {
      var reg : *volatile u32 = undefined;
      var val : u32 = 0;

      reg = @ptrCast(*volatile u32, Self.IOPENR);
      val = regmap.read(reg);

      regmap.write(reg, val | (@as(u32, RCC_EN) << idx));
    }

    pub inline fn enableAHB_bit(bit: u5) void
    {
      var reg : *volatile u32 = undefined;
      var val : u32 = 0;

      reg = @ptrCast(*volatile u32, Self.AHBENR);
      val = regmap.read(reg);

      regmap.write(reg, val | (@as(u32, RCC_EN) << bit));
    }

    pub inline fn enableAPB1_bit(bit: u5) void
    {
      var reg : *volatile u32 = undefined;
      var val : u32 = 0;

      reg = @ptrCast(*volatile u32, Self.APBENR1);
      val = regmap.read(reg);

      regmap.write(reg, val | (@as(u32, RCC_EN) << bit));
    }

    pub inline fn enableAPB2_bit(bit: u5) void
    {
      var reg : *volatile u32 = undefined;
      var val : u32 = 0;

      reg = @ptrCast(*volatile u32, Self.APBENR2);
      val = regmap.read(reg);

      regmap.write(reg, val | (@as(u32, RCC_EN) << bit));
    }

    pub inline fn enableAHB_mask(mask: u32) void
    {
      var reg : *volatile u32 = undefined;
      var val : u32 = 0;

      reg = @ptrCast(*volatile u32, Self.AHBENR);
      val = regmap.read(reg);

      regmap.write(reg, val | mask);
    }

    pub inline fn enableAPB1_mask(mask: u32) void
    {
      var reg : *volatile u32 = undefined;
      var val : u32 = 0;

      reg = @ptrCast(*volatile u32, Self.APBENR1);
      val = regmap.read(reg);

      regmap.write(reg, val | mask);
    }

    pub inline fn enableAPB2_mask(mask: u32) void
    {
      var reg : *volatile u32 = undefined;
      var val : u32 = 0;

      reg = @ptrCast(*volatile u32, Self.APBENR2);
      val = regmap.read(reg);

      regmap.write(reg, val | mask);
    }

    // - Reset Pulse -----------------------------------------------------------
    pub inline fn resetAPB1_bit(bit: u5) void
    {
      var reg   : *volatile u32 = undefined;
      var mask  : u32 = 0;
      var val   : u32 = 0;

      reg = @ptrCast(*volatile u32, Self.APBRSTR1);
      mask = (@as(u32, RCC_EN) << bit);
      val = regmap.read(reg);

      regmap.write(reg, (val | mask));
      val = regmap.read(reg);
      regmap.write(reg, (val & ~mask));
    }

    pub inline fn resetAPB2_bit(bit: u5) void
    {
      var reg   : *volatile u32 = undefined;
      var mask  : u32 = 0;
      var val   : u32 = 0;

      reg = @ptrCast(*volatile u32, Self.APBRSTR2);
      mask = (@as(u32, RCC_EN) << bit);

      val = regmap.read(reg);
      regmap.write(reg, (val | mask));
      val = regmap.read(reg);
      regmap.write(reg, (val & ~mask));
    }
  
    pub inline fn resetGPIOA() void
    {
      RegIOPRSTR.modifyOne(Self.IOPRSTR, "GPIOARST", RCC_EN);
      RegIOPRSTR.modifyOne(Self.IOPRSTR, "GPIOARST", RCC_DS);
    }
  
    pub inline fn resetGPIOB() void
    {
      RegIOPRSTR.modifyOne(Self.IOPRSTR, "GPIOBRST", RCC_EN);
      RegIOPRSTR.modifyOne(Self.IOPRSTR, "GPIOBRST", RCC_DS);
    }
  
    pub inline fn resetGPIOC() void
    {
      RegIOPRSTR.modifyOne(Self.IOPRSTR, "GPIOCRST", RCC_EN);
      RegIOPRSTR.modifyOne(Self.IOPRSTR, "GPIOCRST", RCC_DS);
    }
  
    pub inline fn resetGPIOD() void
    {
      RegIOPRSTR.modifyOne(Self.IOPRSTR, "GPIODRST", RCC_EN);
      RegIOPRSTR.modifyOne(Self.IOPRSTR, "GPIODRST", RCC_DS);
    }

    pub inline fn resetGPIOE() void
    {
      RegIOPRSTR.modifyOne(Self.IOPRSTR, "GPIOERST", RCC_EN);
      RegIOPRSTR.modifyOne(Self.IOPRSTR, "GPIOERST", RCC_DS);
    }
  
    pub inline fn resetGPIOF() void
    {
      RegIOPRSTR.modifyOne(Self.IOPRSTR, "GPIOFRST", RCC_EN);
      RegIOPRSTR.modifyOne(Self.IOPRSTR, "GPIOFRST", RCC_DS);
    }

    // - Oscilators & Base Clock -----------------------------------------------
    pub inline fn enableHSI16(wait: bool, max_loops: usize) bool
    {
      var iterator : usize = 0;
  
      RegCR.modifyOne(Self.CR, "HSION", RCC_EN);

      if (!wait)
      {
        return true;
      }

      while (iterator < max_loops) : (iterator += 1)
      {
        if (RegCR.read(Self.CR).HSIRDY == RCC_EN)
        {
          return true;
        }
      }

      return false;
    }

    pub inline fn enableHSE(bypass: bool, wait: bool, max_loops: usize) bool
    {
      var iterator : usize = 0;

      RegCR.modify(Self.CR, .{
        .HSEBYP = @as(u1, @intFromBool(bypass)),
        .HSEON  = RCC_EN
      });

      if (!wait)
      {
        return true;
      }

      while (iterator < max_loops) : (iterator += 1)
      {
        if (RegCR.read(Self.CR).HSERDY == RCC_EN)
        {
          return true;
        }
      }
      return false;
    }

    pub inline fn enablePLLREN(wait: bool, max_loops: usize) bool
    {
      var iterator : usize = 0;

      RegPLLCFGR.modifyOne(Self.PLLCFGR, "PLLREN", RCC_EN);
      RegCR.modifyOne(Self.CR, "PLLON", RCC_EN);
  
      if (!wait)
      {
        return true;
      }

      while (iterator < max_loops) : (iterator += 1)
      {
        if (RegCR.read(Self.CR).PLLRDY == RCC_EN)
        {
          return true;
        }
      }
      return false;
    }

    // - MUX Helpers -----------------------------------------------------------
    pub inline fn setUSART1Clock(sel: UsartSel) void
    {
      RegCCIPR.modifyOne(Self.CCIPR, "USART1SEL", @intFromEnum(sel));
    }

    pub inline fn setUSART2Clock(sel: UsartSel) void
    {
      RegCCIPR.modifyOne(Self.CCIPR, "USART2SEL", @intFromEnum(sel));
    }

    pub inline fn setUSART3Clock(sel: UsartSel) void
    {
      RegCCIPR.modifyOne(Self.CCIPR, "USART3SEL", @intFromEnum(sel));
    }

    pub inline fn setI2C1Clock(sel: I2cSel) void
    {
      RegCCIPR.modifyOne(Self.CCIPR, "I2C1SEL", @intFromEnum(sel));
    }

    pub inline fn setI2C2Clock(sel: I2cSel) void
    {
      RegCCIPR.modifyOne(Self.CCIPR, "I2C2SEL", @intFromEnum(sel));
    }

    pub inline fn setADCClock(sel: AdcSel) void
    {
      RegCCIPR.modifyOne(Self.CCIPR, "ADCSEL", @intFromEnum(sel));
    }
  
    pub inline fn setTIM1SEL(val: u1) void
    {
      RegCCIPR.modifyOne(Self.CCIPR, "TIM1SEL", val);
    }

    pub inline fn setTIM15SEL(val: u1) void
    {
      RegCCIPR.modifyOne(Self.CCIPR, "TIM15SEL", val);
    }

    // - BDCR / CSR / IRQ ------------------------------------------------------
    pub inline fn enableLSE(bypass: bool, drive: u2) void
    {
      RegBDCR.modify(Self.BDCR, .{
        .LSEBYP = @as(u1, @intFromBool(bypass)),
        .LSEDRV = drive,
        .LSEON  = RCC_EN
      });
    }

    pub inline fn setRTCClock(sel: RtcSel) void
    {
      RegBDCR.modifyOne(Self.BDCR, "RTCSEL", @intFromEnum(sel));
    }

    pub inline fn enableRTC() void
    {
      RegBDCR.modifyOne(Self.BDCR, "RTCEN", RCC_EN);
    }

    pub inline fn backupReset() void
    {
      RegBDCR.modifyOne(Self.BDCR, "BDRST", RCC_EN);
      RegBDCR.modifyOne(Self.BDCR, "BDRST", RCC_DS);
    }

    pub inline fn enableLSI() void
    {
      RegCSR.modifyOne(Self.CSR, "LSION", RCC_EN);
    }
  
    pub inline fn clearResetFlags() void
    {
      RegCSR.modifyOne(Self.CSR, "RMVF", RCC_EN);
    }

    pub inline fn enableClockReadyIRQs(lsi: bool, lse: bool, hsi: bool,
                                        hse: bool, pll: bool) void
    {
      RegCIER.modify(Self.CIER, .{
        .LSIRDYIE = @as(u1, @intFromBool(lsi)),
        .LSERDYIE = @as(u1, @intFromBool(lse)),
        .HSIRDYIE = @as(u1, @intFromBool(hsi)),
        .HSERDYIE = @as(u1, @intFromBool(hse)),
        .PLLRDYIE = @as(u1, @intFromBool(pll)),
      });
    }

    pub inline fn clearClockFlags() void
    {
      RegCICR.modify(Self.CICR, .{
        .LSIRDYC  = RCC_EN,
        .LSERDYC  = RCC_EN,
        .HSIRDYC  = RCC_EN,
        .HSERDYC  = RCC_EN,
        .PLLRDYC  = RCC_EN,
        .CSSC     = RCC_EN,
        .LSECSSC  = RCC_EN
      });
    }

    // - Sleep-mode enables ----------------------------------------------------
    pub inline fn enableGPIO_Sleep(port_idx: u5) void
    {
      var reg : *volatile u32 = undefined;
      var val : u32 = 0;

      reg = @ptrCast(*volatile u32, Self.IOPSMENR);
      val = regmap.read(reg);

      regmap.write(reg, val | (@as(u32, RCC_EN) << port_idx));
    }

    pub inline fn enableAHB_Sleep_bit(bit: u5) void
    {
      var reg : *volatile u32 = undefined;
      var val : u32 = 0;

      reg = @ptrCast(*volatile u32, Self.AHBSMENR);
      val = regmap.read(reg);

      regmap.write(reg, val | (@as(u32, RCC_EN) << bit));
    }

    pub inline fn enableAPB1_Sleep_bit(bit: u5) void
    {
      var reg : *volatile u32 = undefined;
      var val : u32 = 0;

      reg = @ptrCast(*volatile u32, Self.APBSMENR1);
      val = regmap.read(reg);

      regmap.write(reg, val | (@as(u32, RCC_EN) << bit));
    }

    pub inline fn enableAPB2_Sleep_bit(bit: u5) void
    {
      var reg : *volatile u32 = undefined;
      var val : u32 = 0;

      reg = @ptrCast(*volatile u32, Self.APBSMENR2);
      val = regmap.read(reg);

      regmap.write(reg, val | (@as(u32, RCC_EN) << bit));
    }

    pub inline fn enableAHB_Sleep_mask(mask: u32) void
    {
      var reg : *volatile u32 = undefined;
      var val : u32 = 0;

      reg = @ptrCast(*volatile u32, Self.AHBSMENR);
      val = regmap.read(reg);

      regmap.write(reg, val | mask);
    }

    pub inline fn enableAPB1_Sleep_mask(mask: u32) void
    {
      var reg : *volatile u32 = undefined;
      var val : u32 = 0;

      reg = @ptrCast(*volatile u32, Self.APBSMENR1);
      val = regmap.read(reg);

      regmap.write(reg, val | mask);
    }

    pub inline fn enableAPB2_Sleep_mask(mask: u32) void
    {
      var reg : *volatile u32 = undefined;
      var val : u32 = 0;

      reg = @ptrCast(*volatile u32, Self.APBSMENR2);
      val = regmap.read(reg);

      regmap.write(reg, val | mask);
    }
  }
};
