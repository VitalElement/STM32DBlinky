module stm32startup;

import main;
import ldc.attributes;
import core.stdc.config;                            // we need this for c_ulong, so we can get symbols from the linker-script
import ldc.llvmasm;
static import gcc.attribute;    

extern(C) extern __gshared c_ulong _stackStart;

alias extern(C) const void* VectorFunc;

enum weak = gcc.attribute.attribute("weak");
enum naked = gcc.attribute.attribute("naked");

private void wfi()
{ 
    version(ALLOW_WFI)
    { 
        __asm("wfi");
    } 
}

@naked extern(C) void Default_Handler()
{
    while(true)
    {
        wfi();
    }
}

template DefaultHandler(string vector)
{
    const char[] DefaultHandler = "@weak extern (C) void " ~ vector ~ "(){ Default_Handler(); }";
}

mixin(DefaultHandler!("NMI_Handler"));
mixin(DefaultHandler!("HardFault_Handler"));
mixin(DefaultHandler!("MemManage_Handler"));
mixin(DefaultHandler!("BusFault_Handler"));
mixin(DefaultHandler!("UsageFault_Handler"));
mixin(DefaultHandler!("SVC_Handler"));
mixin(DefaultHandler!("DebugMon_Handler"));
mixin(DefaultHandler!("PendSV_Handler"));
mixin(DefaultHandler!("SysTick_Handler"));
mixin(DefaultHandler!("WWDG_IRQHandler"));
mixin(DefaultHandler!("PVD_IRQHandler"));
mixin(DefaultHandler!("TAMP_STAMP_IRQHandler"));
mixin(DefaultHandler!("RTC_WKUP_IRQHandler"));
mixin(DefaultHandler!("FLASH_IRQHandler"));
mixin(DefaultHandler!("RCC_IRQHandler"));
mixin(DefaultHandler!("EXTI0_IRQHandler"));
mixin(DefaultHandler!("EXTI1_IRQHandler"));
mixin(DefaultHandler!("EXTI2_IRQHandler"));
mixin(DefaultHandler!("EXTI3_IRQHandler"));
mixin(DefaultHandler!("EXTI4_IRQHandler"));
mixin(DefaultHandler!("DMA1_Stream0_IRQHandler"));
mixin(DefaultHandler!("DMA1_Stream1_IRQHandler"));
mixin(DefaultHandler!("DMA1_Stream2_IRQHandler"));
mixin(DefaultHandler!("DMA1_Stream3_IRQHandler"));
mixin(DefaultHandler!("DMA1_Stream4_IRQHandler"));
mixin(DefaultHandler!("DMA1_Stream5_IRQHandler"));
mixin(DefaultHandler!("DMA1_Stream6_IRQHandler"));
mixin(DefaultHandler!("ADC_IRQHandler"));
mixin(DefaultHandler!("CAN1_TX_IRQHandler"));
mixin(DefaultHandler!("CAN1_RX0_IRQHandler"));
mixin(DefaultHandler!("CAN1_RX1_IRQHandler"));
mixin(DefaultHandler!("CAN1_SCE_IRQHandler"));
mixin(DefaultHandler!("EXTI9_5_IRQHandler"));
mixin(DefaultHandler!("TIM1_BRK_TIM9_IRQHandler"));
mixin(DefaultHandler!("TIM1_UP_TIM10_IRQHandler"));
mixin(DefaultHandler!("TIM1_TRG_COM_TIM11_IRQHandler"));
mixin(DefaultHandler!("TIM1_CC_IRQHandler"));
mixin(DefaultHandler!("TIM2_IRQHandler"));
mixin(DefaultHandler!("TIM3_IRQHandler"));
mixin(DefaultHandler!("TIM4_IRQHandler"));
mixin(DefaultHandler!("I2C1_EV_IRQHandler"));
mixin(DefaultHandler!("I2C1_ER_IRQHandler"));
mixin(DefaultHandler!("I2C2_EV_IRQHandler"));
mixin(DefaultHandler!("I2C2_ER_IRQHandler"));
mixin(DefaultHandler!("SPI1_IRQHandler"));
mixin(DefaultHandler!("SPI2_IRQHandler"));
mixin(DefaultHandler!("USART1_IRQHandler"));
mixin(DefaultHandler!("USART2_IRQHandler"));
mixin(DefaultHandler!("USART3_IRQHandler"));
mixin(DefaultHandler!("EXTI15_10_IRQHandler"));
mixin(DefaultHandler!("RTC_Alarm_IRQHandler"));
mixin(DefaultHandler!("OTG_FS_WKUP_IRQHandler"));
mixin(DefaultHandler!("TIM8_BRK_TIM12_IRQHandler"));
mixin(DefaultHandler!("TIM8_UP_TIM13_IRQHandler"));
mixin(DefaultHandler!("TIM8_TRG_COM_TIM14_IRQHandler"));
mixin(DefaultHandler!("TIM8_CC_IRQHandler"));
mixin(DefaultHandler!("DMA1_Stream7_IRQHandler"));
mixin(DefaultHandler!("FSMC_IRQHandler"));
mixin(DefaultHandler!("SDIO_IRQHandler"));
mixin(DefaultHandler!("TIM5_IRQHandler"));
mixin(DefaultHandler!("SPI3_IRQHandler"));
mixin(DefaultHandler!("UART4_IRQHandler"));
mixin(DefaultHandler!("UART5_IRQHandler"));
mixin(DefaultHandler!("TIM6_DAC_IRQHandler"));
mixin(DefaultHandler!("TIM7_IRQHandler"));
mixin(DefaultHandler!("DMA2_Stream0_IRQHandler"));
mixin(DefaultHandler!("DMA2_Stream1_IRQHandler"));
mixin(DefaultHandler!("DMA2_Stream2_IRQHandler"));
mixin(DefaultHandler!("DMA2_Stream3_IRQHandler"));
mixin(DefaultHandler!("DMA2_Stream4_IRQHandler"));
mixin(DefaultHandler!("ETH_IRQHandler"));
mixin(DefaultHandler!("ETH_WKUP_IRQHandler"));
mixin(DefaultHandler!("CAN2_TX_IRQHandler"));
mixin(DefaultHandler!("CAN2_RX0_IRQHandler"));
mixin(DefaultHandler!("CAN2_RX1_IRQHandler"));
mixin(DefaultHandler!("CAN2_SCE_IRQHandler"));
mixin(DefaultHandler!("OTG_FS_IRQHandler"));
mixin(DefaultHandler!("DMA2_Stream5_IRQHandler"));
mixin(DefaultHandler!("DMA2_Stream6_IRQHandler"));
mixin(DefaultHandler!("DMA2_Stream7_IRQHandler"));
mixin(DefaultHandler!("USART6_IRQHandler"));
mixin(DefaultHandler!("I2C3_EV_IRQHandler"));
mixin(DefaultHandler!("I2C3_ER_IRQHandler"));
mixin(DefaultHandler!("OTG_HS_EP1_OUT_IRQHandler"));
mixin(DefaultHandler!("OTG_HS_EP1_IN_IRQHandler"));
mixin(DefaultHandler!("OTG_HS_WKUP_IRQHandler"));
mixin(DefaultHandler!("OTG_HS_IRQHandler"));
mixin(DefaultHandler!("DCMI_IRQHandler"));
mixin(DefaultHandler!("HASH_RNG_IRQHandler"));
mixin(DefaultHandler!("FPU_IRQHandler"));

