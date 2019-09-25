package com.eview.myapplication.EV07B;

/**
 * Created by chenming on 2018/3/21.haha
 */

public class Constant {

    static final public double E7 =  Math.pow(10,7);

    public enum BTReturnCode {

        Success(0x00),
        InvalidVersion(0x11),
        InvalidEncryption(0x12),
        LengthError(0x13),
        CheckSumError(0x14),
        InvalidCommand(0x15),
        InvalidKey(0x16),
        KeyLengthError(0x17),

        InvalidDataFormat(0x21),
        DataSizeError(0x22),
        InvalidState(0x23),
        InvalidParameter(0x24),
        NoMem(0x25),
        FunctionNotSupport(0x26),
        GPSNotReady(0x27),
        AddressResp(0x28),
        BatteryPowerLow(0xf0);

        private int value;

        public int getValue() {
            return value;
        }

        BTReturnCode(int value) {
            this.value = value;
        }

    }

    public enum BTService {

        Data(0x01),
        Config(0x02),
        Service(0x03),
        SystemControl(0x04),
        FirmwareUpdate(0x7e),
        NegativeRes(0x7f),
        FactoryTest(0xfe);

        private long value;

        public long getValue() {
            return value;
        }

        BTService(long value) {
            this.value = value;
        }
    }

    public enum BTConfiguration {
        //-------------General---------------
        ModuleNumber((long)1,0x01),
        FirmwareVersion((long)1<<1,0x02),
        Imei((long)1<<2,0x03),
        ICCID((long)1<<3,0x04),
        Mac((long)1<<4,0x05),
        SettingTime((long)1<<5,0x06),
        RunTime((long)1<<6,0x07),
        FirmwareInformation((long)1<<7,0x08),
        InitializeMileage((long)1<<8,0x09),
        //-------------System Setting---------------
        Mode((long)1<<9,0x0a),
        AlarmClock((long)1<<10,0x0b),
        NoDisturb((long)1<<11,0x0c),
        PasswordProtect((long)1<<12,0x0d),
        TimeZone((long)1<<13,0x0e),
        EnableControl((long)1<<14,0x0f),
        RingToneVolume((long)1<<15,0x10),
        MicVolume((long)1<<16,0x11),
        SpeakVolume((long)1<<17,0x12),
        DeviceName((long)1<<18,0x13),
        //-------------Button Setting---------------
        SosButtonSetting((long)1<<19,0x20),
        Call1ButtonSetting((long)1<<20,0x21),
        Call2ButtonSetting((long)1<<21,0x22),
        //-------------Phone Settings---------------
        AuthorizeContacts((long)1<<22,0x30),
        SmsReplyPrefixText((long)1<<23,0x31),
        SosOption((long)1<<24,0x32),
        PhoneSwitches((long)1<<25,0x33),
        //-------------GPRS Setting---------------
        Apn((long)1<<26,0x40),
        ApnUserName((long)1<<27,0x41),
        ApnPassword((long)1<<28,0x42),
        Ip((long)1<<29,0x43),
        Time((long)1<<30,0x44),
        ContinueLocTime((long)1<<31,0x45),
        //-------------Alert Settings---------------
        AlertPower((long)1<<32,0x50),
        AlertGEO((long)1<<33,0x51),
        AlertMotion((long)1<<34,0x52),
        AlertNoMotion((long)1<<35,0x53),
        AlertSpeed((long)1<<36,0x54),
        AlertTilt((long)1<<37,0x55),
        AlertFallDown((long)1<<38,0x56);


        private long type;
        private long value;

        public long getType() {
            return type;
        }

        public long getValue() {
            return value;
        }

        BTConfiguration(long type, long value) {
            this.type = type;
            this.value = value;
        }
    }

    public enum BTOperation {
        //0xfe value is  no use
        Read(0xf0),SaveSetting(0xfe);

        private long value;

        public long getValue() {
            return value;
        }

        BTOperation(long value) {
            this.value = value;
        }
    }

    public enum BTSystemControl {

        ResetAllRecord(0x10),
        FactoryRecovery(0x11),
        DeviceReboot(0x12),
        FindMe(0x13),
        PowerOff(0x14);

        private long value;

        public long getValue() {
            return value;
        }

        BTSystemControl(long value) {
            this.value = value;
        }
    }
}
