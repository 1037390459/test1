package com.eview.myapplication.EV07B;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;

/**
 * Created by chenming on 2018/3/23.haha
 */

public class DataHander {

    interface ResponseHander{
        void onResponse(HashMap hashMap);
    }

    private static int Frame_Size = 20;
    private static String TAG = DataHander.class.getSimpleName();

    private HashMap<Integer,ResponseHander> msgHander = new HashMap<>();
    private ArrayList<Byte> frameData = new ArrayList<>();
    private int frameLength = 0;

    //分包发送
    public void sendData(byte[] bytes,ResponseHander hander){
        int sid = DataBase.sid;
        msgHander.put(sid-1,hander);
        int bundleSize = (int) Math.ceil(bytes.length/(float)Frame_Size);
        for (int i = 0;i<bundleSize;i++){
            int curSize = bytes.length-i*20;
            int length = Math.min(curSize,20);
            byte[] data = Arrays.copyOfRange(bytes,i*20,length);
            Helper.getInstance().sendData(data);
        }
    }

    //组包解析
    public void handleResponseData(Byte[] bytes) throws Exception {
       if (frameData.size() == 0) {
          if (bytes.length<8){
              OnError(Constant.BTReturnCode.DataSizeError);
              return;
          }
          short length = (short) (bytes[2]+(bytes[3]<<8) + 8);
          frameLength = BytesUtil.get(length); //无符号解析
       }
       if (frameData.size()<frameLength){
           frameData.addAll(Arrays.asList(bytes));
       }
       if (frameData.size() == frameLength){
           parseAndCallBackData(frameData);//解析
           frameData.clear();
           frameLength = 0;
       }
       if (frameData.size() > frameLength){
           OnError(Constant.BTReturnCode.DataSizeError);
           frameData.clear();
           frameLength = 0;
       }
    }

    private void parseAndCallBackData(ArrayList<Byte> data) throws Exception {
        Byte[] bytes = data.toArray(new Byte[1]);
        DataBase.Message message = DataBase.convert_to_message(bytes);
        ResponseHander callBack = msgHander.get((int) message.sid);
        int cmd = message.body.cmd;
        //错误包处理
        if (message.properties.err != 0){
            int code = -1; //unknown error code
            if (cmd == Constant.BTService.NegativeRes.getValue()){
                code = message.body.content[0].key;
            }
            OnError(Constant.BTReturnCode.values()[code]);
            callBack.onResponse(null);
            return;
        }

        DataBase.Element[] elements = message.body.content;
        HashMap<Integer,Object>hashMap = new HashMap<>();
        if (cmd == Constant.BTService.Config.getValue()){
            for (DataBase.Element element : elements) {
                int key = BytesUtil.get(element.key);
                Byte[] value = element.value;
                hashMap.put(key, DataParseHelper.getParser(key).parseData(BytesUtil.toBytes(value)));
            }
        }
        callBack.onResponse(hashMap);
    }

    private String dataParse(Byte[] data,Class cls){
        return null;
    }


    //错误码
    public void OnError(Constant.BTReturnCode code) throws Exception {
        Exception exception = null;
       switch (code){
           case Success:
                break;
           default:
               exception = new RuntimeException("General Error! code = "+code);
       }
       if (exception != null){
           throw exception;
       }
    }



}
