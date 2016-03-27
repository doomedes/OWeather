//
//  BasicRequestManager.m
//  OWeather
//
//  Created by yuanyongguo on 16/3/25.
//  Copyright © 2016年 youxinpai. All rights reserved.
//

#import "BasicRequestManagerQueue.h"

@implementation BasicRequestManagerQueue

- (instancetype)initWithUrlString:(NSString *) baseUrl {
    self = [super init];
    if (self) {
        
        self.baseUrl=baseUrl;
        //返回数据序列化方式
        self.responseSerializer=[AFHTTPResponseSerializer serializer];
        
//        self.manager = [AFHTTPSessionManager manager];
//        self.manager.responseSerializer=[AFHTTPResponseSerializer serializer];

    }
    return self;
}

@end
