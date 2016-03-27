//
//  LocationOperation.h
//  OWeather
//
//  Created by 袁永国 on 16/3/25.
//  Copyright © 2016年 youxinpai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocationOperation : NSObject

@property (strong,nonatomic) CLLocation *currentLocation;

@property (copy,nonatomic) NSString *currentCityName;


+(instancetype) defaultLocationOperation;

-(void) startRequestLocation;



@end
