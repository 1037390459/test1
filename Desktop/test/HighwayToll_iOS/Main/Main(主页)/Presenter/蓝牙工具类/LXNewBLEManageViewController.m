//
//  LXNewBLEManageViewController.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/12/23.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXNewBLEManageViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreBluetooth/CBService.h>
#import "LXBlueToothManager.h"
/*
 1、蓝牙设备流程：先扫描到外设 --- 获取服务 --- 获取特征值 --- 获取描述
 2、接受数据是 --- 从串口数据通道转发到蓝牙输出的数据 ---- 可以自由的关闭（及注册的通知）
 3、写入数据 --- 是APP通过BLE API接口，蓝牙输入转发到串口输出
 */

@interface LXNewBLEManageViewController ()<CBCentralManagerDelegate,CBPeripheralDelegate>{
    //系统蓝牙设备管理对象，可以把他理解为主设备，通过他，可以去扫描和链接外设
    CBCentralManager *manager;
}
@property (nonatomic,assign) bool falg; /**< */
@end

@implementation LXNewBLEManageViewController

+ (instancetype)manager{
    static LXNewBLEManageViewController *model;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        model = [[LXNewBLEManageViewController alloc] init];
        [model config];
    });
    return model;
}
- (void)config{
    _falg = YES; 
    manager = [[CBCentralManager alloc]initWithDelegate:self queue:dispatch_get_main_queue()];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _falg = YES;
    /*
     设置主设备的委托,CBCentralManagerDelegate
     必须实现的：
     - (void)centralManagerDidUpdateState:(CBCentralManager *)central;//主设备状态改变的委托，在初始化CBCentralManager的适合会打开设备，只有当设备正确打开后才能使用
     其他选择实现的委托中比较重要的：
     - (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI; //找到外设的委托
     - (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral;//连接外设成功的委托
     - (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error;//外设连接失败的委托
     - (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error;//断开外设的委托
     */
    
    //初始化并设置委托和线程队列，最好一个线程的参数可以为nil，默认会就main线程
    manager = [[CBCentralManager alloc]initWithDelegate:self queue:dispatch_get_main_queue()];
    
    //持有发现的设备,如果不持有设备会导致CBPeripheralDelegate方法不能正确回调
}
- (BOOL)blueToothState{
    
    if (manager.state == CBCentralManagerStatePoweredOn) {
        return YES;
    }else{
        return NO;
    }
}
-(void)centralManagerDidUpdateState:(CBCentralManager *)central{
    
    switch (central.state) {
        case CBCentralManagerStateUnknown:
            NSLog(@">>>CBCentralManagerStateUnknown");
            break;
        case CBCentralManagerStateResetting:
            NSLog(@">>>CBCentralManagerStateResetting");
            break;
        case CBCentralManagerStateUnsupported:
            NSLog(@">>>CBCentralManagerStateUnsupported");
            break;
        case CBCentralManagerStateUnauthorized:
            NSLog(@">>>CBCentralManagerStateUnauthorized");
            break;
        case CBCentralManagerStatePoweredOff:
            NSLog(@">>>CBCentralManagerStatePoweredOff");
            break;
        case CBCentralManagerStatePoweredOn:
            //开始扫描周围的外设
            /*
             第一个参数nil就是扫描周围所有的外设，扫描到外设后会进入
             - (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI;
             */
            [central scanForPeripheralsWithServices:nil options:nil];
            
            break;
        default:
            break;
    }
    
}

