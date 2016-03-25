//
//  BasicRequest.m
//  OWeather
//
//  Created by yuanyongguo on 16/3/25.
//  Copyright © 2016年 youxinpai. All rights reserved.
//

#import "BasicRequestOperation.h"


@interface BasicRequestOperation ()

@property(strong,nonatomic) BasicRequestManagerQueue * managerQueue;

@end

@implementation BasicRequestOperation

-(instancetype)initWithManager:(BasicRequestManagerQueue *) managerQueue {
   
    self=[super init];
    if(self){
        self.managerQueue=managerQueue;
    }
    return self;
}

-(NSString *)httpMethod {
    return @"GET";
}

-(NSTimeInterval)timeoutInterval {
    
    return 5;
}

-(NSDictionary *) headers {
    return [NSDictionary dictionary];
}

-(NSDictionary *) parameters {
     return [NSDictionary dictionary];
}

//请求数据的传输类型（json／默认）
-(NSHttpBodyFormate) httpBodyFormate {
    return NSHttpBodyWithDefault;
}



//get请求的参数处理
-(NSString *) httpBodyFromGETParameter:(NSDictionary *) parameters withHttpBodyType:(NSHttpBodyFormate) bodyType{
   
    NSString * body=[NSString string];
    //默认的GET请求
    if(bodyType==NSHttpBodyWithDefault) {
        
        NSMutableString *path=[NSMutableString string];
        if(parameters&&parameters.count>0){
            for (int i=0;i<parameters.count;i++) {
                if(i!=0){
                    [path appendString:@"&"];
                }
                NSString *key=parameters.allKeys[i];
                [path appendFormat:@"%@=%@",
                 [key stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]],
                 [parameters[key] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
            }
        }
        body=path;
        
    }else{
       
        /*
          使用JSON传递数据(这种方式传递参数是得指定参数名)此处不能进行json序列化！
         */
        
//        NSError *error;
//        NSData* data=[NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:&error];
//        if(error){
//            NSLog(@"%@",error);
//        }else{
//            body=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//        }
        
    }
    
    return body;
}

//post请求的参数处理
-(NSData *) httpBodyFromPOSTParameter:(NSDictionary *) parameters withHttpBodyType:(NSHttpBodyFormate) bodyType{
    
    NSData *data;
    
    //默认的POST请求
    if(bodyType==NSHttpBodyWithDefault) {
        NSMutableString *path=[NSMutableString string];
        if(parameters&&parameters.count>0){
            for (int i=0;i<parameters.count;i++) {
                if(i!=0){
                    [path appendString:@"&"];
                }
                NSString *key=parameters.allKeys[i];
                [path appendFormat:@"%@=%@",key,parameters[key]];
            }
        }
        data=[path dataUsingEncoding:NSUTF8StringEncoding];
    
    } else {
    //使用JSON传递数据
        NSError *error;
        data=[NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:&error];
        if(error){
            NSLog(@"%@",error);
        }
    }
    
    return data;
}

//请求创建
- (NSMutableURLRequest *) requestFromCurrentProrperty {
    
    NSURL *url ;
    if([self.httpMethod isEqualToString:@"GET"]){
        NSString * httpBody=[self httpBodyFromGETParameter:self.parameters withHttpBodyType:self.httpBodyFormate];
        url=[NSURL URLWithString:[NSString stringWithFormat:@"%@?%@",self.managerQueue.baseUrl,httpBody]];
    }else{
        url=[NSURL URLWithString:self.managerQueue.baseUrl];
    }
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod=self.httpMethod;
    request.timeoutInterval=self.timeoutInterval;
    
    
    if([self.httpMethod isEqualToString:@"POST"]){
        NSData *httpBody=[self httpBodyFromPOSTParameter:self.parameters withHttpBodyType:self.httpBodyFormate];
        request.HTTPBody=httpBody;
    }
    
    //header处理
    if(self.headers&&self.headers.count>0) {
        for (NSString * key in self.headers) {
            [request setValue:self.headers[key] forHTTPHeaderField:key];
        }
    }
    
    return request;
}

//开始请求
-(void) startRequest {
    
//    for (NSURLSessionTask * task in  self.managerQueue.tasks) {
//        [task cancel];
//    }
    
     
    NSMutableURLRequest *request=[self requestFromCurrentProrperty];
    NSURLSessionDataTask *task=[self.managerQueue dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        NSHTTPURLResponse *httpResponse=(NSHTTPURLResponse *)response;
        NSError *currentError;
        NSDictionary *dic=[NSDictionary dictionary];
        if(error){
            currentError=error;
        }else{
            dic= [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&currentError];
        }
        
        //数据处理
        if(self.completionhander) {
            
            self.completionhander(httpResponse,dic,currentError);
        }
        
        
    }];
    [task resume];
}

@end
