//
//  LXBLEManageViewController.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/12/23.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXBLEManageViewController.h"
#import "BabyBluetooth.h"
#import "LXBlueToothManager.h"
#define BLE_SEND_MAX_LEN 20

#define channelOnCharacteristicView @"CharacteristicView"
@interface LXBLEManageViewController (){
    BabyBluetooth *baby;
}

@end

@implementation LXBLEManageViewController

-(void)viewDidAppear:(BOOL)animated{
    NSLog(@"viewDidAppear");
    //停止之前的连接
    [baby cancelAllPeripheralsConnection];
    //设置委托后直接可以使用，无需等待CBCentralManagerStatePoweredOn状态。
    baby.scanForPeripherals().begin();
    //baby.scanForPeripherals().begin().stop(10);
}

//
//-(void)babyDelegate{
//
//    __weak typeof(self)weakSelf = self;
//    LXWeakSelf(baby);
//    [baby setBlockOnCentralManagerDidUpdateState:^(CBCentralManager *central) {
//        if (central.state == CBCentralManagerStatePoweredOn) {
//        }
//    }];
//
//
// //   设置查找设备的过滤器
//     [baby setFilterOnDiscoverPeripherals:^BOOL(NSString *peripheralName, NSDictionary *advertisementData, NSNumber *RSSI) {
//            //设置查找规则是名称大于1 ， the search rule is peripheral.name length > 2
//            if (peripheralName.length >1) {
//                return YES;
//            }
//            return NO;
//        }];
//
//        //连接过滤器
//        __block BOOL isFirst = YES;
//     [baby setFilterOnConnectToPeripherals:^BOOL(NSString *peripheralName, NSDictionary *advertisementData, NSNumber *RSSI) {
//            //这里的规则是：连接第一个设备
//    //        isFirst = NO;
//    //        return YES;
//            //这里的规则是：连接第一个P打头的设备
//                    if(isFirst && [peripheralName hasPrefix:@"LMJgA-"]){
//                        isFirst = NO;
//                        return YES;
//                    }
//                    return NO;
//        }];
//    //设置扫描到设备的委托
//    [baby setBlockOnDiscoverToPeripherals:^(CBCentralManager *central, CBPeripheral *peripheral, NSDictionary *advertisementData, NSNumber *RSSI) {
//        [weakbaby connectToPeripherals];
//    }];
//    //设置发现设service的Characteristics的委托
//    [baby setBlockOnDiscoverCharacteristics:^(CBPeripheral *peripheral, CBService *service, NSError *error) {
//        NSLog(@"===service name:%@",service.UUID);
//        for (CBCharacteristic *c in service.characteristics) {
//            NSLog(@"charateristic name is :%@",c.UUID);
//        }
//    }];
//    //设置读取characteristics的委托
//    [baby setBlockOnReadValueForCharacteristic:^(CBPeripheral *peripheral, CBCharacteristic *characteristics, NSError *error) {
//        NSLog(@"characteristic name:%@ value is:%@",characteristics.UUID,characteristics.value);
//    }];
//    //设置发现characteristics的descriptors的委托
//    [baby setBlockOnDiscoverDescriptorsForCharacteristic:^(CBPeripheral *peripheral, CBCharacteristic *characteristic, NSError *error) {
//        NSLog(@"===characteristic name:%@",characteristic.service.UUID);
//        for (CBDescriptor *d in characteristic.descriptors) {
//            NSLog(@"CBDescriptor name is :%@",d.UUID);
//        }
//    }];
//    //设置读取Descriptor的委托
//    [baby setBlockOnReadValueForDescriptors:^(CBPeripheral *peripheral, CBDescriptor *descriptor, NSError *error) {
//        NSLog(@"Descriptor name:%@ value is:%@",descriptor.characteristic.UUID, descriptor.value);
//    }];
//
//
//    //设置查找设备的过滤器
//    [baby setFilterOnDiscoverPeripherals:^BOOL(NSString *peripheralName, NSDictionary *advertisementData, NSNumber *RSSI) {
//
//        //最常用的场景是查找某一个前缀开头的设备
//        //        if ([peripheralName hasPrefix:@"Pxxxx"] ) {
//        //            return YES;
//        //        }
//        //        return NO;
//
//        //设置查找规则是名称大于0 ， the search rule is peripheral.name length > 0
//        if (peripheralName.length >0) {
//            return YES;
//        }
//        return NO;
//    }];
//
//
//    [baby setBlockOnCancelAllPeripheralsConnectionBlock:^(CBCentralManager *centralManager) {
//        NSLog(@"setBlockOnCancelAllPeripheralsConnectionBlock");
//    }];
//
//    [baby setBlockOnCancelScanBlock:^(CBCentralManager *centralManager) {
//        NSLog(@"setBlockOnCancelScanBlock");
//    }];
//
//
//    /*设置babyOptions
//
//     参数分别使用在下面这几个地方，若不使用参数则传nil
//     - [centralManager scanForPeripheralsWithServices:scanForPeripheralsWithServices options:scanForPeripheralsWithOptions];
//     - [centralManager connectPeripheral:peripheral options:connectPeripheralWithOptions];
//     - [peripheral discoverServices:discoverWithServices];
//     - [peripheral discoverCharacteristics:discoverWithCharacteristics forService:service];
//
//     该方法支持channel版本:
//     [baby setBabyOptionsAtChannel:(NSString *) scanForPeripheralsWithOptions:<#(NSDictionary *)#> connectPeripheralWithOptions:<#(NSDictionary *)#> scanForPeripheralsWithServices:<#(NSArray *)#> discoverWithServices:<#(NSArray *)#> discoverWithCharacteristics:<#(NSArray *)#>]
//     */
//
//    //示例:
//    //扫描选项->CBCentralManagerScanOptionAllowDuplicatesKey:忽略同一个Peripheral端的多个发现事件被聚合成一个发现事件
//    NSDictionary *scanForPeripheralsWithOptions = @{CBCentralManagerScanOptionAllowDuplicatesKey:@YES};
//    //连接设备->
//    [baby setBabyOptionsWithScanForPeripheralsWithOptions:scanForPeripheralsWithOptions connectPeripheralWithOptions:nil scanForPeripheralsWithServices:nil discoverWithServices:nil discoverWithCharacteristics:nil];
//    //设置读取characteristics的委托
//    [baby setBlockOnReadValueForCharacteristicAtChannel:channelOnCharacteristicView block:^(CBPeripheral *peripheral, CBCharacteristic *characteristics, NSError *error) {
//        //        NSLog(@"CharacteristicViewController===characteristic name:%@ value is:%@",characteristics.UUID,characteristics.value);
//       // [weakSelf insertReadValues:characteristics];
//    }];
//    //设置发现characteristics的descriptors的委托
//    [baby setBlockOnDiscoverDescriptorsForCharacteristicAtChannel:channelOnCharacteristicView block:^(CBPeripheral *peripheral, CBCharacteristic *characteristic, NSError *error) {
//        //        NSLog(@"CharacteristicViewController===characteristic name:%@",characteristic.service.UUID);
//
//        for (CBDescriptor *d in characteristic.descriptors) {
//            //            NSLog(@"CharacteristicViewController CBDescriptor name is :%@",d.UUID);
//        }
//    }];
//    //设置读取Descriptor的委托
//    [baby setBlockOnReadValueForDescriptorsAtChannel:channelOnCharacteristicView block:^(CBPeripheral *peripheral, CBDescriptor *descriptor, NSError *error) {
//
//        NSLog(@"CharacteristicViewController Descriptor name:%@ value is:%@",descriptor.characteristic.UUID, descriptor.value);
//    }];
//
//    //设置写数据成功的block
//    [baby setBlockOnDidWriteValueForCharacteristicAtChannel:channelOnCharacteristicView block:^(CBCharacteristic *characteristic, NSError *error) {
//        NSLog(@"setBlockOnDidWriteValueForCharacteristicAtChannel characteristic:%@ and new value:%@",characteristic.UUID, characteristic.value);
//
//    }];
//
//    //设置通知状态改变的block
//    [baby setBlockOnDidUpdateNotificationStateForCharacteristicAtChannel:channelOnCharacteristicView block:^(CBCharacteristic *characteristic, NSError *error) {
//        NSLog(@"uid:%@,isNotifying:%@",characteristic.UUID,characteristic.isNotifying?@"on":@"off");
//    }];
//
//
//
//}
////写一个值
//-(void)writeValue{
//    //    int i = 1;
//    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:@(55),@"RecordId", nil];
//    NSString *json = [LXCommon dictionaryToJson:dict];
//    NSData *data = [json dataUsingEncoding:NSUTF8StringEncoding];
//
//    [self.currPeripheral writeValue:data forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
//}
////订阅一个值
//-(void)setNotifiy:(id)sender{
//
//    __weak typeof(self)weakSelf = self;
//    UIButton *btn = sender;
//    if(self.currPeripheral.state != CBPeripheralStateConnected) {
//      //  [SVProgressHUD showErrorWithStatus:@"peripheral已经断开连接，请重新连接"];
//        return;
//    }
//    //    if (self.characteristic.properties & CBCharacteristicPropertyNotify ||  self.characteristic.properties & CBCharacteristicPropertyIndicate) {
//
//    if(self.characteristic.isNotifying) {
//        [baby cancelNotify:self.currPeripheral characteristic:self.characteristic];
//        [btn setTitle:@"通知" forState:UIControlStateNormal];
//    }else{
//        [weakSelf.currPeripheral setNotifyValue:YES forCharacteristic:self.characteristic];
//        [btn setTitle:@"取消通知" forState:UIControlStateNormal];
//        [baby notify:self.currPeripheral
//      characteristic:self.characteristic
//               block:^(CBPeripheral *peripheral, CBCharacteristic *characteristics, NSError *error) {
//                   NSLog(@"notify block");
//                   //                NSLog(@"new value %@",characteristics.value);
//              //     [self insertReadValues:characteristics];
//               }];
//    }
//
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    //配置第一个服务s1
    CBMutableService *s1 = makeCBService(@"FFF0");
    //配置s1的3个characteristic
    makeCharacteristicToService(s1, @"FFE2", @"r", @"hello1");//读
    makeCharacteristicToService(s1, @"FFE1", @"w", @"hello2");//写
    makeCharacteristicToService(s1, genUUID(), @"rw", @"hello3");//读写,自动生成uuid
    makeCharacteristicToService(s1, @"FFE1", nil, @"hello4");//默认读写字段
    makeCharacteristicToService(s1, @"FFE2", @"n", @"hello5");//notify字段
    
    //初始化BabyBluetooth 蓝牙库
    baby = [BabyBluetooth shareBabyBluetooth];
    //设置蓝牙委托
    [self babyDelegate];
    baby.scanForPeripherals().connectToPeripherals().discoverServices().discoverCharacteristics()
    .readValueForCharacteristic().discoverDescriptorsForCharacteristic().readValueForDescriptors().begin();
    baby.bePeripheral().addServices(@[s1]).startAdvertising();
}

