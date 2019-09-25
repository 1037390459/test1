
//
//  LXBlueToothManager.h
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/12/12.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXObject.h"
#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "Tools.h"
#import "LXMBlueTooth.h"

#define LXBLEMANAGER [LXBlueToothManager manager]
#define KBluetoothUUID @"bluetoothUUID"
typedef enum MODEl_STATE
{
    MODEL_NORMAL = 0,
    MODEL_SCAN = 1,
    MODEL_CONECTED = 2,
    MODEL_DISCONECTED = 3
} StartModel;

@protocol BlueToothManagerDelegate <NSObject>

@optional

/**
 已经扫描到设备
 
 @param Peripherals 设备的集合
 */

- (void)didDiscoverPeripheral:(NSSet *)Peripherals canConnect:(BOOL)canConnect;


/**
 已经连接到指定的外设
 
 @param peripheral 指定的外设（默认扫描到的外设）
 */
- (void)didConnectPeripheral:(CBPeripheral *)peripheral;


/**
 数据响应(老版本响应Value更新和接收数据通道)
 
 @param data 数据是分包接收的，需要做特别的处理
 */
- (void)receiveData:(NSString *)data;


/**
 数据响应(新版本响应Value更新，数据查看deviceCallBack属性)
 */
- (void)getValueForPeripheral;


/**
 停止扫描蓝牙外设
 
 */
- (void)stopScanBLEThenUpdateDevices;


/**
 已经断开蓝牙设备连接
 
 @param error 断开连接的错误信息
 */
- (void)didDisconnectPeripheral:(NSError *)error;

@end
@interface LXBlueToothManager : LXObject

@property (nonatomic, weak) id<BlueToothManagerDelegate>delegate;

@property (nonatomic, strong,readonly) CBPeripheral *currentPeripheral;

@property (nonatomic, assign ,readonly) StartModel startModel;    // 连接的状态

@property (nonatomic, strong) LXMBlueTooth *bleManager; // 蓝牙管理类

@property (nonatomic, assign ,readonly) BOOL  isBandingDevice;  // 是否已经绑定设备

/**
 新版本数据
 */
@property (nonatomic, strong) NSMutableArray *deviceCallBack;

+ (instancetype)manager;
/**
 只需要在 AppDelegate.m 启动方法中被调用一次即可
 */
- (void)initializerBLEManager;


/**
 开始扫描设备
 */
- (void) startScanDevice;


/**
 停止扫描
 */
- (void) stopScan;


/**
 注册广播频道，准备开始接受数据
 */
- (void)startReceiveData;


/**
 注销广播频道，结束接受数据
 */
- (void)stopReceiveData;


/**
 连接指定的设备
 
 @param peripheral 指定的设备 peripheral
 */
- (void)connectPeripheralDevice:(CBPeripheral *)peripheral;

/**
 取消连接
 */
- (void)cancelConnect;


/**
 老版本发送数据
 
 @param data 发送的数据流（data）
 */
- (void)sendDataToDevice:(NSString *)data;


/**
 新版本发送数据
 
 @param data 发送的数据流 (data)
 */
- (void)writeValueForPeripheral:(NSData *)data;

/**
 是否已经绑定设备
 
 @param isBandingDevice 是否已经绑定设备
 */
- (void)setIsBandingDevice:(BOOL)isBandingDevice;
@end
