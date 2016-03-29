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

@property (weak, nonatomic) IBOutlet UIView *header;
@property (weak, nonatomic) IBOutlet UIView *footer;

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
 
    TemperatureView *tempView=[[TemperatureView alloc]initWithFrame:CGRectMake(0, 0, 200, 300)];
    tempView.fillBackColor=ColorWithRGB(212,227,235);
    tempView.fillTopColor=ColorWithRGB(238, 114, 41);
    tempView.backRadius=20;
    tempView.currentTemperature=25;
    [tempView drawBackTemperature];
    [tempView drawTopTemperature];
    [self.header addSubview: tempView];
    
    
    TickView *tick=[[TickView alloc]initWithFrame:CGRectMake(200, 22, 50, 200)];
    tick.tickColor=[UIColor blackColor];
    tick.groupTick=5;
    tick.padding=15;
    tick.groupCount=6;
    tick.lowTick=0;
    tick.heightTick=60;
    [tick drawTick];
    [self.header addSubview:tick];
    
    
    CurveView *cure=[[CurveView alloc]initWithFrame:CGRectMake(0, 0, 400, 200)];
    cure.padding=10;
    cure.maxData=100;
    cure.datas=@[@10,@60,@40,@79,@69,@90,@79];
  
    [cure drawCure];
    
    [self.footer addSubview:cure];
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
