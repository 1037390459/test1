package com.eview.myapplication.EV07B;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Locale;

/**
 * Created by chenming on 2018/3/20.haha
 */

public class DataBase {

    final private static int Magic_default = 0xAB;
    public static int sid = 0x100;

    static class Flag{
        byte crypto;
        byte err;
        byte ack;
        byte version;

        public Flag(){crypto = err = ack = version = 0;}

        public Flag(byte crypto, byte err, byte ack, byte version) {
            this.crypto = crypto;
            this.err = err;
            this.ack = ack;
            this.version = version;
        }

        @Override
        public String toString() {
            return String.format(Locale.getDefault(),"version:%02X\nack:%02X\nerr:%02X\ncrypto:%02X",version,ack,err,crypto);
        }
    }

    static class Element{
        byte key_len;
        byte key;
        Byte[] value;

        @Override
        public String toString() {
            return String.format(Locale.getDefault(),"key_len:%02X\nkey:%02X\nvalue:%s",key_len,key, BytesUtil.bytesToHexString(value));
        }
    }

    static class Body{
        byte cmd;
        Element []content;
        @Override
        public String toString() {
            return String.format(Locale.getDefault(),"cmd:%02X\ncontent:%s",cmd, Arrays.toString(content));
        }
    }

    static class Message {
        byte header;
        Flag properties;
        short length;
        short checkSum;
        short sid;
        Body body;
    }

    static public Byte[] getFrameData(Body body){
        return getFrameData(convert(body));
    }

    static public Byte[] getFrameData(Byte[] payload){
        int len = payload.length;
        Message message = new Message();
        message.header = (byte) Magic_default;
        message.properties = new Flag();
        message.length = (short)len;
        message.checkSum = (short) CheckCRC.crc16_bit(payload);
        message.sid = (short) sid;
        message.body = convert_to_body(payload);
        sid++;
        return convert(message);
    }

    static public Byte[] convert(Message message){
        int len = BytesUtil.get(message.length);
        int size = len+8;
        Byte[] bytes = new Byte[size];
        bytes[0] = message.header;
        bytes[1] = convert(message.properties);
        bytes[2] = (byte)(message.length&0xff);
        bytes[3] = (byte)((message.length>>8)&0xff);
        bytes[4] = (byte)(message.checkSum&0xff);
        bytes[5] = (byte)((message.checkSum>>8)&0xff);
        bytes[6] = (byte)(message.sid&0xff);
        bytes[7] = (byte)((message.sid>>8)&0xff);
        Byte[] body = convert(message.body);
        if (len != body.length) throw new AssertionError("Data Size Error!");
        System.arraycopy(body,0,bytes,8,len);
        return bytes;
    }

    static public Message convert_to_message(Byte[] bytes){
        int size = bytes.length;
        if (size<8) throw new AssertionError("Data Size Error!");
        Message message = new Message();
        message.header = (byte) 0xAB;
        message.properties = convert_to_flag(bytes[1]);
        message.length = (short) (bytes[2]|(bytes[3]<<8));
        message.checkSum = (short) (bytes[4]|(bytes[5]<<8));
        message.sid = (short) (bytes[6]|(bytes[7]<<8));
        if (size>8){
            Byte[] body = Arrays.copyOfRange(bytes,8,size);//
            message.body = convert_to_body(body);
        }
        return message;
    }

    static public Byte[] convert(Body body){
        int initSize = 12;
        Byte[] bytes = new Byte[initSize];
        Element[] elements = body.content;
        bytes[0] = body.cmd;
        int index = 1;
        for (Element element : elements){
            Byte[] bs = convert(element);
            index += bs.length;
            //动态扩容
            while (index>=initSize*0.75){
                initSize *= 2;
                Byte[] temp = new Byte[initSize];
                System.arraycopy(bytes, 0, temp, 0, bytes.length);
                bytes = temp;
            }
            System.arraycopy(bs, 0, bytes, index-bs.length, bs.length);
        }
        return Arrays.copyOf(bytes,index);
    }

