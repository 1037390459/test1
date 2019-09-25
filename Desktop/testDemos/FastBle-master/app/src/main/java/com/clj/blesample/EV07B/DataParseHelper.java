package com.eview.myapplication.EV07B;

import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;

import static java.nio.charset.StandardCharsets.US_ASCII;
import static java.nio.charset.StandardCharsets.UTF_8;

/**
 * Created by chenming on 2018/3/23.haha
 */

public class DataParseHelper<T> {
    //-------------General---------------
    interface Parser<T> {
        T parseData(byte[] data);

        byte[] archive(T value);
    }

    static HashMap<Long, Parser> parserHashMap = new HashMap<Long, Parser>() {
        {
            //----------------General---------------------------
            put(Constant.BTConfiguration.ModuleNumber.getValue(), new ModuleNum());
            put(Constant.BTConfiguration.FirmwareVersion.getValue(), new FirmwareVersion());
            put(Constant.BTConfiguration.Imei.getValue(), new IMEI());
            put(Constant.BTConfiguration.ICCID.getValue(), new ICCID());
            put(Constant.BTConfiguration.Mac.getValue(), new MAC());
            put(Constant.BTConfiguration.SettingTime.getValue(), new SettingTime());
            put(Constant.BTConfiguration.RunTime.getValue(), new RunTime());
            put(Constant.BTConfiguration.InitializeMileage.getValue(), new InitializeMileage());
            //----------------System Setting---------------------
            put(Constant.BTConfiguration.Mode.getValue(), new Mode());
            put(Constant.BTConfiguration.AlarmClock.getValue(), new AlarmClock());
            put(Constant.BTConfiguration.NoDisturb.getValue(), new NoDisturb());
            put(Constant.BTConfiguration.PasswordProtect.getValue(), new PasswordProtect());
            put(Constant.BTConfiguration.TimeZone.getValue(), new TimeZone());
            put(Constant.BTConfiguration.EnableControl.getValue(), new EnableControl());
            put(Constant.BTConfiguration.RingToneVolume.getValue(), new RingToneVolume());
            put(Constant.BTConfiguration.MicVolume.getValue(), new MicVolume());
            put(Constant.BTConfiguration.SpeakVolume.getValue(), new SpeakerVolume());
            put(Constant.BTConfiguration.DeviceName.getValue(), new DeviceName());
            //-------------Button Setting---------------
            put(Constant.BTConfiguration.SosButtonSetting.getValue(), new DeviceName());
            put(Constant.BTConfiguration.Call1ButtonSetting.getValue(), new DeviceName());
            put(Constant.BTConfiguration.Call2ButtonSetting.getValue(), new DeviceName());
            //----------------Phone Settings---------------------
            put(Constant.BTConfiguration.AuthorizeContacts.getValue(), new AuthorizedContacts());
            put(Constant.BTConfiguration.SmsReplyPrefixText.getValue(), new SMSReplyPrefixText());
            put(Constant.BTConfiguration.SosOption.getValue(), new SOSOption());
            put(Constant.BTConfiguration.PhoneSwitches.getValue(), new PhoneSwitches());
            //----------------GPRS Setting------------------------
            put(Constant.BTConfiguration.Apn.getValue(), new APN());
            put(Constant.BTConfiguration.Ip.getValue(), new IP());
            put(Constant.BTConfiguration.Time.getValue(), new Time());
            //----------------Alert Settings------------------------
            put(Constant.BTConfiguration.AlertPower.getValue(), new PowerAlert());
            put(Constant.BTConfiguration.AlertGEO.getValue(), new GeoAlert());
            put(Constant.BTConfiguration.AlertMotion.getValue(), new MotionAlert());
            put(Constant.BTConfiguration.AlertNoMotion.getValue(), new NoMotionAlert());
            put(Constant.BTConfiguration.AlertSpeed.getValue(), new SpeedAlert());
            put(Constant.BTConfiguration.AlertTilt.getValue(), new TiltAlert());
            put(Constant.BTConfiguration.AlertFallDown.getValue(), new FallDownAlert());
        }
    };


    static Parser getParser(long key) {
        return parserHashMap.get(key);
    }

    final static String EV07B_KEY09_INIT_MILE = "EV07B_KEY09_INIT_MILE";

    final static String EV07B_KEY0A_INTERVAL = "EV07B_KEY0A_INTERVAL";
    final static String EV07B_KEY0A_MODE = "EV07B_KEY0A_MODE";

    final static String EV07B_KEY0B_ENABLE = "EV07B_KEY0B_ENABLE";
    final static String EV07B_KEY0B_INDEX = "EV07B_KEY0B_INDEX";
    final static String EV07B_KEY0B_HOUR = "EV07B_KEY0B_HOUR";
    final static String EV07B_KEY0B_MIN = "EV07B_KEY0B_MIN";
    final static String EV07B_KEY0B_WORKDAY = "EV07B_KEY0B_WORKDAY";
    final static String EV07B_KEY0B_TIME = "EV07B_KEY0B_TIME";
    final static String EV07B_KEY0B_RING = "EV07B_KEY0B_RING";

    final static String EV07B_KEY0C_FLAG = "EV07B_KEY0C_FLAG";
    final static String EV07B_KEY0C_SH = "EV07B_KEY0C_SH";
    final static String EV07B_KEY0C_SM = "EV07B_KEY0C_SM";
    final static String EV07B_KEY0C_EH = "EV07B_KEY0C_EH";
    final static String EV07B_KEY0C_EM = "EV07B_KEY0C_EM";

    final static String EV07B_KEY0D_VALUE = "EV07B_KEY0D_VALUE";
    final static String EV07B_KEY0D_ENABLE = "EV07B_KEY0D_ENABLE";

    final static String EV07B_KEY0E_TIME_ZONE = "EV07B_KEY0E_TIME_ZONE";

    final static String EV07B_KEY0F_AGPS = "EV07B_KEY0F_AGPS";
    final static String EV07B_KEY0F_AUTO_UPDATE = "EV07B_KEY0F_AUTO_UPDATE";
    final static String EV07B_KEY0F_MOTO = "EV07B_KEY0F_MOTO";
    final static String EV07B_KEY0F_BEEP = "EV07B_KEY0F_BEEP";
    final static String EV07B_KEY0F_LEDS = "EV07B_KEY0F_LEDS";

    final static String EV07B_KEY10_RING_VOLUME = "EV07B_KEY10_RING_VOLUME";

    final static String EV07B_KEY11_MIC_VOLUME = "EV07B_KEY11_MIC_VOLUME";

    final static String EV07B_KEY12_SPEAKER_VOLUME = "EV07B_KEY12_SPEAKER_VOLUME";

    final static String EV07B_KEY13_DEVICE_NAME = "EV07B_KEY13_DEVICE_NAME";

    final static String EV07B_KEY2X_BUTTON_TYPE = "EV07B_KEY2X_BUTTON_TYPE";
    final static String EV07B_KEY20_ENABLE = "EV07B_KEY20_ENABLE";
    final static String EV07B_KEY20_MODE = "EV07B_KEY20_MODE";
    final static String EV07B_KEY20_TASK = "EV07B_KEY20_TASK";
    final static String EV07B_KEY20_TIME = "EV07B_KEY20_TIME";
    final static String EV07B_KEY20_FEEDBACK = "EV07B_KEY20_FEEDBACK";

