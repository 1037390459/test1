//
//  LXMBlueTooth.m
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/12/12.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXMBlueTooth.h"

typedef struct {
    int index;
    int RSSI;
}PERIPHERALS_RSSI;

typedef struct _INT{
    char buff[30];
}INT_STRUCT;

typedef struct scanProcessStep{
    char step[20];
}SCANPROCESSSTEP_STRUCT;

#define STEP1   0x01
#define STEP2   0x02
#define STEP3   0x04
#define STEP4   0x08
@implementation LXMBlueTooth

// 写入数据，发送给外设
-(void)_writeValue:(int)serviceUUID
characteristicUUID:(int)characteristicUUID
        peripheral:(CBPeripheral *)peripheral
              data:(NSData *)data{
    UInt16 s = [self _swap:serviceUUID];
    UInt16 c = [self _swap:characteristicUUID];
    NSData *sd = [[NSData alloc] initWithBytes:(char *)&s length:2];
    NSData *cd = [[NSData alloc] initWithBytes:(char *)&c length:2];
    CBUUID *su = [CBUUID UUIDWithData:sd];
    CBUUID *cu = [CBUUID UUIDWithData:cd];
    CBService *service = [self _discoverServiceFromUUID:su peripheral:peripheral];
    // 如果服务不存在打印
    if (!service) {
        DLog(@"Could not find service with UUID %s on peripheral with UUID %s\r\n",[self CBUUIDToString:su],[self UUIDToString:(__bridge CFUUIDRef)(peripheral.identifier.UUIDString)]);
        return;
    }
    
    CBCharacteristic *characteristic = [self _discoverCharacteristicFromUUID:cu service:service];
    // 如果特性不存在打印
    if (!characteristic) {
        DLog(@"Could not find characteristic with UUID %s on service with UUID %s on peripheral with UUID %s\r\n",[self CBUUIDToString:cu],[self CBUUIDToString:su],[self UUIDToString:(__bridge CFUUIDRef)(peripheral.identifier.UUIDString)]);
        return;
    }
    // 开始写入数据
    [peripheral writeValue:data forCharacteristic:characteristic type:CBCharacteristicWriteWithResponse];
}
// 从外设读取数据
-(void)_readValue:(int)serviceUUID
characteristicUUID:(int)characteristicUUID
       peripheral:(CBPeripheral *)peripheral{
    UInt16 s = [self _swap:serviceUUID];
    UInt16 c = [self _swap:characteristicUUID];
    NSData *sd = [[NSData alloc] initWithBytes:(char *)&s length:2];
    NSData *cd = [[NSData alloc] initWithBytes:(char *)&c length:2];
    CBUUID *su = [CBUUID UUIDWithData:sd];
    CBUUID *cu = [CBUUID UUIDWithData:cd];
    CBService *service = [self _discoverServiceFromUUID:su peripheral:peripheral];
    // 如果服务不存在打印
    if (!service) {
        DLog(@"Could not find service with UUID %s on peripheral with UUID %s\r\n",[self CBUUIDToString:su],[self UUIDToString:(__bridge CFUUIDRef)(peripheral.identifier.UUIDString)]);
        return;
    }
    
    CBCharacteristic *characteristic = [self _discoverCharacteristicFromUUID:cu service:service];
    // 如果特性不存在打印
    if (!characteristic) {
        DLog(@"Could not find characteristic with UUID %s on service with UUID %s on peripheral with UUID %s\r\n",[self CBUUIDToString:cu],[self CBUUIDToString:su],[self UUIDToString:(__bridge CFUUIDRef)(peripheral.identifier.UUIDString)]);
        return;
    }
    
    [peripheral readValueForCharacteristic:characteristic];
}

// 该外设注册通知状态是否活跃
-(void)_notification:(int)serviceUUID
  characteristicUUID:(int)characteristicUUID
          peripheral:(CBPeripheral *)peripheral
            isActive:(BOOL)isActive{
    UInt16 s = [self _swap:serviceUUID];
    UInt16 c = [self _swap:characteristicUUID];
    NSData *sd = [[NSData alloc] initWithBytes:(char *)&s length:2];
    NSData *cd = [[NSData alloc] initWithBytes:(char *)&c length:2];
    CBUUID *su = [CBUUID UUIDWithData:sd];
    CBUUID *cu = [CBUUID UUIDWithData:cd];
    CBService *service = [self _discoverServiceFromUUID:su peripheral:peripheral];
    CBCharacteristic *characteristic = [self _discoverCharacteristicFromUUID:cu service:service];
    if (!characteristic) {
        return;
    }
    [peripheral setNotifyValue:isActive forCharacteristic:characteristic];
}

