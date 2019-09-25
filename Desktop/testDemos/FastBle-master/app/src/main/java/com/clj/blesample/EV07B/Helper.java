package com.eview.myapplication.EV07B;

/**
 * Created by chenming on 2018/3/23.haha
 */

public class Helper {

    private static final Helper ourInstance = new Helper();

    public static Helper getInstance() {
        return ourInstance;
    }

    private Helper() {}

    public void sendData(byte[] data){}
}
