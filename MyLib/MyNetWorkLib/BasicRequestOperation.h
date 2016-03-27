//
//  BasicRequest.h
//  OWeather
//
//  Created by yuanyongguo on 16/3/25.
//  Copyright © 2016年 youxinpai. All rights reserved.
//

#import <Foundation/Foundation.h>

//数据的传输方式：默认，json
typedef NS_OPTIONS(NSUInteger, NSHttpBodyFormate) {
    NSHttpBodyWithDefault = (1UL << 0),
    NSHttpBodyWithJSON = (1UL << 1)
};

typedef void (^CompletionHandler) (NSHTTPURLResponse *response, id data, NSError *error);

@interface BasicRequestOperation : NSObject


//请求完成的block
@property(copy,nonatomic) CompletionHandler completionhander;

-(instancetype)initWithManager:(BasicRequestManagerQueue *) managerQueue;

//请求方式
-(NSString *) httpMethod;

//header信息
-(NSDictionary *) headers;

//参数信息
-(NSDictionary *) parameters;

//请求数据的传输类型（json／默认）
-(NSHttpBodyFormate) httpBodyFormate;

//超时设置
-(NSTimeInterval) timeoutInterval;

//发送请求
-(void) startRequest;


@end
