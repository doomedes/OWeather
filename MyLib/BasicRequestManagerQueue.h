//
//  BasicRequestManager.h
//  OWeather
//
//  Created by yuanyongguo on 16/3/25.
//  Copyright © 2016年 youxinpai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BasicRequestManagerQueue : AFHTTPSessionManager


//请求基地址
@property (copy,nonatomic) NSString * baseUrl;

//当前状态
@property (assign,nonatomic) int status;

//@property (strong,nonatomic) AFHTTPSessionManager *manager;


- (instancetype)initWithUrlString:(NSString *) baseUrl ;

@end
