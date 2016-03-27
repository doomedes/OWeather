//
//  HomeViewController.m
//  OWeather
//
//  Created by 袁永国 on 16/3/25.
//  Copyright © 2016年 youxinpai. All rights reserved.
//

#import "HomeViewController.h"
#import "LocationViewController.h"

@interface HomeViewController ()

@property (strong,nonatomic) CityListRequestOperation * cityListOperation;


@end

@implementation HomeViewController

#pragma  mark- 属性



#pragma  mark- 事件

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.cityListOperation=[[CityListRequestOperation alloc]initWithManager:self.appDelegate.managerQueue];
//    self.cityListOperation.cityName=@"北京";
//    self.cityListOperation.completionhander=^(NSHTTPURLResponse *response, id data, NSError *error) {
//        if(error){
//            NSLog(@"%@",error);
//        }else{
//            NSLog(@"%@",data);
//        }
//    };
    
}

-(void)viewWillAppear:(BOOL)animated {
   
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self.cityListOperation startRequest];
   
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
