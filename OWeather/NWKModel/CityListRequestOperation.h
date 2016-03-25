//
//  CityListRequestOperation.h
//  OWeather
//
//  Created by yuanyongguo on 16/3/25.
//  Copyright © 2016年 youxinpai. All rights reserved.
//

#import "BasicRequestOperation.h"

//城市列表
@interface CityListRequestOperation : BasicRequestOperation

@property (copy,nonatomic) NSString * cityName;

@end