- (UInt16)_swap:(UInt16) s{
    UInt16 temp = s << 8;
    temp |= (s >> 8);
    return temp;
}

// 初始化中心管理器
- (void)_initializeCenterManager{
    self.BLECenterManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
}

// 搜索外设，并设置超时时间
- (int)_scanBLEPeripherals:(int)timeOut{
    if (self.BLECenterManager.state != CBCentralManagerStatePoweredOn) {
        return -1; // 扫描设备没有打开
    }
    if (_scanKeepTimer == nil) {
        _scanKeepTimer = [NSTimer scheduledTimerWithTimeInterval:(float)timeOut target:self selector:@selector(scanTimer:) userInfo:nil repeats:NO];
    }
    [self.BLECenterManager stopScan];
    [self.BLECenterManager scanForPeripheralsWithServices:nil options:0];
    _isScan = YES;
    return 0;      // 开始扫描
}

// 停止扫描
- (void)_stopScan{
    [self.BLECenterManager stopScan];
    _isScan = NO;
}

// 扫描定时器
- (void)scanTimer:(NSTimer *)timer{
    [self.BLECenterManager stopScan];
    DLog(@"discoveredPeripherals : %ld",[self.peripherals count]);
    /* 打印所有的扫描到的设备 */
    [self _logDiscoveredPeripherals];
    /* 通知结束扫描 */
    [[NSNotificationCenter defaultCenter] postNotificationName:STOPSCAN object:nil];
    /* 销毁定时器 */
    [_scanKeepTimer invalidate];
    _scanKeepTimer = nil;
}


// 开始连接外设
- (void)_startConnectPeripheral:(CBPeripheral *)peripheral{
    
    //    DLog(@"Connecting to peripheral with UUID : %s\r\n",[self UUIDToString:(__bridge CFUUIDRef)(peripheral.identifier.UUIDString)]);
    self.currentActivePeripheral = peripheral;
    peripheral.delegate = self;
    if (peripheral) {
        [self.BLECenterManager connectPeripheral:self.currentActivePeripheral options:nil];
    }
}
- (const char *)BLECenterManagerStateToString:(int)state{
    
    switch(state) {
        case CBCentralManagerStateUnknown:
            return "State unknown (CBCentralManagerStateUnknown)";
        case CBCentralManagerStateResetting:
            return "State resetting (CBCentralManagerStateUnknown)";
        case CBCentralManagerStateUnsupported:
            return "State BLE unsupported (CBCentralManagerStateResetting)";
        case CBCentralManagerStateUnauthorized:
            return "State unauthorized (CBCentralManagerStateUnauthorized)";
        case CBCentralManagerStatePoweredOff:
            return "State BLE powered off (CBCentralManagerStatePoweredOff)";
        case CBCentralManagerStatePoweredOn:
        {
            // 蓝牙设备已经断开
            [[NSNotificationCenter defaultCenter]postNotificationName:kBLUETOOTH_ISALREADLY_OPEN object:nil];
            return "State powered up and ready (CBCentralManagerStatePoweredOn)";
        }
        default:
            return "State unknown";
    }
    return "Unknown state";
}

- (id)_getCharcteristicDiscriptorFromCurrnetActiveDescriptorsArray:(CBCharacteristic *)characteristic{
    
    for (NSInteger i = 0; i < self.currentActiveDescriptors.count; i ++) {
        CBDescriptor *p = [self.currentActiveDescriptors objectAtIndex:i];
        if (p.characteristic.UUID == characteristic.UUID) {
            return p.value;
        }
    }
    return nil;
}

// 判断当前特征值是否是活跃的(正在连接中的)
- (BOOL)_isActiveCharacteristic:(CBCharacteristic *)characteristic{
    
    for(int i = 0; i < self.currentActiveCharacteristics.count; i++) {
        CBCharacteristic *p = [self.currentActiveCharacteristics objectAtIndex:i];
        if (p.UUID == characteristic.UUID) {
            return YES;
        }
    }
    DLog(@"isn't Active characteristics !\r\n");
    return NO;
}

