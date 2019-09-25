//
//  LXLocationManager.m
//  LX
//
//  Created by Lone on 2017/10/17.
//  Copyright © 2017年 CarWins Inc. All rights reserved.
//

#import "LXLocationManager.h"
#import <CoreLocation/CoreLocation.h>

@interface LXLocationManager ()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager* locationManager;

@end

@implementation LXLocationManager

+ (instancetype)shareInstance
{
    static LXLocationManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[LXLocationManager alloc] init];
    });
    return manager;
}

- (instancetype)init
{
    if (self = [super init]) {
        _locationManager = [[CLLocationManager alloc] init];
        //设置代理
        _locationManager.delegate = self;
        //设置定位精度
        _locationManager.distanceFilter = 1000.0f;;
        
        //设置默认值
        _city = @"";
        
    }
    return self;
}

#pragma mark - 定位服务操作（开启 暂停 更新）
// 开启定位
- (void)startLocation
{
    /** 由于IOS8中定位的授权机制改变 需要进行手动授权
     * 获取授权认证，两个方法：
     * [self.locationManager requestWhenInUseAuthorization];
     * [self.locationManager requestAlwaysAuthorization];
     */
    if ([CLLocationManager locationServicesEnabled])    //确定用户的位置服务启用
    {
        if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            NSLog(@"requestAlwaysAuthorization");
            [self.locationManager requestWhenInUseAuthorization];
        }
        
        //开始定位，不断调用其代理方法
        [self.locationManager startUpdatingLocation];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"定位服务不可用" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }
}

//停止定位
- (void)stopLocation
{
    [self.locationManager stopUpdatingLocation];
}

#pragma mark - 定位代理回调
//位置更新回调
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations
{
    // 1.停止定位
    [self stopLocation];
    
    // 2.获取用户位置的对象
    CLLocation *location = [locations lastObject];
    CLLocationCoordinate2D coordinate = location.coordinate;
    NSLog(@"纬度:%f 经度:%f", coordinate.latitude, coordinate.longitude);
    self.longitude = coordinate.longitude;
    self.latitude = coordinate.latitude;
    
    // 3.获取地址信息
    [self getLocationCityMessageWithLocation:location];
}

//定位失败
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"定位失败");
    [self stopLocation];
}

#pragma mark - 坐标地理转化
//获取定位城市
- (void)getLocationCityMessageWithLocation:(CLLocation *)location
{
    CLGeocoder *geocoder=[[CLGeocoder alloc]init];
    __weak typeof(self)weakSelf = self;
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks,NSError *error)
     {
         if (error) {
             NSLog(@"failed with error:%@",error);
             return ;
         }
         __strong typeof(weakSelf) strongSelf = weakSelf;
         for(CLPlacemark *placemark in placemarks)
         {
             strongSelf.city = placemark.locality;
             strongSelf.province = placemark.administrativeArea;
             strongSelf.locationDetail = placemark.name;
//             administrativeArea     省
//             locality               市
//             subLocality            区
//             thoroughfare           街道
//             subThoroughfare        子街道
             if (!strongSelf.city || strongSelf.city.length == 0) {
                 strongSelf.city = strongSelf.province;     //四大直辖市
             }
         }
     }];
}

@end
