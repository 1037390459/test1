package com.eview.myapplication.EV07B;

import java.util.ArrayList;
import java.util.HashMap;

/**
 * Created by chenming on 2018/3/21.haha
 */

public class DataHelper {
    private static final DataHelper ourInstance = new DataHelper();

    public static DataHelper getInstance() {
        return ourInstance;
    }

    private DataHelper() {}

    public Byte[] systemControl(Constant.BTSystemControl type) {
        DataBase.Body body = new DataBase.Body();
        body.cmd = (byte) Constant.BTService.SystemControl.getValue();
        DataBase.Element[] elements = new DataBase.Element[1];
        DataBase.Element element = new DataBase.Element();
        element.key_len = 0x01;
        element.key = (byte) type.getValue();
        elements[0] = element;
        body.content = elements;
        return DataBase.getFrameData(body);
    }

    public Byte[] configuration(Constant.BTOperation operation,int type,HashMap param) {
        if (operation == Constant.BTOperation.Read) return readConf(type);
        return writeConf(type,param);
    }

    private Byte[] readConf(int type) {
        DataBase.Body body = new DataBase.Body();
        body.cmd = (byte) Constant.BTService.Config.getValue();
        DataBase.Element[] elements = new DataBase.Element[1];
        DataBase.Element element = new DataBase.Element();
        HashMap<Long, Long> keyValueStore = getKeyValueStore();
        Byte[] temp = new Byte[100];
        int size = 0;
        for (Long key:keyValueStore.keySet()){
            if ((type&key)==key){
                temp[size++] = keyValueStore.get(key).byteValue();
            }
        }
        Byte[] values = new Byte[size];
        System.arraycopy(temp,0,values,0,size);
        element.key_len = (byte)(size+1);
        element.key = (byte) Constant.BTOperation.Read.getValue();
        element.value = values;
        elements[0] = element;
        body.content = elements;
        return DataBase.getFrameData(body);
    }

    private Byte[] writeConf(int type,HashMap param) {
        DataBase.Body body = new DataBase.Body();
        body.cmd = (byte) Constant.BTService.Config.getValue();
        body.content =  getElementsData(type,param);
        return  DataBase.getFrameData(body);
    }

    private DataBase.Element[] getElementsData(int type, HashMap param){
        HashMap<Long, Long> keyValueStore = getKeyValueStore();
        ArrayList<DataBase.Element> elements = new ArrayList<>();
        for (Long key:keyValueStore.keySet()){
            if ((type&key)==key){
                if (param != null){
                    long value = keyValueStore.get(key);
                    Byte[] data =  BytesUtil.toBytes(DataParseHelper.getParser(value).archive(param));
                    DataBase.Element element = new DataBase.Element();
                    element.key = (byte) value;
                    element.key_len = (byte) (data.length+1);
                    element.value = data;
                    elements.add(element);
                }
            }
        }
        return elements.toArray(new DataBase.Element[elements.size()]);
    }