    static public Body convert_to_body(Byte[] bytes){
        int size = bytes.length;
        if (size<1) throw new AssertionError("Data Size Error!");
        Body body = new Body();
        body.cmd = bytes[0];
        int index = 1;
        ArrayList<Element> list = new ArrayList<>();
        while (index<size){
          int length = BytesUtil.get(bytes[index]);
          Byte[] bs = new Byte[length+1];
          System.arraycopy(bytes, index, bs, 0, length+1);
          Element e = convert_to_element(bs);
          list.add(e);
          index += length+1;
        }
        body.content = list.toArray(new Element[list.size()]);
        return body;
    }

    static public Byte[] convert(Element element){
        int key_len = element.key_len;
        Byte[] bytes = new Byte[key_len+1];
        bytes[0] = element.key_len;
        bytes[1] = element.key;
        if (element.value != null){
            System.arraycopy(element.value, 0, bytes, 2, key_len - 1);
        }
        return bytes;
    }

    static public Element convert_to_element(Byte[] bytes){
        Element element = new Element();
        int size = bytes.length;
        if (size<2) throw new AssertionError("Data Size Error!");
        element.key_len = bytes[0];
        element.key = bytes[1];
        int length = size-2;
        element.value = new Byte[length];
        System.arraycopy(bytes,2,element.value,0,length);
        return element;
    }

    static public byte convert(Flag flag){
        return (byte)(flag.version+(flag.ack<<4)+(flag.err<<5)+(flag.crypto<<6));
    }

    static public Flag convert_to_flag(byte b){
        Flag f = new Flag();
        f.crypto = (byte)((b & 0xc0)>>6);
        f.err = (byte)((b & 0x20)>>5);
        f.ack = (byte)((b & 0x10)>>4);
        f.version = (byte)(b & 0x0f);
        return f;
    }

    public static void main(String args[]) {
//        //test flag
//        Flag f = convert_to_flag((byte) 0xf1);
//        System.out.println(f.toString());
//        byte b = convert(f);
//        System.out.println("byte:"+ BytesUtil.get(b));
//
//              // test element
//        Element element = convert_to_element(BytesUtil.hexStringToByte("0x020100"));
//        System.out.println(element.toString());
//        Byte[] bytes1 = convert(element);
//        System.out.println("bytes:"+ BytesUtil.bytesToHexString(bytes1));
//
//              // test body
//        Body body = convert_to_body(BytesUtil.hexStringToByte("0x11020100 020301"));
//        System.out.println(body.toString());
//        Byte[] bytes2 = convert(body);
//        System.out.println("bytes:"+ BytesUtil.bytesToHexString(bytes2));
//
//              // test message
//        Byte[] bytes3 = getFrameData(BytesUtil.hexStringToByte("0x020213ec"));
//        System.out.println("bytes:"+ BytesUtil.bytesToHexString(bytes3));
//
//              // test system control
//        Byte[] bytes4 = DataHelper.getInstance().systemControl(Constant.BTSystemControl.EnterDFUMode);
//        System.out.println("bytes:"+ BytesUtil.bytesToHexString(bytes4));
//
//              // test read config
//        Byte[] bytes5 = DataHelper.getInstance().configuration(Constant.BTOperation.Read,0x11111,null);
//        System.out.println("bytes:"+ BytesUtil.bytesToHexString(bytes5));

        //       test write config
        HashMap map = new HashMap<String,Object>(){
            {
                put("interval","180");
                put("mode","4");

                put("sh","9");
                put("sm","8");
                put("eh","10");
                put("em","11");

                put("enable","1");
                put("value","654321");

                put("timeZone","-20");
            }
        };

        Byte[] bytes6 = DataHelper.getInstance().configuration(Constant.BTOperation.SaveSetting,0x1f00,map);
        System.out.println("bytes:"+ BytesUtil.bytesToHexString(bytes6));
    }

}