// 从外设中获取所有的服务
- (void)_getAllServicesFromPeripheral:(CBPeripheral *)Peripheral{
    /* Discover all services without filter(可以添加过滤条件) */
    [Peripheral discoverServices:nil];
}

// 从外设中获取所有的特征值
- (void)_getAllCharacteristicFromPeripheral:(CBPeripheral *)Peripheral{
    
    for (NSInteger i = 0; i < Peripheral.services.count; i ++) {
        CBService *service = [Peripheral.services objectAtIndex:i];
        DLog(@"Fetching characteristics for service with UUID : %s\r\n",[self CBUUIDToString:service.UUID]);
        /* 开始读取当前的服务的特征值（对特征值不做过滤） */
        [Peripheral discoverCharacteristics:nil forService:service];
    }
}

// 发现服务根据UUID 和 peripheral
- (CBService *)_discoverServiceFromUUID:(CBUUID *)UUID peripheral:(CBPeripheral *)peripheral{
    
    for(int i = 0; i < peripheral.services.count; i++) {
        CBService *s = [peripheral.services objectAtIndex:i];
        if ([self compareCBUUID:s.UUID UUID2:UUID]) return s;
    }
    return nil; //Service not found on this peripheral
}

// 发现特性 根据UUID 和 service
- (CBCharacteristic *)_discoverCharacteristicFromUUID:(CBUUID *)UUID service:(CBService *)service{
    
    for(int i=0; i < service.characteristics.count; i++) {
        CBCharacteristic *characteristic = [service.characteristics objectAtIndex:i];
        if ([self compareCBUUID:characteristic.UUID UUID2:UUID]) return characteristic;
    }
    return nil; //Characteristic not found on this service
}

// 打印已经扫描到的所有外设
- (void)_logDiscoveredPeripherals{
    for (CBPeripheral *p in self.peripherals) {
        CFStringRef s = CFUUIDCreateString(NULL, (__bridge CFUUIDRef)p.identifier.UUIDString);
        DLog(@"%s\r\n",CFStringGetCStringPtr(s, 0));
        [self _logPeripheralInfo:p];
    }
    // 发出通知，参数为外围设备对象（通知设备列表更新)
    [[NSNotificationCenter defaultCenter] postNotificationName:BLE_DEVICE_FOUND object:nil];
}

// 打印单个外设的详细信息
- (void)_logPeripheralInfo:(CBPeripheral *)peripheral{
    
    CFStringRef s = CFUUIDCreateString(NULL, (__bridge CFUUIDRef)(peripheral.identifier.UUIDString));
    DLog(@"---------打印的外设信息-------------\r\n");
    DLog(@"UUID : %s\r\n",CFStringGetCStringPtr(s, 0));
    DLog(@"Name : %s\r\n",[peripheral.name cStringUsingEncoding:NSStringEncodingConversionAllowLossy]);
    DLog(@"isConnected : %d\r\n",peripheral.state == CBPeripheralStateDisconnected);
    DLog(@"-------------------------------------\r\n");
}

// 打印特征值描述
- (void)_logCharacteristicDescriptorMessage:(CBDescriptor *)descriptor{
    
    CBCharacteristic *c = descriptor.characteristic;
    DLog(@" service.UUID:%@ (%s)",c.service.UUID,[self CBUUIDToString:c.service.UUID]);
    DLog(@"         UUID:%@ (%s)",c.UUID,[self CBUUIDToString:c.UUID]);
    DLog(@"   properties:0x%02lx",(unsigned long)c.properties);
    DLog(@" value.length:%lu",c.value.length);
    INT_STRUCT buf1;
    [c.value getBytes:&buf1 length:c.value.length];
    DLog(@"                                                       value:");
    for(int i=0; i < c.value.length; i++) {
        DLog(@"%02x ",buf1.buff[i]&0x000000ff);
    }
    DLog(@"\r\n");
    DLog(@"  isNotifying:%d\r\n",c.isNotifying);
    DLog(@"      :%@ ",c.UUID);
    DLog(@"  UUID:%@ ",descriptor.UUID);
    DLog(@"    id:%@ ",descriptor.value);
}