    private HashMap<Long, Long> getKeyValueStore() {
        HashMap<Long, Long> map = new HashMap<>();
        //-------------General---------------
        long mnt = Constant.BTConfiguration.ModuleNumber.getType();
        long mnv = Constant.BTConfiguration.ModuleNumber.getValue();
        long fvt = Constant.BTConfiguration.FirmwareVersion.getType();
        long fvv = Constant.BTConfiguration.FirmwareVersion.getValue();
        long imeit = Constant.BTConfiguration.Imei.getType();
        long imeiv = Constant.BTConfiguration.Imei.getValue();
        long icct = Constant.BTConfiguration.ICCID.getType();
        long iccv = Constant.BTConfiguration.ICCID.getValue();
        long mact = Constant.BTConfiguration.Mac.getType();
        long macv = Constant.BTConfiguration.Mac.getValue();
        long dtt = Constant.BTConfiguration.SettingTime.getType();
        long dtv = Constant.BTConfiguration.SettingTime.getValue();
        long rtt = Constant.BTConfiguration.RunTime.getType();
        long rtv = Constant.BTConfiguration.RunTime.getValue();
        long fit = Constant.BTConfiguration.FirmwareInformation.getType();
        long fiv = Constant.BTConfiguration.FirmwareInformation.getValue();
        long imt = Constant.BTConfiguration.InitializeMileage.getType();
        long imv = Constant.BTConfiguration.InitializeMileage.getValue();
        map.put(mnt,mnv);
        map.put(fvt,fvv);
        map.put(imeit,imeiv);
        map.put(icct,iccv);
        map.put(mact,macv);
        map.put(dtt,dtv);
        map.put(rtt,rtv);
        map.put(fit,fiv);
        map.put(imt,imv);
        //-------------System Setting---------------
        long modet = Constant.BTConfiguration.Mode.getType();
        long modev = Constant.BTConfiguration.Mode.getValue();
        long act = Constant.BTConfiguration.AlarmClock.getType();
        long acv = Constant.BTConfiguration.AlarmClock.getValue();
        long ndt = Constant.BTConfiguration.NoDisturb.getType();
        long ndv = Constant.BTConfiguration.NoDisturb.getValue();
        long ppt = Constant.BTConfiguration.PasswordProtect.getType();
        long ppv = Constant.BTConfiguration.PasswordProtect.getValue();
        long tzt = Constant.BTConfiguration.TimeZone.getType();
        long tzv = Constant.BTConfiguration.TimeZone.getValue();
        long ect = Constant.BTConfiguration.EnableControl.getType();
        long ecv = Constant.BTConfiguration.EnableControl.getValue();
        long rtvt = Constant.BTConfiguration.RingToneVolume.getType();
        long rtvv = Constant.BTConfiguration.RingToneVolume.getValue();
        long mcvt = Constant.BTConfiguration.MicVolume.getType();
        long mcvv = Constant.BTConfiguration.MicVolume.getValue();
        long spvt = Constant.BTConfiguration.SpeakVolume.getType();
        long spvv = Constant.BTConfiguration.SpeakVolume.getValue();
        long dnt = Constant.BTConfiguration.DeviceName.getType();
        long dnv = Constant.BTConfiguration.DeviceName.getValue();
        map.put(modet,modev);
        map.put(act,acv);
        map.put(ndt,ndv);
        map.put(ppt,ppv);
        map.put(tzt,tzv);
        map.put(ect,ecv);
        map.put(rtvt,rtvv);
        map.put(mcvt,mcvv);
        map.put(spvt,spvv);
        map.put(dnt,dnv);
        //-------------Button Setting---------------
        long sbt = Constant.BTConfiguration.SosButtonSetting.getType();
        long sbv = Constant.BTConfiguration.SosButtonSetting.getValue();
        long c1bt = Constant.BTConfiguration.Call1ButtonSetting.getType();
        long c1bv = Constant.BTConfiguration.Call1ButtonSetting.getValue();
        long c2bt = Constant.BTConfiguration.Call2ButtonSetting.getType();
        long c2bv = Constant.BTConfiguration.Call2ButtonSetting.getValue();
        map.put(sbt,sbv);
        map.put(c1bt,c1bv);
        map.put(c2bt,c2bv);
        //-------------Phone Settings---------------
        long auct = Constant.BTConfiguration.AuthorizeContacts.getType();
        long aucv = Constant.BTConfiguration.AuthorizeContacts.getValue();
        long spt = Constant.BTConfiguration.SmsReplyPrefixText.getType();
        long spv = Constant.BTConfiguration.SmsReplyPrefixText.getValue();
        long sot = Constant.BTConfiguration.SosOption.getType();
        long sov = Constant.BTConfiguration.SosOption.getValue();
        long pst = Constant.BTConfiguration.PhoneSwitches.getType();
        long psv = Constant.BTConfiguration.PhoneSwitches.getValue();
        map.put(auct,aucv);
        map.put(spt,spv);
        map.put(sot,sov);
        map.put(pst,psv);
        //-------------GPRS Setting---------------
        long apnt = Constant.BTConfiguration.Apn.getType();
        long apnv = Constant.BTConfiguration.Apn.getValue();
        long aunt = Constant.BTConfiguration.ApnUserName.getType();
        long aunv = Constant.BTConfiguration.ApnUserName.getValue();
        long apwt = Constant.BTConfiguration.ApnPassword.getType();
        long apwv = Constant.BTConfiguration.ApnPassword.getValue();
        long ipt = Constant.BTConfiguration.Ip.getType();
        long ipv = Constant.BTConfiguration.Ip.getValue();
        long timet = Constant.BTConfiguration.Time.getType();
        long timev = Constant.BTConfiguration.Time.getValue();
        long cltt = Constant.BTConfiguration.ContinueLocTime.getType();
        long cltv = Constant.BTConfiguration.ContinueLocTime.getValue();
        map.put(apnt,apnv);
        map.put(aunt,aunv);
        map.put(apwt,apwv);
        map.put(ipt,ipv);
        map.put(timet,timev);
        map.put(cltt,cltv);
        //-------------Alert Settings---------------
        long apt = Constant.BTConfiguration.AlertPower.getType();
        long apv = Constant.BTConfiguration.AlertPower.getValue();
        long agt = Constant.BTConfiguration.AlertGEO.getType();
        long agv = Constant.BTConfiguration.AlertGEO.getValue();
        long amt = Constant.BTConfiguration.AlertMotion.getType();
        long amv = Constant.BTConfiguration.AlertMotion.getValue();
        long ast = Constant.BTConfiguration.AlertNoMotion.getType();
        long asv = Constant.BTConfiguration.AlertNoMotion.getValue();
        long aspt = Constant.BTConfiguration.AlertSpeed.getType();
        long aspv = Constant.BTConfiguration.AlertSpeed.getValue();
        long att = Constant.BTConfiguration.AlertTilt.getType();
        long atv = Constant.BTConfiguration.AlertTilt.getValue();
        long afdt = Constant.BTConfiguration.AlertFallDown.getType();
        long afdv = Constant.BTConfiguration.AlertFallDown.getValue();
        map.put(apt,apv);
        map.put(agt,agv);
        map.put(amt,amv);
        map.put(ast,asv);
        map.put(aspt,aspv);
        map.put(att,atv);
        map.put(afdt,afdv);
        return map;
    }
}
