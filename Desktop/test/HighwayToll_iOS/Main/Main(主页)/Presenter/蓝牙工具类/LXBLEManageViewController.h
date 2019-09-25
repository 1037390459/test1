//
//  LXBLEManageViewController.h
//  HighwayToll_iOS
//
//  Created by wuyaju on 2017/12/23.
//  Copyright © 2017年 zheng. All rights reserved.
//

#import "LXRootViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>
@interface LXBLEManageViewController : LXRootViewController 
@property (nonatomic,strong)CBCharacteristic *characteristic;
@property (nonatomic,strong)CBPeripheral *currPeripheral;
@end