    final static String EV07B_KEY21_ENABLE = "EV07B_KEY21_ENABLE";
    final static String EV07B_KEY21_MODE = "EV07B_KEY21_MODE";
    final static String EV07B_KEY21_TASK = "EV07B_KEY21_TASK";
    final static String EV07B_KEY21_TIME = "EV07B_KEY21_TIME";
    final static String EV07B_KEY21_FEEDBACK = "EV07B_KEY21_FEEDBACK";

    final static String EV07B_KEY22_ENABLE = "EV07B_KEY22_ENABLE";
    final static String EV07B_KEY22_MODE = "EV07B_KEY22_MODE";
    final static String EV07B_KEY22_TASK = "EV07B_KEY22_TASK";
    final static String EV07B_KEY22_TIME = "EV07B_KEY22_TIME";
    final static String EV07B_KEY22_FEEDBACK = "EV07B_KEY22_FEEDBACK";

    final static String EV07B_KEY30_VALUE = "EV07B_KEY30_VALUE";
    final static String EV07B_KEY30_NOCARD = "EV07B_KEY30_NOCARD";
    final static String EV07B_KEY30_PHONE = "EV07B_KEY30_PHONE";
    final static String EV07B_KEY30_SMS = "EV07B_KEY30_SMS";
    final static String EV07B_KEY30_ENABLE = "EV07B_KEY30_ENABLE";
    final static String EV07B_KEY30_NUMBER = "EV07B_KEY30_NUMBER";

    final static String EV07B_KEY31_TEXT = "EV07B_KEY31_TEXT";

    final static String EV07B_KEY32_HOLD_TIME = "EV07B_KEY32_HOLD_TIME";
    final static String EV07B_KEY32_RINGS_TIME = "EV07B_KEY32_RINGS_TIME";
    final static String EV07B_KEY32_CYCLE = "EV07B_KEY32_CYCLE";

    final static String EV07B_KEY33_AFTER_RINGS = "EV07B_KEY33_AFTER_RINGS";
    final static String EV07B_KEY33_AUTO_ANSWER = "EV07B_KEY33_AUTO_ANSWER";
    final static String EV07B_KEY33_AUTHORIZED_CALL = "EV07B_KEY33_AUTHORIZED_CALL";
    final static String EV07B_KEY33_HANG_UP = "EV07B_KEY33_HANG_UP";
    final static String EV07B_KEY33_LISTEN_IN = "EV07B_KEY33_LISTEN_IN";
    final static String EV07B_KEY33_AUTHORIZED_SMS = "EV07B_KEY33_AUTHORIZED_SMS";

    final static String EV07B_KEY40_APN = "EV07B_KEY40_APN";

    final static String EV07B_KEY41_USER_NAME = "EV07B_KEY41_USER_NAME";

    final static String EV07B_KEY42_PASSWORD = "EV07B_KEY42_PASSWORD";

    final static String EV07B_KEY43_UDP = "EV07B_KEY43_UDP";
    final static String EV07B_KEY43_ENABLE = "EV07B_KEY43_ENABLE";
    final static String EV07B_KEY43_PORT = "EV07B_KEY43_PORT";
    final static String EV07B_KEY43_IP = "EV07B_KEY43_IP";

    final static String EV07B_KEY44_HEART_BEAT = "EV07B_KEY44_HEART_BEAT";
    final static String EV07B_KEY44_HEART_BEAT_ENABLE = "EV07B_KEY44_HEART_BEAT_ENABLE";
    final static String EV07B_KEY44_UPLOAD = "EV07B_KEY44_UPLOAD";
    final static String EV07B_KEY44_UPLOAD_LAZY = "EV07B_KEY44_UPLOAD_LAZY";

    final static String EV07B_KEY45_INTERVAL = "EV07B_KEY45_INTERVAL";
    final static String EV07B_KEY45_TIME = "EV07B_KEY45_TIME";

    final static String EV07B_KEY50_THRESHOLD = "EV07B_KEY50_THRESHOLD";
    final static String EV07B_KEY50_LOW = "EV07B_KEY50_LOW";
    final static String EV07B_KEY50_ON = "EV07B_KEY50_ON";
    final static String EV07B_KEY50_OFF = "EV07B_KEY50_OFF";

    final static String EV07B_KEY51_INDEX = "EV07B_KEY51_INDEX";
    final static String EV07B_KEY51_POINTS = "EV07B_KEY51_POINTS";
    final static String EV07B_KEY51_ENABLE = "EV07B_KEY51_ENABLE";
    final static String EV07B_KEY51_DIRECTION = "EV07B_KEY51_DIRECTION";
    final static String EV07B_KEY51_TYPE = "EV07B_KEY51_TYPE";
    final static String EV07B_KEY51_RADIUS = "EV07B_KEY51_RADIUS";
    final static String EV07B_KEY51_LATLNGS = "EV07B_KEY51_LATLNGS";

    final static String EV07B_KEY52_SET_TIME = "EV07B_KEY52_SET_TIME";
    final static String EV07B_KEY52_ACTIVE_TIME = "EV07B_KEY52_ACTIVE_TIME";
    final static String EV07B_KEY52_ENABLE = "EV07B_KEY52_ENABLE";

    final static String EV07B_KEY53_NO_MOTION_TIME = "EV07B_KEY53_NO_MOTION_TIME";
    final static String EV07B_KEY53_ENABLE = "EV07B_KEY53_ENABLE";

    final static String EV07B_KEY54_SPEED = "EV07B_KEY54_SPEED";
    final static String EV07B_KEY54_ENABLE = "EV07B_KEY54_ENABLE";

    final static String EV07B_KEY55_TIME_THRESHOLD = "EV07B_KEY55_TIME_THRESHOLD";
    final static String EV07B_KEY55_ANGLE_THRESHOLD = "EV07B_KEY55_ANGLE_THRESHOLD";
    final static String EV07B_KEY55_ENABLE = "EV07B_KEY55_ENABLE";

    final static String EV07B_KEY56_LEVEL = "EV07B_KEY56_LEVEL";
    final static String EV07B_KEY56_DIAL = "EV07B_KEY56_DIAL";
    final static String EV07B_KEY56_ENABLE = "EV07B_KEY56_ENABLE";


    static class ModuleNum implements Parser<String> {
        public ModuleNum() {
        }

        @Override
        public String parseData(byte[] data) {
            long moduleNum = ByteBuffer.wrap(data).getLong();
            return String.format(Locale.getDefault(), "%d", moduleNum);
        }

        @Override
        public byte[] archive(String value) {
            throw new RuntimeException("not implement");
        }
    }

    static class FirmwareVersion implements Parser<String> {

        @Override
        public String parseData(byte[] data) {
            return String.format(Locale.getDefault(), "v%d.%d.%d.%d",
                    BytesUtil.get(data[3]), BytesUtil.get(data[2]),
                    BytesUtil.get(data[1]), BytesUtil.get(data[0]));
        }

        @Override
        public byte[] archive(String value) {
            throw new RuntimeException("not implement");
        }
    }

    static class IMEI implements Parser<String> {

        @Override
        public String parseData(byte[] data) {
            return new String(data, US_ASCII);
        }

        @Override
        public byte[] archive(String value) {
            throw new RuntimeException("not implement");
        }
    }

    static class ICCID implements Parser<String> {

        @Override
        public String parseData(byte[] data) {
            return new String(data, US_ASCII);
        }

        @Override
        public byte[] archive(String value) {
            throw new RuntimeException("not implement");
        }
    }

    static class MAC implements Parser<String> {