@naked extern(C) void Reset_Handler()
{
    Main();
    
    while(true)
    {
    }
}

@(section(".stack")) __gshared static long[0x800] stack;

@(section(".interrupt_vector"))
VectorFunc[98] interruptVectorTable = [
    cast(VectorFunc)&stack,                                                        /* -16 $0000 Initial Stack Pointer */
    &Reset_Handler,                                                                    /* -15 $0004 Reset Vector */
    &NMI_Handler,                                                                    /* -14 $0008 Non Maskable Interrupt Vector */
    &HardFault_Handler,                                                                /* -13 $000c Hard Fault Vector */
    &MemManage_Handler,                                                                /* -12 $0010 Memory Protection Unit Fault Vector */
    &BusFault_Handler,                                                                /* -11 $0014 Bus Fault Vector */
    &UsageFault_Handler,                                                            /* -10 $0018 Usage Fault Vector */
    cast(VectorFunc)0,                                                                /*  -9 $001c Reserved */
    cast(VectorFunc)0,                                                                /*  -8 $0020 Reserved */
    cast(VectorFunc)0,                                                                /*  -7 $0024 Reserved */
    cast(VectorFunc)0,                                                                /*  -6 $0028 Reserved */
    &SVC_Handler,                                                                    /*  -5 $002c SuperVisor Call Vector */
    &DebugMon_Handler,                                                                /*  -4 $0030 Debug Monitor Vector */
    cast(VectorFunc)0,                                                                /*  -3 $0034 Reserved */
    &PendSV_Handler,                                                                /*  -2 $0038 Pending SuperVisor Vector */
    &SysTick_Handler,                                                                /*  -1 $003c System Tick Vector */
    &WWDG_IRQHandler,                                                                /*   0 $0040 Windowed WatchDog */
    &PVD_IRQHandler,                                                                /*   1 $0044 PVD through EXTI Line detection */
    &TAMP_STAMP_IRQHandler,                                                            /*   2 $0048 Tamper and TimeStamps through the EXTI line */
    &RTC_WKUP_IRQHandler,                                                            /*   3 $004c RTC Wakeup through the EXTI line */
    &FLASH_IRQHandler,                                                                /*   4 $0050 FLASH */
    &RCC_IRQHandler,                                                                /*   5 $0054 RCC */
    &EXTI0_IRQHandler,                                                                /*   6 $0058 EXTI Line0 */
    &EXTI1_IRQHandler,                                                                /*   7 $005c EXTI Line1 */
    &EXTI2_IRQHandler,                                                                /*   8 $0060 EXTI Line2 */
    &EXTI3_IRQHandler,                                                                /*   9 $0064 EXTI Line3 */
    &EXTI4_IRQHandler,                                                                /*  10 $0068 EXTI Line4 */
    &DMA1_Stream0_IRQHandler,                                                        /*  11 $006c DMA1 Stream 0 */
    &DMA1_Stream1_IRQHandler,                                                        /*  12 $0070 DMA1 Stream 1 */
    &DMA1_Stream2_IRQHandler,                                                        /*  13 $0074 DMA1 Stream 2 */
    &DMA1_Stream3_IRQHandler,                                                        /*  14 $0078 DMA1 Stream 3 */
    &DMA1_Stream4_IRQHandler,                                                        /*  15 $007c DMA1 Stream 4 */
    &DMA1_Stream5_IRQHandler,                                                        /*  16 $0080 DMA1 Stream 5 */
    &DMA1_Stream6_IRQHandler,                                                        /*  17 $0084 DMA1 Stream 6 */
    &ADC_IRQHandler,                                                                /*  18 $0088 ADC1, ADC2 and ADC3s */
    &CAN1_TX_IRQHandler,                                                            /*  19 $008c CAN1 TX */
    &CAN1_RX0_IRQHandler,                                                            /*  20 $0090 CAN1 RX0 */
    &CAN1_RX1_IRQHandler,                                                            /*  21 $0094 CAN1 RX1 */
    &CAN1_SCE_IRQHandler,                                                            /*  22 $0098 CAN1 SCE */
    &EXTI9_5_IRQHandler,                                                            /*  23 $009c External Line[9:5]s */
    &TIM1_BRK_TIM9_IRQHandler,                                                        /*  24 $00a0 TIM1 Break and TIM9 */
    &TIM1_UP_TIM10_IRQHandler,                                                        /*  25 $00a4 TIM1 Update and TIM10 */
    &TIM1_TRG_COM_TIM11_IRQHandler,                                                    /*  26 $00a8 TIM1 Trigger and Commutation and TIM11 */
    &TIM1_CC_IRQHandler,                                                            /*  27 $00ac TIM1 Capture Compare */
    &TIM2_IRQHandler,                                                                /*  28 $00b0 TIM2 */
    &TIM3_IRQHandler,                                                                /*  29 $00b4 TIM3 */
    &TIM4_IRQHandler,                                                                /*  30 $00b8 TIM4 */
    &I2C1_EV_IRQHandler,                                                            /*  31 $00bc I2C1 Event */
    &I2C1_ER_IRQHandler,                                                            /*  32 $00c0 I2C1 Error */
    &I2C2_EV_IRQHandler,                                                            /*  33 $00c4 I2C2 Event */
    &I2C2_ER_IRQHandler,                                                            /*  34 $00c8 I2C2 Error */
    &SPI1_IRQHandler,                                                                /*  35 $00cc SPI1 */
    &SPI2_IRQHandler,                                                                /*  36 $00d0 SPI2 */
    &USART1_IRQHandler,                                                                /*  37 $00d4 USART1 */
    &USART2_IRQHandler,                                                                /*  38 $00d8 USART2 */
    &USART3_IRQHandler,                                                                /*  39 $00dc USART3 */
    &EXTI15_10_IRQHandler,                                                            /*  40 $00e0 External Line[15:10]s */
    &RTC_Alarm_IRQHandler,                                                            /*  41 $00e4 RTC Alarm (A and B) through EXTI Line */
    &OTG_FS_WKUP_IRQHandler,                                                        /*  42 $00e8 USB OTG FS Wakeup through EXTI line */
    &TIM8_BRK_TIM12_IRQHandler,                                                        /*  43 $00ec TIM8 Break and TIM12 */
    &TIM8_UP_TIM13_IRQHandler,                                                        /*  44 $00f0 TIM8 Update and TIM13 */
    &TIM8_TRG_COM_TIM14_IRQHandler,                                                    /*  45 $00f4 TIM8 Trigger and Commutation and TIM14 */
    &TIM8_CC_IRQHandler,                                                            /*  46 $00f8 TIM8 Capture Compare */
    &DMA1_Stream7_IRQHandler,                                                        /*  47 $00fc DMA1 Stream7 */
    &FSMC_IRQHandler,                                                                /*  48 $0100 FSMC */
    &SDIO_IRQHandler,                                                                /*  49 $0104 SDIO */
    &TIM5_IRQHandler,                                                                /*  50 $0108 TIM5 */
    &SPI3_IRQHandler,                                                                /*  51 $010c SPI3 */
    &UART4_IRQHandler,                                                                /*  52 $0110 UART4 */
    &UART5_IRQHandler,                                                                /*  53 $0114 UART5 */
    &TIM6_DAC_IRQHandler,                                                            /*  54 $0118 TIM6 and DAC1&2 underrun errors */
    &TIM7_IRQHandler,                                                                /*  55 $011c TIM7 */
    &DMA2_Stream0_IRQHandler,                                                        /*  56 $0120 DMA2 Stream 0 */
    &DMA2_Stream1_IRQHandler,                                                        /*  57 $0124 DMA2 Stream 1 */
    &DMA2_Stream2_IRQHandler,                                                        /*  58 $0128 DMA2 Stream 2 */
    &DMA2_Stream3_IRQHandler,                                                        /*  59 $012c DMA2 Stream 3 */
    &DMA2_Stream4_IRQHandler,                                                        /*  60 $0130 DMA2 Stream 4 */
    &ETH_IRQHandler,                                                                /*  61 $0134 Ethernet */
    &ETH_WKUP_IRQHandler,                                                            /*  62 $0138 Ethernet Wakeup through EXTI line */
    &CAN2_TX_IRQHandler,                                                            /*  63 $013c CAN2 TX */
    &CAN2_RX0_IRQHandler,                                                            /*  64 $0140 CAN2 RX0 */
    &CAN2_RX1_IRQHandler,                                                            /*  65 $0144 CAN2 RX1 */
    &CAN2_SCE_IRQHandler,                                                            /*  66 $0148 CAN2 SCE */
    &OTG_FS_IRQHandler,                                                                /*  67 $014c USB OTG FS */
    &DMA2_Stream5_IRQHandler,                                                        /*  68 $0150 DMA2 Stream 5 */
    &DMA2_Stream6_IRQHandler,                                                        /*  69 $0154 DMA2 Stream 6 */
    &DMA2_Stream7_IRQHandler,                                                        /*  70 $0158 DMA2 Stream 7 */
    &USART6_IRQHandler,                                                                /*  71 $015c USART6 */
    &I2C3_EV_IRQHandler,                                                            /*  72 $0160 I2C3 event */
    &I2C3_ER_IRQHandler,                                                            /*  73 $0164 I2C3 error */
    &OTG_HS_EP1_OUT_IRQHandler,                                                        /*  74 $0168 USB OTG HS End Point 1 Out */
    &OTG_HS_EP1_IN_IRQHandler,                                                        /*  75 $016c USB OTG HS End Point 1 In */
    &OTG_HS_WKUP_IRQHandler,                                                        /*  76 $0170 USB OTG HS Wakeup through EXTI */
    &OTG_HS_IRQHandler,                                                                /*  77 $0174 USB OTG HS */
    &DCMI_IRQHandler,                                                                /*  78 $0178 DCMI */
    cast(VectorFunc)0,                                                                /*  79 $017c Reserved */
    &HASH_RNG_IRQHandler,                                                            /*  80 $0180 Hash and Rng */
    &FPU_IRQHandler
];
