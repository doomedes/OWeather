//
//  BasicRequestManager.h
//  OWeather
//
//  Created by yuanyongguo on 16/3/25.
//  Copyright © 2016年 youxinpai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BasicRequestManagerQueue : AFHTTPSessionManager


//请求基地址(AFHTTPSessionManager.baseURL)
//@property (copy,nonatomic) NSString * baseUrl;

//当前状态
@property (assign,nonatomic) int status;

//@property (strong,nonatomic) AFHTTPSessionManager *manager;


//不使用自定义的初始化方法
//- (instancetype)initWithUrlString:(NSString *) baseUrl ;

@end