        @Override
        public String parseData(byte[] data) {
            return String.format(Locale.getDefault(), "%X-%X-%X-%X-%X-%X",
                    BytesUtil.get(data[5]), BytesUtil.get(data[4]),
                    BytesUtil.get(data[3]), BytesUtil.get(data[2]),
                    BytesUtil.get(data[1]), BytesUtil.get(data[0]));
        }

        @Override
        public byte[] archive(String value) {
            throw new RuntimeException("not implement");
        }
    }

    static class SettingTime implements Parser<String> {

        @Override
        public String parseData(byte[] data) {
            long timestamp = ByteBuffer.wrap(data).getLong() * 1000;
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault());
            Date date = new Date(timestamp);
            return sdf.format(date);
        }

        @Override
        public byte[] archive(String value) {
            throw new RuntimeException("not implement");
        }
    }

    static class RunTime implements Parser<String> {

        @Override
        public String parseData(byte[] data) {
            long runTime = ByteBuffer.wrap(data).getLong();
            return String.format(Locale.getDefault(), "%d", runTime);
        }

        @Override
        public byte[] archive(String value) {
            throw new RuntimeException("not implement");
        }
    }

    static class InitializeMileage implements Parser<HashMap<String, String>> {

        @Override
        public HashMap<String, String> parseData(byte[] data) {
            HashMap<String, String> map = new HashMap<String, String>();
            long mile = ByteBuffer.wrap(data).getLong();
            map.put(EV07B_KEY09_INIT_MILE, String.format(Locale.getDefault(), "%d", mile));
            return map;
        }

        @Override
        public byte[] archive(HashMap<String, String> value) {
            HashMap<String, String> map = new HashMap<String, String>();
            int mile = Integer.valueOf(value.get(EV07B_KEY09_INIT_MILE));
            ByteBuffer b = ByteBuffer.allocate(4);
            b.order(ByteOrder.LITTLE_ENDIAN);
            b.putInt(mile);
            return b.array();
        }
    }

    //-------------System Setting---------------
    static class Mode implements Parser<HashMap<String, String>> {

        @Override
        public HashMap<String, String> parseData(byte[] data) {
            HashMap<String, String> map = new HashMap<String, String>();
            int interval = ByteBuffer.wrap(data, 0, 3).getInt();
            int mode = ByteBuffer.wrap(data, 3, 1).getInt();
            map.put(EV07B_KEY0A_INTERVAL, String.format(Locale.getDefault(), "%d", interval));
            map.put(EV07B_KEY0A_MODE, String.format(Locale.getDefault(), "%d", mode));
            return map;
        }

        @Override
        public byte[] archive(HashMap<String, String> value) {
            int interval = Integer.valueOf(value.get(EV07B_KEY0A_INTERVAL));
            int mode = Integer.valueOf(value.get(EV07B_KEY0A_MODE));
            int val = interval | (mode << 24);
            ByteBuffer b = ByteBuffer.allocate(4);
            b.order(ByteOrder.LITTLE_ENDIAN);
            b.putInt(val);
            return b.array();
        }
    }

    static class AlarmClock implements Parser<HashMap<String, String>> {

        @Override
        public HashMap<String, String> parseData(byte[] data) {
            HashMap<String, String> map = new HashMap<String, String>();
            byte enable = (byte) (data[0]>>7);
            byte index = (byte) (data[0] & 0x7f);
            byte hour = data[1];
            byte min = data[2];
            byte workDay = data[3];
            byte time = data[4];
            byte ring = data[5];
            map.put(EV07B_KEY0B_ENABLE, String.format(Locale.getDefault(), "%d", BytesUtil.get(enable)));
            map.put(EV07B_KEY0B_INDEX, String.format(Locale.getDefault(), "%d", BytesUtil.get(index)));
            map.put(EV07B_KEY0B_HOUR, String.format(Locale.getDefault(), "%d", BytesUtil.get(hour)));
            map.put(EV07B_KEY0B_MIN, String.format(Locale.getDefault(), "%d", BytesUtil.get(min)));
            map.put(EV07B_KEY0B_WORKDAY, String.format(Locale.getDefault(), "%d", BytesUtil.get(workDay)));
            map.put(EV07B_KEY0B_TIME, String.format(Locale.getDefault(), "%d", BytesUtil.get(time)));
            map.put(EV07B_KEY0B_RING, String.format(Locale.getDefault(), "%d", BytesUtil.get(ring)));
            return map;
        }

        @Override
        public byte[] archive(HashMap<String, String> value) {
            byte enable = Byte.valueOf(value.get(EV07B_KEY0B_ENABLE));
            byte index = Byte.valueOf(value.get(EV07B_KEY0B_INDEX));
            byte hour = Byte.valueOf(value.get(EV07B_KEY0B_HOUR));
            byte min = Byte.valueOf(value.get(EV07B_KEY0B_MIN));
            byte workDay = Byte.valueOf(value.get(EV07B_KEY0B_WORKDAY));
            byte time = Byte.valueOf(value.get(EV07B_KEY0B_TIME));
            byte ring = Byte.valueOf(value.get(EV07B_KEY0B_RING));
            ByteBuffer b = ByteBuffer.allocate(6);
            b.order(ByteOrder.LITTLE_ENDIAN);
            b.put((byte) (index + (enable<<7)));
            b.put(hour);
            b.put(min);
            b.put(workDay);
            b.put(time);
            b.put(ring);
            return b.array();
        }
    }

    static class NoDisturb implements Parser<HashMap<String, String>> {

        @Override
        public HashMap<String, String> parseData(byte[] data) {
            HashMap<String, String> map = new HashMap<String, String>();
            map.put(EV07B_KEY0C_FLAG, String.format(Locale.getDefault(), "%d", BytesUtil.get(data[0]>>7)));
            map.put(EV07B_KEY0C_SH, String.format(Locale.getDefault(), "%d", BytesUtil.get(data[1])));
            map.put(EV07B_KEY0C_SM, String.format(Locale.getDefault(), "%d", BytesUtil.get(data[2])));
            map.put(EV07B_KEY0C_EH, String.format(Locale.getDefault(), "%d", BytesUtil.get(data[3])));
            map.put(EV07B_KEY0C_EM, String.format(Locale.getDefault(), "%d", BytesUtil.get(data[4])));
            return map;
        }

        @Override
        public byte[] archive(HashMap<String, String> value) {
            byte flag = Byte.valueOf(value.get(EV07B_KEY0C_FLAG));
            byte sh = Byte.valueOf(value.get(EV07B_KEY0C_SH));
            byte sm = Byte.valueOf(value.get(EV07B_KEY0C_SM));
            byte eh = Byte.valueOf(value.get(EV07B_KEY0C_EH));
            byte em = Byte.valueOf(value.get(EV07B_KEY0C_EM));
            ByteBuffer b = ByteBuffer.allocate(5);
            b.order(ByteOrder.LITTLE_ENDIAN);
            b.put((byte) (flag<<7));
            b.put(sh);
            b.put(sm);
            b.put(eh);
            b.put(em);
            return b.array();
        }
    }

    static class PasswordProtect implements Parser<HashMap<String, String>> {

        @Override
        public HashMap<String, String> parseData(byte[] data) {
            HashMap<String, String> map = new HashMap<String, String>();
            int val = ByteBuffer.wrap(data, 0, 4).getInt();
            int value = val<<1>>1;
            int enable = val>>31;
            map.put(EV07B_KEY0D_VALUE, String.format(Locale.getDefault(), "%d", value));
            map.put(EV07B_KEY0D_ENABLE, String.format(Locale.getDefault(), "%d", enable));
            return map;
        }

        @Override
        public byte[] archive(HashMap<String, String> value) {
            int v = Integer.valueOf(value.get(EV07B_KEY0D_VALUE));
            int enable = Integer.valueOf(value.get(EV07B_KEY0D_ENABLE));
            int val = v | (enable << 31);
            ByteBuffer b = ByteBuffer.allocate(4);
            b.order(ByteOrder.LITTLE_ENDIAN);
            b.putInt(val);
            return b.array();
        }
    }

    static class TimeZone implements Parser<HashMap<String, String>> {

        @Override
        public HashMap<String, String> parseData(byte[] data) {
            HashMap<String, String> map = new HashMap<String, String>();
            byte timeZone = data[0];
            map.put(EV07B_KEY0E_TIME_ZONE, String.format(Locale.getDefault(), "%d", timeZone));
            return map;
        }

        @Override
        public byte[] archive(HashMap<String, String> value) {
            byte timeZone = Byte.valueOf(value.get(EV07B_KEY0E_TIME_ZONE));
            ByteBuffer b = ByteBuffer.allocate(1);
            b.order(ByteOrder.LITTLE_ENDIAN);
            b.put(timeZone);
            return b.array();
        }
    }

    static class EnableControl implements Parser<HashMap<String, String>> {

        @Override
        public HashMap<String, String> parseData(byte[] data) {
            HashMap<String, String> map = new HashMap<String, String>();
            int agps = (data[3] >> 7) & 0x01;
            int autoUpdate = (data[3] >> 6) & 0x01;
            int motor = (data[0] >> 2) & 0x01;
            int buzzer = (data[0] >> 1) & 0x01;
            int leds = data[0] & 0x01;
            map.put(EV07B_KEY0F_AGPS, String.format(Locale.getDefault(), "%d", agps));
            map.put(EV07B_KEY0F_AUTO_UPDATE, String.format(Locale.getDefault(), "%d", autoUpdate));
            map.put(EV07B_KEY0F_MOTO, String.format(Locale.getDefault(), "%d", motor));
            map.put(EV07B_KEY0F_BEEP, String.format(Locale.getDefault(), "%d", buzzer));
            map.put(EV07B_KEY0F_LEDS, String.format(Locale.getDefault(), "%d", leds));
            return map;
        }

        @Override
        public byte[] archive(HashMap<String, String> value) {
            int agps = Integer.valueOf(value.get(EV07B_KEY0F_AGPS)) & 0x01;
            int autoUpdate = Integer.valueOf(value.get(EV07B_KEY0F_AUTO_UPDATE)) & 0x01;
            int motor = Integer.valueOf(value.get(EV07B_KEY0F_MOTO)) & 0x01;
            int buzzer = Integer.valueOf(value.get(EV07B_KEY0F_BEEP)) & 0x01;
            int leds = Integer.valueOf(value.get(EV07B_KEY0F_LEDS)) & 0x01;
            int val = (agps << 31) + (autoUpdate << 30) + (motor << 2) + (buzzer << 1) + leds;
            ByteBuffer b = ByteBuffer.allocate(4);
            b.order(ByteOrder.LITTLE_ENDIAN);
            b.putInt(val);
            return b.array();
        }
    }

    static class RingToneVolume implements Parser<HashMap<String, String>> {

        @Override
        public HashMap<String, String> parseData(byte[] data) {
            HashMap<String, String> map = new HashMap<String, String>();
            byte ring = data[0];
            map.put(EV07B_KEY10_RING_VOLUME, String.format(Locale.getDefault(), "%d", BytesUtil.get(ring)));
            return map;
        }

        @Override
        public byte[] archive(HashMap<String, String> value) {
            byte ring = Byte.valueOf(value.get(EV07B_KEY10_RING_VOLUME));
            ByteBuffer b = ByteBuffer.allocate(1);
            b.order(ByteOrder.LITTLE_ENDIAN);
            b.put(ring);
            return b.array();
        }
    }

    static class MicVolume implements Parser<HashMap<String, String>> {

        @Override
        public HashMap<String, String> parseData(byte[] data) {
            HashMap<String, String> map = new HashMap<String, String>();
            byte mic = data[0];
            map.put(EV07B_KEY11_MIC_VOLUME, String.format(Locale.getDefault(), "%d", BytesUtil.get(mic)));
            return map;
        }

        @Override
        public byte[] archive(HashMap<String, String> value) {
            byte ring = Byte.valueOf(value.get(EV07B_KEY11_MIC_VOLUME));
            ByteBuffer b = ByteBuffer.allocate(1);
            b.order(ByteOrder.LITTLE_ENDIAN);
            b.put(ring);
            return b.array();
        }
    }

    static class SpeakerVolume implements Parser<HashMap<String, String>> {

        @Override
        public HashMap<String, String> parseData(byte[] data) {
            HashMap<String, String> map = new HashMap<String, String>();
            byte speaker = data[0];
            map.put(EV07B_KEY12_SPEAKER_VOLUME, String.format(Locale.getDefault(), "%d", BytesUtil.get(speaker)));
            return map;
        }

        @Override
        public byte[] archive(HashMap<String, String> value) {
            byte ring = Byte.valueOf(value.get(EV07B_KEY12_SPEAKER_VOLUME));
            ByteBuffer b = ByteBuffer.allocate(1);
            b.order(ByteOrder.LITTLE_ENDIAN);
            b.put(ring);
            return b.array();
        }
    }

    static class DeviceName implements Parser<HashMap<String, String>> {

        @Override
        public HashMap<String, String> parseData(byte[] data) {
            HashMap<String, String> map = new HashMap<String, String>();
            String deviceName = new String(data, UTF_8);
            map.put(EV07B_KEY13_DEVICE_NAME, deviceName);
            return map;
        }

        @Override
        public byte[] archive(HashMap<String, String> value) {
            String deviceName = value.get(EV07B_KEY13_DEVICE_NAME);
            return deviceName.getBytes(UTF_8);
        }
    }

    //-------------Button Setting------------------------
    static class SosButtonSetting implements Parser<HashMap<String, String>> {

        @Override
        public HashMap<String, String> parseData(byte[] data) {
            HashMap<String, String> map = new HashMap<String, String>();
            int value = ByteBuffer.wrap(data, 0, 2).getInt();
            int feedback = value & 0x03;
            int time = (value >> 2) & 0x7f;
            int task = (value >> 9) & 0x0f;
            int mode = (value >> 13) & 0x01;
            int enable = (value >> 15) & 0x01;
            map.put(EV07B_KEY20_FEEDBACK, String.valueOf(feedback));
            map.put(EV07B_KEY20_TIME, String.valueOf(time));
            map.put(EV07B_KEY20_TASK, String.valueOf(task));
            map.put(EV07B_KEY20_MODE, String.valueOf(mode));
            map.put(EV07B_KEY20_ENABLE, String.valueOf(enable));
            return map;
        }

        @Override
        public byte[] archive(HashMap<String, String> value) {
            int feedback = Integer.valueOf(value.get(EV07B_KEY20_FEEDBACK));
            int time = Integer.valueOf(value.get(EV07B_KEY20_TIME));
            int task = Integer.valueOf(value.get(EV07B_KEY20_TASK));
            int mode = Integer.valueOf(value.get(EV07B_KEY20_MODE));
            int enable = Integer.valueOf(value.get(EV07B_KEY20_ENABLE));
            int val = (feedback + (time << 2) + (task << 9) + (mode << 13) + (enable << 15));
            ByteBuffer b = ByteBuffer.allocate(2);
            b.order(ByteOrder.LITTLE_ENDIAN);
            b.putInt(val);
            return b.array();
        }
    }

    static class Call1ButtonSetting implements Parser<HashMap<String, String>> {

        @Override
        public HashMap<String, String> parseData(byte[] data) {
            HashMap<String, String> map = new HashMap<String, String>();
            int value = ByteBuffer.wrap(data, 0, 2).getInt();
            int feedback = value & 0x03;
            int time = (value >> 2) & 0x7f;
            int task = (value >> 9) & 0x0f;
            int mode = (value >> 13) & 0x01;
            int enable = (value >> 15) & 0x01;
            map.put(EV07B_KEY21_FEEDBACK, String.valueOf(feedback));
            map.put(EV07B_KEY21_TIME, String.valueOf(time));
            map.put(EV07B_KEY21_TASK, String.valueOf(task));
            map.put(EV07B_KEY21_MODE, String.valueOf(mode));
            map.put(EV07B_KEY21_ENABLE, String.valueOf(enable));
            return map;
        }

        @Override
        public byte[] archive(HashMap<String, String> value) {
            int feedback = Integer.valueOf(value.get(EV07B_KEY21_FEEDBACK));
            int time = Integer.valueOf(value.get(EV07B_KEY21_TIME));
            int task = Integer.valueOf(value.get(EV07B_KEY21_TASK));
            int mode = Integer.valueOf(value.get(EV07B_KEY21_MODE));
            int enable = Integer.valueOf(value.get(EV07B_KEY21_ENABLE));
            int val = (feedback + (time << 2) + (task << 9) + (mode << 13) + (enable << 15));
            ByteBuffer b = ByteBuffer.allocate(2);
            b.order(ByteOrder.LITTLE_ENDIAN);
            b.putInt(val);
            return b.array();
        }
    }

    static class Call2ButtonSetting implements Parser<HashMap<String, String>> {

        @Override
        public HashMap<String, String> parseData(byte[] data) {
            HashMap<String, String> map = new HashMap<String, String>();
            int value = ByteBuffer.wrap(data, 0, 2).getInt();
            int feedback = value & 0x03;
            int time = (value >> 2) & 0x7f;
            int task = (value >> 9) & 0x0f;
            int mode = (value >> 13) & 0x01;
            int enable = (value >> 15) & 0x01;
            map.put(EV07B_KEY22_FEEDBACK, String.valueOf(feedback));
            map.put(EV07B_KEY22_TIME, String.valueOf(time));
            map.put(EV07B_KEY22_TASK, String.valueOf(task));
            map.put(EV07B_KEY22_MODE, String.valueOf(mode));
            map.put(EV07B_KEY22_ENABLE, String.valueOf(enable));
            return map;
        }

        @Override
        public byte[] archive(HashMap<String, String> value) {
            int feedback = Integer.valueOf(value.get(EV07B_KEY22_FEEDBACK));
            int time = Integer.valueOf(value.get(EV07B_KEY22_TIME));
            int task = Integer.valueOf(value.get(EV07B_KEY22_TASK));
            int mode = Integer.valueOf(value.get(EV07B_KEY22_MODE));
            int enable = Integer.valueOf(value.get(EV07B_KEY22_ENABLE));
            int val = (feedback + (time << 2) + (task << 9) + (mode << 13) + (enable << 15));
            ByteBuffer b = ByteBuffer.allocate(2);
            b.order(ByteOrder.LITTLE_ENDIAN);
            b.putInt(val);
            return b.array();
        }
    }

    //----------------Phone Settings---------------------
    static class AuthorizedContacts implements Parser<HashMap<String, String>> {

        @Override
        public HashMap<String, String> parseData(byte[] data) {
            HashMap<String, String> map = new HashMap<String, String>();
            byte value = (byte) (data[0] & 0x0f);
            byte noCard = (byte) ((data[0] >> 4) & 0x01);
            byte sms = (byte) ((data[0] >> 5) & 0x01);
            byte phone = (byte) ((data[0] >> 6) & 0x01);
            byte enable = (byte) ((data[0] >> 7) & 0x01);
            String number = new String(data, 1, data.length - 1, US_ASCII);
            map.put(EV07B_KEY30_VALUE, String.format(Locale.getDefault(), "%d", BytesUtil.get(value)));
            map.put(EV07B_KEY30_NOCARD, String.format(Locale.getDefault(), "%d", BytesUtil.get(noCard)));
            map.put(EV07B_KEY30_SMS, String.format(Locale.getDefault(), "%d", BytesUtil.get(sms)));
            map.put(EV07B_KEY30_PHONE, String.format(Locale.getDefault(), "%d", BytesUtil.get(phone)));
            map.put(EV07B_KEY30_ENABLE, String.format(Locale.getDefault(), "%d", BytesUtil.get(enable)));
            map.put(EV07B_KEY30_NUMBER, String.format(Locale.getDefault(), "%s", number));
            return map;
        }

        @Override
        public byte[] archive(HashMap<String, String> value) {
            byte index = (byte) (Byte.valueOf(value.get(EV07B_KEY30_VALUE)) & 0xf);
            byte noCard = (byte) (Byte.valueOf(value.get(EV07B_KEY30_NOCARD)) & 0x01);
            byte sms = (byte) (Byte.valueOf(value.get(EV07B_KEY30_SMS)) & 0x01);
            byte phone = (byte) (Byte.valueOf(value.get(EV07B_KEY30_PHONE)) & 0x01);
            byte enable = (byte) (Byte.valueOf(value.get(EV07B_KEY30_ENABLE)) & 0x01);
            String number = value.get(EV07B_KEY30_NUMBER);
            int len = number.length() + 1;
            byte val = (byte) (index + (noCard << 4) + (sms << 5) + (phone << 6) + (enable << 7));
            ByteBuffer b = ByteBuffer.allocate(len);
            b.order(ByteOrder.LITTLE_ENDIAN);
            b.put(val);
            b.put(number.getBytes(US_ASCII));
            return b.array();
        }
    }

    static class SMSReplyPrefixText implements Parser<HashMap<String, String>> {

        @Override
        public HashMap<String, String> parseData(byte[] data) {
            HashMap<String, String> map = new HashMap<String, String>();
            String text = new String(data, 0, data.length, US_ASCII);
            map.put(EV07B_KEY31_TEXT, String.format(Locale.getDefault(), "%s", text));
            return map;
        }

        @Override
        public byte[] archive(HashMap<String, String> value) {
            String text = value.get(EV07B_KEY31_TEXT);
            int len = text.length();
            ByteBuffer b = ByteBuffer.allocate(len);
            b.order(ByteOrder.LITTLE_ENDIAN);
            b.put(text.getBytes(US_ASCII));
            return b.array();
        }
    }

    static class SOSOption implements Parser<HashMap<String, String>> {

        @Override
        public HashMap<String, String> parseData(byte[] data) {
            HashMap<String, String> map = new HashMap<String, String>();
            short holdTime = (short) (data[0] + (data[1] << 8));
            byte ringsTime = data[2];
            byte cycle = data[3];
            String text = new String(data, 0, data.length, US_ASCII);
            map.put(EV07B_KEY32_HOLD_TIME, String.format(Locale.getDefault(), "%d", BytesUtil.get(holdTime)));
            map.put(EV07B_KEY32_RINGS_TIME, String.format(Locale.getDefault(), "%d", BytesUtil.get(ringsTime)));
            map.put(EV07B_KEY32_CYCLE, String.format(Locale.getDefault(), "%d", BytesUtil.get(cycle)));
            return map;
        }

        @Override
        public byte[] archive(HashMap<String, String> value) {
            short holdTime = Short.valueOf(value.get(EV07B_KEY32_HOLD_TIME));
            byte ringsTime = Byte.valueOf(value.get(EV07B_KEY32_RINGS_TIME));
            byte cycle = Byte.valueOf(value.get(EV07B_KEY32_CYCLE));
            int val = holdTime | (ringsTime << 16) | (cycle << 24);
            ByteBuffer b = ByteBuffer.allocate(4);
            b.order(ByteOrder.LITTLE_ENDIAN);
            b.putInt(val);
            return b.array();
        }
    }

    static class PhoneSwitches implements Parser<HashMap<String, String>> {

        @Override
        public HashMap<String, String> parseData(byte[] data) {
            HashMap<String, String> map = new HashMap<String, String>();
            int val = ByteBuffer.wrap(data).getInt();
            int afterRings = val & 0x7f;
            int autoAnswer = (val >> 7) & 0x01;
            int authorizedCall = (val >> 8) & 0x01;
            int hangUp = (val >> 9) & 0x01;
            int listenIn = (val >> 10) & 0x01;
            int authorizedSms = (val >> 11) & 0x01;
            map.put(EV07B_KEY33_AFTER_RINGS, String.format(Locale.getDefault(), "%d", BytesUtil.get(afterRings)));
            map.put(EV07B_KEY33_AUTO_ANSWER, String.format(Locale.getDefault(), "%d", BytesUtil.get(autoAnswer)));
            map.put(EV07B_KEY33_AUTHORIZED_CALL, String.format(Locale.getDefault(), "%d", BytesUtil.get(authorizedCall)));
            map.put(EV07B_KEY33_HANG_UP, String.format(Locale.getDefault(), "%d", BytesUtil.get(hangUp)));
            map.put(EV07B_KEY33_LISTEN_IN, String.format(Locale.getDefault(), "%d", BytesUtil.get(listenIn)));
            map.put(EV07B_KEY33_AUTHORIZED_SMS, String.format(Locale.getDefault(), "%d", BytesUtil.get(authorizedSms)));
            return map;
        }

        @Override
        public byte[] archive(HashMap<String, String> value) {
            int afterRings = Short.valueOf(value.get(EV07B_KEY33_AFTER_RINGS)) & 0x01;
            int autoAnswer = Byte.valueOf(value.get(EV07B_KEY33_AUTO_ANSWER)) & 0x01;
            int authorizedCall = Byte.valueOf(value.get(EV07B_KEY33_AUTHORIZED_CALL)) & 0x01;
            int hangUp = Short.valueOf(value.get(EV07B_KEY33_HANG_UP)) & 0x01;
            int listenIn = Byte.valueOf(value.get(EV07B_KEY33_LISTEN_IN)) & 0x01;
            int authorizedSms = Byte.valueOf(value.get(EV07B_KEY33_AUTHORIZED_SMS)) & 0x01;
            int val = afterRings | (autoAnswer << 7) | (authorizedCall << 8) |
                    (hangUp << 9) | (listenIn << 10) | (authorizedSms << 11);
            ByteBuffer b = ByteBuffer.allocate(4);
            b.order(ByteOrder.LITTLE_ENDIAN);
            b.putInt(val);
            return b.array();
        }
    }

    //----------------GPRS Setting------------------------
    static class APN implements Parser<HashMap<String, String>> {

        @Override
        public HashMap<String, String> parseData(byte[] data) {
            HashMap<String, String> map = new HashMap<String, String>();
            map.put(EV07B_KEY40_APN, String.format(Locale.getDefault(), "%s",
                    new String(data, US_ASCII)));
            return map;
        }

        @Override
        public byte[] archive(HashMap<String, String> value) {
            String txt = value.get(EV07B_KEY40_APN);
            ByteBuffer b = ByteBuffer.allocate(txt.length());
            b.order(ByteOrder.LITTLE_ENDIAN);
            b.put(txt.getBytes(US_ASCII));
            return b.array();
        }
    }

    static class ApnUsername implements Parser<HashMap<String, String>> {

        @Override
        public HashMap<String, String> parseData(byte[] data) {
            HashMap<String, String> map = new HashMap<String, String>();
            map.put(EV07B_KEY41_USER_NAME, String.format(Locale.getDefault(), "%s",
                    new String(data, US_ASCII)));
            return map;
        }

        @Override
        public byte[] archive(HashMap<String, String> value) {
            String txt = value.get(EV07B_KEY41_USER_NAME);
            ByteBuffer b = ByteBuffer.allocate(txt.length());
            b.order(ByteOrder.LITTLE_ENDIAN);
            b.put(txt.getBytes(US_ASCII));
            return b.array();
        }
    }

    static class ApnPassword implements Parser<HashMap<String, String>> {

        @Override
        public HashMap<String, String> parseData(byte[] data) {
            HashMap<String, String> map = new HashMap<String, String>();
            map.put(EV07B_KEY42_PASSWORD, String.format(Locale.getDefault(), "%s",
                    new String(data, US_ASCII)));
            return map;
        }

        @Override
        public byte[] archive(HashMap<String, String> value) {
            String txt = value.get(EV07B_KEY42_PASSWORD);
            ByteBuffer b = ByteBuffer.allocate(txt.length());
            b.order(ByteOrder.LITTLE_ENDIAN);
            b.put(txt.getBytes(US_ASCII));
            return b.array();
        }
    }

    static class IP implements Parser<HashMap<String, String>> {

        @Override
        public HashMap<String, String> parseData(byte[] data) {
            HashMap<String, String> map = new HashMap<String, String>();
            int flag = ByteBuffer.wrap(data,0,1).getInt();
            int udp = flag & 0x01;
            int enable = (flag>>7) & 0x01;
            int port = ByteBuffer.wrap(data,1,2).getInt();
            String ip = new String(data, 3, data.length - 3, US_ASCII);
            map.put(EV07B_KEY43_UDP, String.format(Locale.getDefault(), "%d", BytesUtil.get(udp)));
            map.put(EV07B_KEY43_ENABLE, String.format(Locale.getDefault(), "%d", BytesUtil.get(enable)));
            map.put(EV07B_KEY43_PORT, String.format(Locale.getDefault(), "%d", BytesUtil.get(port)));
            map.put(EV07B_KEY43_IP, String.format(Locale.getDefault(), "%s", ip));
            return map;
        }

        @Override
        public byte[] archive(HashMap<String, String> value) {
            byte udp = Byte.valueOf(value.get(EV07B_KEY43_UDP));
            byte enable = Byte.valueOf(value.get(EV07B_KEY43_ENABLE));
            byte flag = (byte) (udp + (enable << 7));
            short port = Short.valueOf(value.get(EV07B_KEY43_PORT));
            String ip = value.get(EV07B_KEY43_IP);
            int len = ip.length() + 3;
            ByteBuffer b = ByteBuffer.allocate(len);
            b.order(ByteOrder.LITTLE_ENDIAN);
            b.put(flag);
            b.putShort(port);
            b.put(ip.getBytes(US_ASCII));
            return b.array();
        }
    }

    static class Time implements Parser<HashMap<String, String>> {

        @Override
        public HashMap<String, String> parseData(byte[] data) {
            HashMap<String, String> map = new HashMap<String, String>();
            int heartBeat = ByteBuffer.wrap(data,0,4).getInt();
            int heartBeatEnable = heartBeat>>31;
            int heartBeatVal = heartBeat<<1>>1;
            int upload = ByteBuffer.wrap(data,4,4).getInt();
            int uploadLazy = ByteBuffer.wrap(data,8,4).getInt();
            map.put(EV07B_KEY44_HEART_BEAT, String.format(Locale.getDefault(), "%d", BytesUtil.get(heartBeatVal)));
            map.put(EV07B_KEY44_HEART_BEAT_ENABLE, String.format(Locale.getDefault(), "%d", BytesUtil.get(heartBeatEnable)));
            map.put(EV07B_KEY44_UPLOAD, String.format(Locale.getDefault(), "%d", BytesUtil.get(upload)));
            map.put(EV07B_KEY44_UPLOAD_LAZY, String.format(Locale.getDefault(), "%d", BytesUtil.get(uploadLazy)));
            return map;
        }

        @Override
        public byte[] archive(HashMap<String, String> value) {
            int heartBeatVal = Integer.valueOf(value.get(EV07B_KEY44_HEART_BEAT));
            int heartBeatEnable = Integer.valueOf(value.get(EV07B_KEY44_HEART_BEAT_ENABLE));
            int heartBeat = heartBeatVal + (heartBeatEnable<<31);
            int upload = Integer.valueOf(value.get(EV07B_KEY44_UPLOAD));
            int uploadLazy = Integer.valueOf(value.get(EV07B_KEY44_UPLOAD_LAZY));
            ByteBuffer b = ByteBuffer.allocate(12);
            b.order(ByteOrder.LITTLE_ENDIAN);
            b.putInt(heartBeat);
            b.putInt(upload);
            b.putInt(uploadLazy);
            return b.array();
        }
    }

    static class LocTime implements Parser<HashMap<String, String>> {

        @Override
        public HashMap<String, String> parseData(byte[] data) {
            HashMap<String, String> map = new HashMap<String, String>();
            int interval = ByteBuffer.wrap(data,0,2).getInt();
            int time = ByteBuffer.wrap(data,2,2).getInt();
            map.put(EV07B_KEY45_INTERVAL, String.format(Locale.getDefault(), "%d", BytesUtil.get(interval)));
            map.put(EV07B_KEY45_TIME, String.format(Locale.getDefault(), "%d", BytesUtil.get(time)));
            return map;
        }

        @Override
        public byte[] archive(HashMap<String, String> value) {
            short interval = Short.valueOf(value.get(EV07B_KEY45_INTERVAL));
            short time = Short.valueOf(value.get(EV07B_KEY45_TIME));
            ByteBuffer b = ByteBuffer.allocate(4);
            b.order(ByteOrder.LITTLE_ENDIAN);
            b.putShort(interval);
            b.putShort(time);
            return b.array();
        }
    }

    //----------------Alert Settings------------------------
    static class PowerAlert implements Parser<HashMap<String, String>> {

        @Override
        public HashMap<String, String> parseData(byte[] bytes) {
            HashMap<String, String> map = new HashMap<String, String>();
            byte threshold = (byte) (bytes[0] & 0x1f);
            byte low = (byte) ((bytes[0] >> 5) & 0x01);
            byte on = (byte) ((bytes[0] >> 6) & 0x01);
            byte off = (byte) ((bytes[0] >> 7) & 0x01);
            map.put(EV07B_KEY50_THRESHOLD, String.format(Locale.getDefault(), "%d", BytesUtil.get(threshold)));
            map.put(EV07B_KEY50_LOW, String.format(Locale.getDefault(), "%d", BytesUtil.get(low)));
            map.put(EV07B_KEY50_ON, String.format(Locale.getDefault(), "%d", BytesUtil.get(on)));
            map.put(EV07B_KEY50_OFF, String.format(Locale.getDefault(), "%d", BytesUtil.get(off)));
            return map;
        }

        @Override
        public byte[] archive(HashMap<String, String> value) {
            byte threshold = Byte.valueOf(value.get(EV07B_KEY50_THRESHOLD));
            byte low = Byte.valueOf(value.get(EV07B_KEY50_LOW));
            byte on = Byte.valueOf(value.get(EV07B_KEY50_ON));
            byte off = Byte.valueOf(value.get(EV07B_KEY50_OFF));
            ByteBuffer b = ByteBuffer.allocate(1);
            byte val = (byte) (threshold + (low << 5) + (on << 6) + (off << 7));
            b.order(ByteOrder.LITTLE_ENDIAN);
            b.put(val);
            return b.array();
        }
    }

    static class GeoAlert implements Parser<HashMap<String, Object>> {

        @Override
        public HashMap<String, Object> parseData(byte[] bytes) {
            HashMap<String, Object> map = new HashMap<String, Object>();
            int flag = ByteBuffer.wrap(bytes,0,4).getInt();
            byte index = (byte) (flag&0x0f);
            byte points = (byte) ((flag>>4)&0x0f);
            byte enable = (byte) ((flag>>8)&0x01);
            byte direction = (byte) ((flag>>9)&0x01);
            byte type = (byte) ((flag>>10)&0x01);
            short radius = (short) ((flag>>16)&0xffff);
            int startIndex = 3;
            ArrayList<String> latLngs = new ArrayList<>();
            while (startIndex+8 < bytes.length) {
                int lat = ByteBuffer.wrap(bytes,startIndex,4).getInt();
                startIndex += 4;
                int lng = ByteBuffer.wrap(bytes,startIndex,4).getInt();
                startIndex += 4;
                String latLng = String.format(Locale.getDefault(), "%.7f,%.7f",
                        BytesUtil.get(lat) / Constant.E7, BytesUtil.get(lng) / Constant.E7);
                latLngs.add(latLng);
            }
            map.put(EV07B_KEY51_INDEX, String.format(Locale.getDefault(), "%d", BytesUtil.get(index)));
            map.put(EV07B_KEY51_POINTS, String.format(Locale.getDefault(), "%d", BytesUtil.get(points)));
            map.put(EV07B_KEY51_ENABLE, String.format(Locale.getDefault(), "%d", BytesUtil.get(enable)));
            map.put(EV07B_KEY51_DIRECTION, String.format(Locale.getDefault(), "%d", BytesUtil.get(direction)));
            map.put(EV07B_KEY51_TYPE, String.format(Locale.getDefault(), "%d", BytesUtil.get(type)));
            map.put(EV07B_KEY51_RADIUS, String.format(Locale.getDefault(), "%d", BytesUtil.get(radius)));
            map.put(EV07B_KEY51_LATLNGS, String.format(Locale.getDefault(), "%s", latLngs));
            return map;
        }

        @Override
        public byte[] archive(HashMap<String, Object> value) {
            int len = 0;
            byte index = (byte) value.get(EV07B_KEY51_INDEX);
            byte points = (byte) value.get(EV07B_KEY51_POINTS);
            byte enable = (byte) value.get(EV07B_KEY51_ENABLE);
            byte direction = (byte) value.get(EV07B_KEY51_DIRECTION);
            byte type = (byte) value.get(EV07B_KEY51_TYPE);
            short radius = (short) value.get(EV07B_KEY51_RADIUS);
            int val = index|(points << 4)|(enable << 8)|(direction << 9)|(type << 10)|(radius << 16);
            len += 4;
            ArrayList<String> latLngs = (ArrayList<String>) value.get(EV07B_KEY51_LATLNGS);
            len += latLngs.size() * 8;
            ByteBuffer b = ByteBuffer.allocate(len);
            b.order(ByteOrder.LITTLE_ENDIAN);
            b.putInt(val);
            for (String latLng : latLngs) {
                String[] latLngArr = latLng.split(",");
                int lat = (int) (Double.valueOf(latLngArr[0]) * Constant.E7);
                int lng = (int) (Double.valueOf(latLngArr[1]) * Constant.E7);
                b.putInt(lat);
                b.putInt(lng);
            }
            return b.array();
        }
    }

    static class MotionAlert implements Parser<HashMap<String, String>> {

        @Override
        public HashMap<String, String> parseData(byte[] bytes) {
            HashMap<String, String> map = new HashMap<String, String>();
            int flag = ByteBuffer.wrap(bytes).getInt();
            short setTime = (short) (flag & 0xffff);
            short activeTime = (short) ((flag>>16)&0x7fff);
            byte enable = (byte) ((flag>>31)&0x01);
            map.put(EV07B_KEY52_SET_TIME, String.format(Locale.getDefault(), "%d", BytesUtil.get(setTime)));
            map.put(EV07B_KEY52_ACTIVE_TIME, String.format(Locale.getDefault(), "%d", BytesUtil.get(activeTime)));
            map.put(EV07B_KEY52_ENABLE, String.format(Locale.getDefault(), "%d", BytesUtil.get(enable)));
            return map;
        }

        @Override
        public byte[] archive(HashMap<String, String> value) {
            short setTime = Short.valueOf(value.get(EV07B_KEY52_SET_TIME));
            short activeTime = Short.valueOf(value.get(EV07B_KEY52_ACTIVE_TIME));
            byte enable = Byte.valueOf(value.get(EV07B_KEY52_ENABLE));
            ByteBuffer b = ByteBuffer.allocate(4);
            int val = setTime|(activeTime << 16)|(enable << 31);
            b.order(ByteOrder.LITTLE_ENDIAN);
            b.putInt(val);
            return b.array();
        }
    }

    static class NoMotionAlert implements Parser<HashMap<String, String>> {

        @Override
        public HashMap<String, String> parseData(byte[] bytes) {
            HashMap<String, String> map = new HashMap<String, String>();
            int flag = ByteBuffer.wrap(bytes).getInt();
            byte enable = (byte) (flag >> 31);
            int staticTime = flag<<1>>1;
            map.put(EV07B_KEY53_NO_MOTION_TIME, String.format(Locale.getDefault(), "%d", BytesUtil.get(staticTime)));
            map.put(EV07B_KEY53_ENABLE, String.format(Locale.getDefault(), "%d", BytesUtil.get(enable)));

            return map;
        }

        @Override
        public byte[] archive(HashMap<String, String> value) {
            int staticTime = Integer.valueOf(value.get(EV07B_KEY53_NO_MOTION_TIME));
            byte enable = Byte.valueOf(value.get(EV07B_KEY53_ENABLE));
            ByteBuffer b = ByteBuffer.allocate(4);
            int flag = staticTime|(enable<<31);
            b.order(ByteOrder.LITTLE_ENDIAN);
            b.putInt(flag);
            return b.array();
        }
    }

    static class SpeedAlert implements Parser<HashMap<String, String>> {

        @Override
        public HashMap<String, String> parseData(byte[] bytes) {
            HashMap<String, String> map = new HashMap<String, String>();
            short flag = ByteBuffer.wrap(bytes).getShort();
            byte enable = (byte) (flag >> 15);
            short speed = (short) (flag&0x7fff);
            map.put(EV07B_KEY54_SPEED, String.format(Locale.getDefault(), "%d", BytesUtil.get(speed)));
            map.put(EV07B_KEY54_ENABLE, String.format(Locale.getDefault(), "%d", BytesUtil.get(enable)));
            return map;
        }

        @Override
        public byte[] archive(HashMap<String, String> value) {
            short speed = Short.valueOf(value.get(EV07B_KEY54_SPEED));
            byte enable = Byte.valueOf(value.get(EV07B_KEY54_ENABLE));
            ByteBuffer b = ByteBuffer.allocate(2);
            short flag = (short) (speed|(enable<<15));
            b.order(ByteOrder.LITTLE_ENDIAN);
            b.putShort(flag);
            return b.array();
        }
    }

    static class TiltAlert implements Parser<HashMap<String, String>> {

        @Override
        public HashMap<String, String> parseData(byte[] bytes) {
            HashMap<String, String> map = new HashMap<String, String>();
            int flag = ByteBuffer.wrap(bytes).getInt();
            short timeThreshold = (short) (flag & 0xffff);
            byte angleThreshold = (byte) ((flag>>16) & 0xff);
            byte enable = (byte) (flag>>31);
            map.put(EV07B_KEY55_TIME_THRESHOLD, String.format(Locale.getDefault(), "%d", BytesUtil.get(timeThreshold)));
            map.put(EV07B_KEY55_ANGLE_THRESHOLD, String.format(Locale.getDefault(), "%d", BytesUtil.get(angleThreshold)));
            map.put(EV07B_KEY55_ENABLE, String.format(Locale.getDefault(), "%d", BytesUtil.get(enable)));
            return map;
        }

        @Override
        public byte[] archive(HashMap<String, String> value) {
            short timeThreshold = Short.valueOf(value.get(EV07B_KEY55_TIME_THRESHOLD));
            byte angleThreshold = Byte.valueOf(value.get(EV07B_KEY55_ANGLE_THRESHOLD));
            byte enable = Byte.valueOf(value.get(EV07B_KEY55_ENABLE));
            int flag = timeThreshold|(angleThreshold<<16)|(enable<<31);
            ByteBuffer b = ByteBuffer.allocate(4);
            b.order(ByteOrder.LITTLE_ENDIAN);
            b.putInt(flag);
            return b.array();
        }
    }

    static class FallDownAlert implements Parser<HashMap<String, String>> {

        @Override
        public HashMap<String, String> parseData(byte[] bytes) {
            HashMap<String, String> map = new HashMap<String, String>();
            byte flag = ByteBuffer.wrap(bytes).get();
            byte level = (byte) (flag&0x0f);
            byte dial = (byte) ((flag>>6)&0x01);
            byte enable = (byte) (flag>>7);
            map.put(EV07B_KEY56_LEVEL, String.format(Locale.getDefault(), "%d", BytesUtil.get(level)));
            map.put(EV07B_KEY56_DIAL, String.format(Locale.getDefault(), "%d", BytesUtil.get(dial)));
            map.put(EV07B_KEY56_ENABLE, String.format(Locale.getDefault(), "%d", BytesUtil.get(enable)));
            return map;
        }

        @Override
        public byte[] archive(HashMap<String, String> value) {
            byte level = Byte.valueOf(value.get(EV07B_KEY56_LEVEL));
            byte dial = Byte.valueOf(value.get(EV07B_KEY56_DIAL));
            byte enable = Byte.valueOf(value.get(EV07B_KEY56_ENABLE));
            byte flag = (byte) (level|(dial << 6)|(enable << 7));
            ByteBuffer b = ByteBuffer.allocate(1);
            b.order(ByteOrder.LITTLE_ENDIAN);
            b.put(flag);
            return b.array();
        }
    }
}
