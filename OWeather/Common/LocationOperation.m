//
//  LocationOperation.m
//  OWeather
//
//  Created by 袁永国 on 16/3/25.
//  Copyright © 2016年 youxinpai. All rights reserved.
//

#import "LocationOperation.h"

#define  locationOperation_CityName @"currentCityName"
@interface LocationOperation ()<CLLocationManagerDelegate>

@property (strong,nonatomic) CLLocationManager *locationManager;

@end

@implementation LocationOperation

#pragma mark- 属性

-(NSString *)currentCityName {
    NSString *cityName=[[NSUserDefaults standardUserDefaults] valueForKey:locationOperation_CityName];
    return cityName;
}

-(void)setCurrentCityName:(NSString *)currentCityName {
    [[NSUserDefaults standardUserDefaults] setValue:currentCityName forKey:locationOperation_CityName];
}

- (CLLocationManager *)locationManager {
    if(!_locationManager){
        _locationManager= [[CLLocationManager alloc]init];
        _locationManager.delegate=self;
    }
    return _locationManager;
}

#pragma mark- 方法

+ (instancetype) defaultLocationOperation {
    
    static LocationOperation *singleLocationOperation;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleLocationOperation=[[LocationOperation alloc]init];
    });
    return singleLocationOperation;
}

- (void) startRequestLocation {
    if([CLLocationManager locationServicesEnabled]){
        if([UIDevice currentDevice].systemVersion.floatValue>=8.0){
            [self.locationManager requestAlwaysAuthorization];
        }else{
            [self.locationManager startUpdatingLocation];
        }
    }else{
        [self sendNotificationWithCode:@0 tipMsg:@"很抱歉,请确认您的手机开启定位服务！" city:@""];
    }
    
}

#pragma mark-CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    [manager stopUpdatingLocation];
    CLLocation *location=[locations lastObject];
    CLGeocoder *geoCoder=[[CLGeocoder alloc]init];
    [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if(error) {
             [self sendNotificationWithCode:@-3 tipMsg:error.description city:@""];
        }else{
            if(placemarks.count>0){
            
                CLPlacemark *placeMark=[placemarks lastObject];
                NSString *city=placeMark.locality;
                if(!city){
                    //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                    city=placeMark.administrativeArea;
                }
                [self sendNotificationWithCode:@2 tipMsg:@"定位成功" city:city];
                
            }else{
                [self sendNotificationWithCode:@-2 tipMsg:@"解析失败" city:@""];
            }
            
            
        }
        
    }];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    [manager stopUpdatingLocation];
    [self sendNotificationWithCode:@-4 tipMsg:error.description city:@""];

}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    
    if(status==kCLAuthorizationStatusAuthorizedAlways||status==kCLAuthorizationStatusAuthorizedWhenInUse){
        [manager startUpdatingLocation];
    }else if(status==kCLAuthorizationStatusNotDetermined){
        [self sendNotificationWithCode:@1 tipMsg:@"等待授权" city:@""];
    }else{
        [self sendNotificationWithCode:@-1 tipMsg:@"授权失败" city:@""];
    }
    
}


/*
 code相关:
     2、定位成功
     1、等待授权
     0、为开启定位服务
     －1、授权失败
     －2、定位解析失败
     －3、定位解析错误
     －4、错误
msg:成功时存储地址，失败时存储提示信息
 */

- (void) sendNotificationWithCode:(NSNumber *) code  tipMsg:(NSString *) msg city:(NSString *) city {
    NSDictionary *infos=@{@"code":code,@"msg":msg,@"city":city}; 
    [[NSNotificationCenter defaultCenter] postNotificationName:NFLocationUpdateComplte object:self userInfo:infos];
}

@end