// 打印特征值详细信息
- (void)_logCharacteristicInfoMessage:(CBCharacteristic *)characteristic{
    //    DLog(@"properties:0x%02lx",(unsigned long)characteristic.properties);
    //    DLog(@" value.length:%lu",characteristic.value.length);
    //    INT_STRUCT buf1;
    //    [characteristic.value getBytes:&buf1 length:characteristic.value.length];
    //    DLog(@"        value:");
    //    for(int i=0; i < characteristic.value.length; i++) {
    //        DLog(@"%02x ",buf1.buff[i]&0x000000ff);
    //    }
    //    DLog(@"  isNotifying:%d",characteristic.isNotifying);
    //    //NSString *provincName = [NSString stringWithFormat:@"%@", [self _getCharcteristicDiscriptorFromCurrnetActiveDescriptorsArray:characteristic]];
    //    //DLog(@"   Discriptor:%@ ",provincName);
}


-(void) SaveToActiveCharacteristic:(CBCharacteristic *)c{
    
    if (!self.currentActiveCharacteristics){      //列表为空，第一次发现新设备
        self.currentActiveCharacteristics = [[NSMutableArray alloc] initWithObjects:c,nil];
    }
    else {  //列表中有曾经发现的设备，如果重复发现则刷新
        for(int i = 0; i < self.currentActiveCharacteristics.count; i++) {
            CBCharacteristic *p = [self.currentActiveCharacteristics objectAtIndex:i];
            if (p.UUID == c.UUID) {
                //重复取代他的位置
                [self.currentActiveCharacteristics replaceObjectAtIndex:i withObject:c];
                return ;
            }
        }
        //发现的外围设备，被保存在对象的peripherals 缓冲中
        [self.currentActiveCharacteristics addObject:c];
    }
}

-(void) UpdateToActiveCharacteristic:(CBCharacteristic *)c{
    /* 列表为空第一次发现设备 */
    if (!self.currentActiveCharacteristics)
        DLog(@"no characteristics !\r\n");
    
    for(int i = 0; i < self.currentActiveCharacteristics.count; i++) {
        CBCharacteristic *p = [self.currentActiveCharacteristics objectAtIndex:i];
        if (p.UUID == c.UUID) {
            [self.currentActiveCharacteristics replaceObjectAtIndex:i withObject:c];
            [self _logCharacteristicInfoMessage:c];
            return ;
        }
    }
    DLog(@"Can't find this characteristics !\r\n");
}

-(void) SaveToActiveDescriptors:(CBDescriptor *)descriptor{
    //列表中有曾经发现的设备，如果重复发现则刷新，
    for(int i = 0; i < self.currentActiveDescriptors.count; i++) {
        CBDescriptor *p = [self.currentActiveDescriptors objectAtIndex:i];
        if (p.characteristic.UUID == descriptor.characteristic.UUID) {
            DLog(@"%d > %lu !!!!!!!!! \r\n",i,(unsigned long)self.currentActiveDescriptors.count);
            [self.currentActiveDescriptors replaceObjectAtIndex:i withObject:descriptor];
            return;
        }
    }
    //发现的外围设备，被保存在对象的peripherals 缓冲中
    [self.currentActiveDescriptors addObject:descriptor];
    DLog(@"New descriptor, adding ... ");
    DLog(@" descriptor UUID %s",[self CBUUIDToString:descriptor.characteristic.UUID]);
    DLog(@" %s ",[self CBUUIDToString:descriptor.UUID]);
    DLog(@" %@ ",descriptor.value);
    DLog(@"activeDescriptors count = %lu",(unsigned long)[self.currentActiveDescriptors count]);
    DLog(@"activeCharacteristics count = %lu",(unsigned long)[self.currentActiveCharacteristics count]);
}

#pragma mark ---- 关于UUID的一些操作
-(const char *) UUIDToString:(CFUUIDRef) UUID{
    if (!UUID) return "NULL";
    CFStringRef s = CFUUIDCreateString(NULL, UUID);
    return CFStringGetCStringPtr(s, 0);
}

-(const char *) CBUUIDToString:(CBUUID *) UUID{
    return [[UUID.data description] cStringUsingEncoding:NSStringEncodingConversionAllowLossy];
}

-(int) compareCBUUID:(CBUUID *) UUID1 UUID2:(CBUUID *)UUID2{
    char b1[16];
    char b2[16];
    [UUID1.data getBytes:b1];
    [UUID2.data getBytes:b2];
    if (memcmp(b1, b2, UUID1.data.length) == 0) return 1;
    else return 0;
}