//扫描到设备会进入方法
-(void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI{
    
    DLog(@"当扫描到设备:%@",peripheral.name);
    //接下连接我们的测试设备，如果你没有设备，可以下载一个app叫lightbule的app去模拟一个设备
    //这里自己去设置下连接规则，我设置的是P开头的设备
    //    if ([peripheral.name hasPrefix:@"P"]){
    /*
     一个主设备最多能连7个外设，每个外设最多只能给一个主设备连接,连接成功，失败，断开会进入各自的委托
     - (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral;//连接外设成功的委托
     - (void)centra`lManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error;//外设连接失败的委托
     - (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error;//断开外设的委托
     */
    
    //找到的设备必须持有它，否则CBCentralManager中也不会保存peripheral，那么CBPeripheralDelegate中的方法也不会被调用！！
    
    if ([peripheral.name hasPrefix:@"LMJgA-"]) {
        if (_falg) {
            [central connectPeripheral:peripheral options:nil];
        }
    }
}


//连接到Peripherals-失败
-(void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    DLog(@">>>连接到名称为（%@）的设备-失败,原因:%@",[peripheral name],[error localizedDescription]);
}

//Peripherals断开连接
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    if ([[peripheral name] hasPrefix:@"LMJgA-"]) {
        if (_falg) {
            [central connectPeripheral:peripheral options:nil];
        }
    }
    
}
//连接到Peripherals-成功
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    NSLog(@">>>连接到名称为（%@）的设备-成功",peripheral.name);
    //设置的peripheral委托CBPeripheralDelegate
    //@interface ViewController : UIViewController<CBCentralManagerDelegate,CBPeripheralDelegate>
    [peripheral setDelegate:self];
    //扫描外设Services，成功后会进入方法：-(void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
    [peripheral discoverServices:nil];
    [manager stopScan];
}


//扫描到Services
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
    //  NSLog(@">>>扫描到服务：%@",peripheral.services);
    if (error)
    {
        DLog(@">>>Discovered services for %@ with error: %@", peripheral.name, [error localizedDescription]);
        return;
    }
    
    for (CBService *service in peripheral.services) {
        DLog(@"%@",service.UUID);
        //扫描每个service的Characteristics，扫描到后会进入方法： -(void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
        [peripheral discoverCharacteristics:nil forService:service];
    }
    
}

//扫描到Characteristics
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error{
    if (error)
    {
        DLog(@"error Discovered characteristics for %@ with error: %@", service.UUID, [error localizedDescription]);
        return;
    }
    
    for (CBCharacteristic *characteristic in service.characteristics)
    {
        DLog(@"service:%@ 的 Characteristic: %@",service.UUID,characteristic.UUID);
    }
    
    //获取Characteristic的值，读到数据会进入方法：-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
    
    
    //搜索Characteristic的Descriptors，读到数据会进入方法：-(void)peripheral:(CBPeripheral *)peripheral didDiscoverDescriptorsForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
    for (CBCharacteristic *characteristic in service.characteristics){
        [peripheral discoverDescriptorsForCharacteristic:characteristic];
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:@(55),@"RecordId", nil];
    NSString *json = [self dictionaryToJson:dict];
    NSData *data = [json dataUsingEncoding:NSUTF8StringEncoding];
    
    for (CBCharacteristic *characteristic in service.characteristics){
        
        if ([characteristic.UUID.UUIDString containsString:@"FFE1"]) {
            
            //   if(characteristic.properties & CBCharacteristicPropertyWrite){
            /*
             最好一个type参数可以为CBCharacteristicWriteWithResponse或type:CBCharacteristicWriteWithResponse,区别是是否会有反馈
             */
            
            sleep(0.1);
            [peripheral writeValue:data forCharacteristic:characteristic type:CBCharacteristicWriteWithoutResponse];
//            [[[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"OK" delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles:@"OK", nil] show];
//
//            //}else{
//            //  NSLog(@"该字段不可写！");
//            // }
        }
        
        if ([characteristic.UUID.UUIDString containsString:@"FFE2"]) {
            [self notifyCharacteristic:peripheral characteristic:characteristic];
        }
    }
    
}
//特征值读取，或者得到更改通知后的回调
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    if ([characteristic.UUID.UUIDString containsString:@"FFE2"]) {
        //打印出characteristic的UUID和值
        //!注意，value的类型是NSData，具体开发时，会根据外设协议制定的方式去解析数据
        NSString *str = [[NSString alloc] initWithData:characteristic.value encoding:NSUTF8StringEncoding];
        if ([str containsString:@"IsSucceed"]) {
            DLog(@"characteristic uuid:%@  value:%@",characteristic.UUID,str);
         //   [[[UIAlertView alloc] initWithTitle:@"温馨提示" message:str delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles:@"OK", nil] show];
            _falg = NO;
            [self disconnectPeripheral:manager peripheral:peripheral];
            
        }
    }
}
//写完了
- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic
             error:(NSError *)error{
    DLog(@"characteristic uuid:%@  value:%@",characteristic.UUID,error.localizedDescription);
  
}
//搜索到Characteristic的Descriptors
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverDescriptorsForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    
    //打印出Characteristic和他的Descriptors
    DLog(@"characteristic uuid:%@",characteristic.UUID);
    for (CBDescriptor *d in characteristic.descriptors) {
        DLog(@"Descriptor uuid:%@",d.UUID);
    }
    
}
- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    
    if ([characteristic.UUID.UUIDString containsString:@"FFE2"]) {
        //打印出characteristic的UUID和值
        //!注意，value的类型是NSData，具体开发时，会根据外设协议制定的方式去解析数据
        [peripheral readValueForCharacteristic:characteristic];
    }
}