//蓝牙网关初始化和委托方法设置
- (void)babyDelegate{

    __weak typeof(baby) weakBaby = baby;
    //设置扫描到设备的委托
    [baby setBlockOnDiscoverToPeripherals:^(CBCentralManager *central, CBPeripheral *peripheral, NSDictionary *advertisementData, NSNumber *RSSI) {

        if ([peripheral.name hasPrefix:@"LMJgA-"]) {
             NSLog(@"搜索到了设备:%@",peripheral.name);
        }
    }];

    //设置查找设备的过滤器
    [baby setFilterOnDiscoverPeripherals:^BOOL(NSString *peripheralName, NSDictionary *advertisementData, NSNumber *RSSI) {
        //设置查找规则是名称大于1 ， the search rule is peripheral.name length > 2
        if (peripheralName.length >1) {
            return YES;
        }
        return NO;
    }];

    //连接过滤器
    __block BOOL isFirst = YES;
    [baby setFilterOnConnectToPeripherals:^BOOL(NSString *peripheralName, NSDictionary *advertisementData, NSNumber *RSSI) {
        //这里的规则是：连接第一个设备
//        isFirst = NO;
//        return YES;
        
        //这里的规则是：连接第一个P打头的设备
                if(isFirst && [peripheralName hasPrefix:@"LMJgA-"]){
                    isFirst = NO;
                    return YES;
                }
                return NO;
    }];
    //写
    //NSString *cookie = KUserDefault_Get(@"Set-Cookie");
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:@(55),@"RecordId", nil];
    NSString *json = [LXCommon dictionaryToJson:dict];
    NSData *data = [json dataUsingEncoding:NSUTF8StringEncoding];
    [baby setBlockOnDidWriteValueForCharacteristicAtChannel:json block:^(CBCharacteristic *characteristic, NSError *error) {
        DLog(@"characteristic%@ ----error %@,error",characteristic.value,error.localizedDescription);
    }];

    //读取
    [baby setBlockOnReadValueForCharacteristic:^(CBPeripheral *peripheral, CBCharacteristic *characteristic, NSError *error) {
        DLog(@"最新的设备值%@",characteristic.value);
    }];
    //设置设备连接成功的委托
    [baby setBlockOnConnected:^(CBCentralManager *central, CBPeripheral *peripheral) {
        //设置连接成功的block
        NSLog(@"设备：%@--连接成功",peripheral.name);
        [LXMessage showSuccessMessage:@"连接成功"];
        //停止扫描
        [weakBaby cancelScan];
    }];

    //设置发现设备的Services的委托
    [baby setBlockOnDiscoverServices:^(CBPeripheral *peripheral, NSError *error) {

        for (CBService *service in peripheral.services) {
            NSLog(@"搜索到服务:%@",service.UUID.UUIDString);
        }
    }];
    LXWeakSelf(self);
    //设置发现设service的Characteristics的委托
    [baby setBlockOnDiscoverCharacteristics:^(CBPeripheral *peripheral, CBService *service, NSError *error) {

        NSLog(@"===service name:%@",service.UUID);
        for (CBCharacteristic *c in service.characteristics) {
            if ([c.UUID.UUIDString isEqualToString:@"0003CBBB-0000-1000-8000-00805F9B0131"]) {
                [peripheral writeValue:data forCharacteristic:c type:CBCharacteristicWriteWithResponse];

                [LXMessage showSuccessMessage:@"发送成功"];
                [weakBaby notify:peripheral characteristic:c block:^(CBPeripheral *peripheral, CBCharacteristic *characteristics, NSError *error) {
                    NSString *str = [[NSString alloc] initWithData:characteristics.value encoding:NSUTF8StringEncoding];
                    DLog(@"characteristics %@",str);
                }];
            }
        }
    }];
    [baby setBlockOnDidWriteValueForCharacteristicAtChannel:@"0003CBBB-0000-1000-8000-00805F9B0131" block:^(CBCharacteristic *characteristic, NSError *error) {
        DLog(@"characteristic name:%@ value is:%@",characteristic.UUID,characteristic.value);
    }];
    //设置读取characteristics的委托
    [baby setBlockOnReadValueForCharacteristic:^(CBPeripheral *peripheral, CBCharacteristic *characteristics, NSError *error) {
        DLog(@"characteristic name:%@ value is:%@",characteristics.UUID,characteristics.value);
    }];
    //设置发现characteristics的descriptors的委托
    [baby setBlockOnDiscoverDescriptorsForCharacteristic:^(CBPeripheral *peripheral, CBCharacteristic *characteristic, NSError *error) {
        DLog(@"===characteristic name:%@",characteristic.service.UUID);
        for (CBDescriptor *d in characteristic.descriptors) {
            DLog(@"CBDescriptor name is :%@",d.UUID);
        }
    }];
    //设置读取Descriptor的委托
    [baby setBlockOnReadValueForDescriptors:^(CBPeripheral *peripheral, CBDescriptor *descriptor, NSError *error) {
        DLog(@"Descriptor name:%@ value is:%@",descriptor.characteristic.UUID, descriptor.description);
            [peripheral readValueForCharacteristic:descriptor.characteristic];
    }];
}
//
////分包发送蓝牙数据
//-(void)sendMsgWithSubPackage:(NSData*)msgData
//                  Peripheral:(CBPeripheral*)peripheral
//              Characteristic:(CBCharacteristic*)character
//{
//    for (int i = 0; i < [msgData length]; i += BLE_SEND_MAX_LEN) {
//        // 预加 最大包长度，如果依然小于总数据长度，可以取最大包数据大小
//        if ((i + BLE_SEND_MAX_LEN) < [msgData length]) {
//            NSString *rangeStr = [NSString stringWithFormat:@"%i,%i", i, BLE_SEND_MAX_LEN];
//            NSData *subData = [msgData subdataWithRange:NSRangeFromString(rangeStr)];
//            NSLog(@"%@",subData);
////            [baby.peripheralManager writeCharacteristic:peripheral
////                       characteristic:character
////                                value:subData];
//            [peripheral writeValue:subData forCharacteristic:character type:CBCharacteristicWriteWithoutResponse];
//            //根据接收模块的处理能力做相应延时
//            usleep(20 * 1000);
//        }
//        else {
//            NSString *rangeStr = [NSString stringWithFormat:@"%i,%i", i, (int)([msgData length] - i)];
//            NSData *subData = [msgData subdataWithRange:NSRangeFromString(rangeStr)];
//
//            [peripheral writeValue:subData forCharacteristic:character type:CBCharacteristicWriteWithoutResponse];
//            usleep(20 * 1000);
//        }
//    }
//    [LXMessage showSuccessMessage:@"已经发送"];
//}
@end
