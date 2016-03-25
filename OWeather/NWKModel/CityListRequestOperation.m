//
//  CityListRequestOperation.m
//  OWeather
//
//  Created by yuanyongguo on 16/3/25.
//  Copyright © 2016年 youxinpai. All rights reserved.
//

#import "CityListRequestOperation.h"

@implementation CityListRequestOperation


-(NSString *)httpMethod {
    return @"GET";
}

-(NSDictionary *) headers {
    return  @{@"apikey":@"8b258b2300b20e9b036cb19fbad530a6"};
}

-(NSDictionary *) parameters {
    return @{@"cityname":self.cityName};
}

@end