-(int) compareCBUUIDToInt:(CBUUID *) UUID1 UUID2:(UInt16)UUID2{
    
    char b1[16];
    [UUID1.data getBytes:b1 length:16];
    UInt16 b2 = [self _swap:UUID2];
    if (memcmp(b1, (char *)&b2, 2) == 0) return 1;
    else return 0;
}

-(UInt16) CBUUIDToInt:(CBUUID *) UUID{
    
    char b1[16];
    [UUID.data getBytes:b1 length:16];
    return ((b1[0] << 8) | b1[1]);
}

-(int) UUIDSAreEqual:(CFUUIDRef)UUID1 u2:(CFUUIDRef)UUID2{
    CFUUIDBytes b1 = CFUUIDGetUUIDBytes(UUID1);
    CFUUIDBytes b2 = CFUUIDGetUUIDBytes(UUID2);
    if (memcmp(&b1, &b2, 16) == 0) {
        return 1 ;
    }
    return 0 ;
}

-(CBUUID *) IntToCBUUID:(UInt16)UUID {
    char t[16];
    t[0] = ((UUID >> 8) & 0xff); t[1] = (UUID & 0xff);
    NSData *data = [[NSData alloc] initWithBytes:t length:16];
    return [CBUUID UUIDWithData:data];
}


#pragma mark -------------------------------------- BLE 中心设备代理协议方法 -----------------------------------------------

// 中心设备管理状态的回调
- (void)centralManagerDidUpdateState:(CBCentralManager *)central{
    DLog(@"Status of CoreBluetooth central manager changed %ld (%s)\r\n",(long)central.state,[self BLECenterManagerStateToString:central.state]);
}

//// 将要重新获取设备外设详情
- (void)centralManager:(CBCentralManager *)central didRetrievePeripherals:(NSArray *)peripherals{
    
    DLog(@"从新找回Peripherals \r\n");
}

- (void)centralManager:(CBCentralManager *)central didRetrieveConnectedPeripherals:(NSArray *)peripherals{
    
    DLog(@"从新找回已经连接的Peripherals \r\n");
}


// 中心设备发现外围设备的回调，包含广播数据包，如果发现已经在列表中的设备，则覆盖保存一次

/*
 每找到一个 peripheral 都会调用 centralManager:didDiscoverPeripheral:advertisementData:RSSI: 方法。另外，当已发现的 peripheral  发送的数据包有变化时，这个代理方法同样会调用。
 */

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI{
    NSArray *rssiArray;
    DLog(@"扫描到的RSSI : %ld , %@\n",(long)[RSSI integerValue],peripheral.name);
    DLog(@"advertisementData is %@",advertisementData);
    int i;
    i = 0;
    if (self.peripherals.count == 0)
    { /* 列表为空，第一次发现设备,初始化 */
        if ([peripheral.name containsString:@"LMJgA-"] ) {
            self.peripherals = [[NSMutableSet alloc] initWithObjects:peripheral, nil];
            
            //            [[NSNotificationCenter defaultCenter] postNotificationName:@"nameRSSI" object:nil userInfo:@{@"name":peripheral.name?peripheral.name : @"未知的设备",@"RSSI":@([RSSI integerValue])}];
        }
    }else
    {
        //        for (i = 0; i < self.peripherals.count; i++)
        //        {
        //            CBPeripheral *peri = [self.peripherals objectAtIndex:i];
        //            /* UUID相同现在这一个将上一个取代 */
        //            if ((__bridge CFUUIDRef)(peri.identifier.UUIDString) == (__bridge CFUUIDRef)(peripheral.identifier.UUIDString))
        //            {
        //                [self.peripherals replaceObjectAtIndex:i withObject:peripheral];
        ////#warning -------- /* 发送外围设备的序号，以及RSSI通知 */
        ////                rssiArray = [NSArray arrayWithObjects:[NSNumber numberWithInteger:i],RSSI, nil];
        ////                if (_isScan)
        ////                {
        ////                    [[NSNotificationCenter defaultCenter] postNotificationName:BLE_DEVICE_RSSI_FOUND object:rssiArray];
        ////                }
        //                return;
        //            }
        //        }
        /* 发现的外围设备，被保存在对象的peripherals缓存中 */
        if ([peripheral.name containsString:@"LMJgA-"]  ) {
            [self.peripherals addObject:peripheral];
            
            //           [[NSNotificationCenter defaultCenter] postNotificationName:@"nameRSSI" object:nil userInfo:@{@"name":peripheral.name?peripheral.name : @"未知的设备",@"RSSI":@([RSSI integerValue])}];
        }
    }
    
    /* 直接发送外围设备的序号，以及RSSI通知 */
    rssiArray = [NSArray arrayWithObjects:[NSNumber numberWithInteger:i],nil];
    if (_isScan) {
        [[NSNotificationCenter defaultCenter] postNotificationName:BLE_DEVICE_RSSI_FOUND object:RSSI];
    }
    
    //    NSDictionary *dic = @{@"name":peripheral.name,@"RSSI":@(i)};
    //    NSArray *dataArray = [NSArray arrayWithObjects:[NSNumber numberWithInteger:i],peripheral.name,nil];
    //    [[NSNotificationCenter defaultCenter] postNotificationName:@"nameRSSI" object:nil userInfo:@{@"name":peripheral.name?peripheral.name : @"未知的设备",@"RSSI":@([RSSI integerValue])}];
    
}
#pragma mark - 中心设备成功连接BLE外围设备
// 中心设备成功连接BLE外围设备
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral{
    DLog(@"Connection to peripheral with UUID : %s successfull\r\n",[self UUIDToString:(__bridge CFUUIDRef)(peripheral.identifier.UUIDString)]);
    self.currentActivePeripheral = peripheral;
    /* 点击某个设备后，将这个设备对象作为参数，通知给属性列表窗体，在那个窗体中进行连接以及服务扫描操作 */
    if (peripheral.name.length == 0) {
        return;
    }
    NSDictionary *dic = @{@"name":peripheral.name ? peripheral.name : @"",@"UUID":peripheral.identifier.UUIDString};
    /* 发出通知设备已经连接成功 */
    [[NSNotificationCenter defaultCenter] postNotificationName:DID_CONNECTED_BLEDEVICE object:dic];
    
}

