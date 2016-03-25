//
//  ViewController.m
//  OWeather
//
//  Created by yuanyongguo on 16/3/25.
//  Copyright © 2016年 youxinpai. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@property (strong,nonatomic) CityListRequestOperation * cityListOperation;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.cityListOperation=[[CityListRequestOperation alloc]initWithManager:self.appDelegate.managerQueue];
    self.cityListOperation.cityName=@"北京";
    self.cityListOperation.completionhander=^(NSHTTPURLResponse *response, id data, NSError *error) {
        if(error){
            NSLog(@"%@",error);
        }else{
            NSLog(@"%@",data);
        }
    };
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.cityListOperation startRequest];
   
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
