package com.eview.myapplication.EV07B;

/**
 * Created by chenming on 2018/3/23.haha
 */

public class BytesUtil {

    /**
     * 无符号解析
     * @param b 有符号字节
     * @return 对应无符号值
     */
    static public int get(byte b){
        return  b & 0xff;
    }

    static public int get(short s) {
        return  s & 0xffff;
    }

    static public long get(int s) {
        return s& 0xffffffffL;
    }



    static public String bytesToHexString(Byte[] bytes) {
        StringBuilder sb = new StringBuilder();
        for (int i =0;i<bytes.length;i++){
            //无符号解析
            sb.append(String.format("%02x",get(bytes[i])));
            if ((i-8)%20 == 0) sb.append("\n");
            else  sb.append(" ");
        }
        return  sb.toString();
    }

    public static Byte[] hexStringToByte(String hexString) {
        hexString = hexString.replace(" ","");
        if (hexString.startsWith("0x")) hexString = hexString.substring(2);
        int len = (hexString.length() / 2);
        Byte[] result = new Byte[len];
        char[] charArray = hexString.toCharArray();
        for (int i = 0; i < len; i++) {
            int pos = i * 2;
            result[i] = (byte) (toByte(charArray[pos]) << 4 | toByte(charArray[pos + 1]));
        }
        return result;
    }

    private static byte toByte(char c) {
        String cs = "0123456789ABCDEF";
        return (cs.indexOf(c) == -1) ? (byte) cs.toLowerCase().indexOf(c) : (byte) cs.indexOf(c);
    }

    static Byte[] toBytes(byte[] bytes){
        Byte[] byteObjects = new Byte[bytes.length];
        int i=0;
        for(byte b: bytes)
            byteObjects[i++] = b;
        return byteObjects;

    }

    static byte[] toBytes(Byte[] byteObjects) {
        byte[] bytes = new byte[byteObjects.length];
        int i=0;
        for(Byte b: byteObjects)
            bytes[i++] = b;
        return bytes;
    }


}