// 设备连接失败
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:DEVICE_FAILCONNECT object:error];
}

// 设备连接已经断开
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    [[NSNotificationCenter defaultCenter] postNotificationName:DEVICE_ISDISCONNECT object:error];
}


#pragma mark -------------------------------------- BLE 外围设备代理协议方法 -----------------------------------------------

- (void)peripheralDidUpdateRSSI:(CBPeripheral *)peripheral error:(NSError *)error{
    //    DLog(@"_____ RSSI : %d\r\n",[peripheral.RSSI intValue]);
    [[NSNotificationCenter defaultCenter] postNotificationName:RSSI_UPDATE object:nil];
}

//服务发现完成之后的回调方法
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error {
    if (!error) {
        DLog(@"Services of peripheral with UUID : %s found\r\n",[self UUIDToString:(__bridge CFUUIDRef)(peripheral.identifier.UUIDString)]);
        /* 触发获取所有特征值 */
        [self _getAllCharacteristicFromPeripheral:peripheral];
        NSNumber *n =  [NSNumber numberWithFloat:1.0];
        [[NSNotificationCenter defaultCenter] postNotificationName:SERVICE_FOUND_OVER object:n];
    }
    else {
        DLog(@"Service discovery was unsuccessfull !\r\n");
    }
}

//发现服务的特征值之后的回调方法，主要是打印所有服务的特征值。

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error{
    
    static int index = 0 ;
    if (!error) {
        DLog(@"Characteristics of service with UUID : %s found\r\n",[self CBUUIDToString:service.UUID]);
        index ++ ;
        // 开始打印所有服务的UUID的特征值UUID
        for (CBCharacteristic *characteristic in service.characteristics) {
            [self SaveToActiveCharacteristic:characteristic];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:DOWNLOAD_SERVICE_PROCESS_STEP object:nil];
        DLog(@"Discovering characteristics Finished ! \r\n");
    }else{
        DLog(@"Characteristic discorvery unsuccessfull !\r\n");
        index = 0 ;
    }
    
    /*
     180A 为获取设备信息的UUID,
     2A23为系统ID，及模块芯片的物理地址的UUID,
     2A26 模块软件的版本号UUID.
     */
    if ([[service UUID] isEqual:[CBUUID UUIDWithString:@"180A"]])
    {
        NSArray *characteristics = [service characteristics];
        CBCharacteristic *characteristic;
        for (characteristic in characteristics)
        {
            DLog(@"发现特征值UUID: %@", [characteristic UUID]);
            if ([[characteristic UUID] isEqual:[CBUUID UUIDWithString:@"2A23"]])
            {
                DLog(@"发现MacID特征值UUID: %@", [characteristic UUID]);
                [peripheral readValueForCharacteristic:characteristic];
            }
        }
    }
}