//获取到Descriptors的值
-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForDescriptor:(CBDescriptor *)descriptor error:(NSError *)error{
    //打印出DescriptorsUUID 和value
    //这个descriptor都是对于characteristic的描述，一般都是字符串，所以这里我们转换成字符串去解析
    DLog(@"characteristic uuid:%@  value:%@",[NSString stringWithFormat:@"%@",descriptor.UUID],descriptor.value);
}

//写数据
-(void)writeCharacteristic:(CBPeripheral *)peripheral
            characteristic:(CBCharacteristic *)characteristic
                     value:(NSData *)value{
    
    //打印出 characteristic 的权限，可以看到有很多种，这是一个NS_OPTIONS，就是可以同时用于好几个值，常见的有read，write，notify，indicate，知知道这几个基本就够用了，前连个是读写权限，后两个都是通知，两种不同的通知方式。
    /*
     typedef NS_OPTIONS(NSUInteger, CBCharacteristicProperties) {
     CBCharacteristicPropertyBroadcast                                                = 0x01,
     CBCharacteristicPropertyRead                                                    = 0x02,
     CBCharacteristicPropertyWriteWithoutResponse                                    = 0x04,
     CBCharacteristicPropertyWrite                                                    = 0x08,
     CBCharacteristicPropertyNotify                                                    = 0x10,
     CBCharacteristicPropertyIndicate                                                = 0x20,
     CBCharacteristicPropertyAuthenticatedSignedWrites                                = 0x40,
     CBCharacteristicPropertyExtendedProperties                                        = 0x80,
     CBCharacteristicPropertyNotifyEncryptionRequired NS_ENUM_AVAILABLE(NA, 6_0)        = 0x100,
     CBCharacteristicPropertyIndicateEncryptionRequired NS_ENUM_AVAILABLE(NA, 6_0)    = 0x200
     };
     
     */
    DLog(@"%lu", (unsigned long)characteristic.properties);
    
    
    //只有 characteristic.properties 有write的权限才可以写
    if(characteristic.properties & CBCharacteristicPropertyWrite){
        /*
         最好一个type参数可以为CBCharacteristicWriteWithResponse或type:CBCharacteristicWriteWithResponse,区别是是否会有反馈
         */
        [peripheral writeValue:value forCharacteristic:characteristic type:CBCharacteristicWriteWithResponse];
    }else{
        DLog(@"该字段不可写！");
    }
    
    
}

//设置通知
-(void)notifyCharacteristic:(CBPeripheral *)peripheral
             characteristic:(CBCharacteristic *)characteristic{
    //设置通知，数据通知会进入：didUpdateValueForCharacteristic方法
    [peripheral setNotifyValue:YES forCharacteristic:characteristic];
    
}

//取消通知
-(void)cancelNotifyCharacteristic:(CBPeripheral *)peripheral
                   characteristic:(CBCharacteristic *)characteristic{
    
    [peripheral setNotifyValue:NO forCharacteristic:characteristic];
}

//停止扫描并断开连接
-(void)disconnectPeripheral:(CBCentralManager *)centralManager
                 peripheral:(CBPeripheral *)peripheral{
    //停止扫描
    [centralManager stopScan];
    //断开连接
    [centralManager cancelPeripheralConnection:peripheral];
}


- (NSString*) dictionaryToJson:(NSDictionary *)dic

{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}
- (void)canScan{
    [manager scanForPeripheralsWithServices:nil options:nil];
}
- (void)stopScan{
    //停止扫描
    [manager stopScan];
}
@end