/*
 特征值更新后的回调函数，或者收到通知和提示消息后的回调
 这里会根据特征值的UUID来进行区分是哪一个特征值的更新或者改变通知
 如果这些特征值的UUID的值，事先不确定，必须靠连接后的读取来获得，必须在获取之后保存在某一个可变阵列缓冲中
 事后，根据收到的消息中的UUID和缓冲中的特征值UUID逐个比较，最终改变相应特征值的值
 */

//特征值读取，或者得到更改通知后的回调
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    DLog(@"我是传递过来的数据%@",characteristic.value);
    
    if (!error) /* 不存在错误 */
    {
        NSString *strContent = [[NSString alloc] initWithData:characteristic.value encoding:NSUTF8StringEncoding];
         [[NSNotificationCenter defaultCenter] postNotificationName:BLUETOOTH_MACID object:@{@"macId":strContent,@"peripheral":peripheral}];
    }else  /*   存在错误  */
    {   DLog(@"错误---------读取特征值的值之后值----------");
            NSNumber *m = [NSNumber numberWithFloat:0.75];
            [[NSNotificationCenter defaultCenter] postNotificationName:DOWNLOAD_SERVICE_PROCESS_STEP object:m];
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:BLE_WRITE_FINISH object:nil];
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    
    if (!error) {
        DLog(@"Updated notification state for characteristic with UUID %s on service with  UUID %s on peripheral with UUID %s\r\n",[self CBUUIDToString:characteristic.UUID],[self CBUUIDToString:characteristic.service.UUID],[self UUIDToString:(__bridge CFUUIDRef)(peripheral.identifier.UUIDString)]);
    }
    else {
        DLog(@"Error in setting notification state for characteristic with UUID %s on service with  UUID %s on peripheral with UUID %s\r\n",[self CBUUIDToString:characteristic.UUID],[self CBUUIDToString:characteristic.service.UUID],[self UUIDToString:(__bridge CFUUIDRef)(peripheral.identifier.UUIDString)]);
        DLog(@"Error code was %s\r\n",[[error description] cStringUsingEncoding:NSStringEncodingConversionAllowLossy]);
    }
}

/* 每个特征值获取之后的回调,等获取完此服务的所有特征值之后，发出通知分组显示特征值列表 */

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverDescriptorsForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    if (!error)
    {
        [self _logCharacteristicInfoMessage:characteristic];
        NSNumber *m = [NSNumber numberWithFloat:0.75]; // 0.5 跳过第三步，不读取属性值，打开列表后手动读取
        [[NSNotificationCenter defaultCenter] postNotificationName:DOWNLOAD_SERVICE_PROCESS_STEP object:m];
    }
    else
    {
        
    }
}


/* 每个描述之后的回调 */

- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForDescriptor:(CBDescriptor *)descriptor error:(NSError *)error{
    if (!error)
    {
        // 全部转移到  self.currentActiveDescriptors, 里面包含特征值得全部信息
        if ([self.currentMode compare:@"SCANMODE"] == NSOrderedSame) {
            [self SaveToActiveDescriptors:descriptor];
        }
        NSNumber *m = [NSNumber numberWithFloat:1];
        [[NSNotificationCenter defaultCenter] postNotificationName:DOWNLOAD_SERVICE_PROCESS_STEP object:m];
        /* descriptor中包含了服务的所有特征值信息 */
    }else{
        
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForDescriptor:(CBDescriptor *)descriptor error:(NSError *)error{
    
    
    
}
-(NSString *)getUUIDString
{
    NSString  *uuidString = nil;
    NSString *auuid = [[NSString alloc]initWithFormat:@"%@", (__bridge CFUUIDRef)(_currentActivePeripheral.identifier.UUIDString)];
    if (auuid.length >= 36) {
        uuidString = [auuid substringWithRange:NSMakeRange(auuid.length-36, 36)];
        DLog(@"UUIDString:%@",uuidString);
    }
    return uuidString;
}
@end
