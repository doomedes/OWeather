//
//  LocationViewController.m
//  OWeather
//
//  Created by 袁永国 on 16/3/26.
//  Copyright © 2016年 youxinpai. All rights reserved.
//

#import "LocationViewController.h"
#import "CityHotTableViewCell.h"
#import "CityUpdateingTableViewCell.h"

#define locationVC_TableViewIdentity_current @"tableViewCell_Current"
#define locationVC_TableViewIdentity_hot @"tableViewCell_hot"
#define locationVC_TableViewIdentity @"tableViewCell"

@interface LocationViewController ()<UITableViewDataSource,UITableViewDelegate>


@property(copy,nonatomic) NSArray * hotCitysArray;
@property(copy,nonatomic) NSString * currentCityName;
@property (strong,nonatomic) NSMutableArray *allCitysArrary;

@end

@implementation LocationViewController
{
    UITableView *tableview;
    
}

#pragma mark-属性


#pragma  mark-事件

- (void)viewDidLoad {
    [super viewDidLoad];
    self.allCitysArrary=[NSMutableArray array];
    
    if(![LocationOperation defaultLocationOperation].currentCityName||[LocationOperation defaultLocationOperation].currentCityName.length==0){
        self.currentCityName=@"";
    }else{
        self.currentCityName=[LocationOperation defaultLocationOperation].currentCityName;
    }
    self.hotCitysArray=@[@"北京",@"上海",@"广州",@"重庆"];
    
    [self tableViewLoad];
    
}

-(void) tableViewLoad {
    tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 66, self.Screen_Width, self.Screen_Height-66) style:UITableViewStyleGrouped];
    [tableview registerClass:[CityHotTableViewCell class] forCellReuseIdentifier:locationVC_TableViewIdentity_hot];
    [tableview registerClass:[CityUpdateingTableViewCell class] forCellReuseIdentifier:locationVC_TableViewIdentity_current];
    [tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:locationVC_TableViewIdentity];
    tableview.delegate=self;
    tableview.dataSource=self;
    [self.view addSubview:tableview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    [self reqeustUpdateLocation];
}

-(void)viewWillDisappear:(BOOL)animated {
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma  mark - 获取地址相关

-(void) reqeustUpdateLocation {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(locationUpdateComplete:) name:NFLocationUpdateComplte object:nil];
    [[LocationOperation defaultLocationOperation] startRequestLocation];

}

//地址更新通知
- (void) locationUpdateComplete:(NSNotification *) notification {
   NSString *code=[notification.userInfo valueForKey:@"code"];
    if(code.intValue==2){
        self.currentCityName=[notification.userInfo valueForKey:@"city"];
        [tableview reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
    }else{
        NSLog(@"%@",notification.userInfo);
    }
}

#pragma  mark- UITableViewDataSource,UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section>=2){
        return self.allCitysArrary.count;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
    __weak typeof (self) weakSelf=self;
    if(indexPath.section==0){
        
        CityUpdateingTableViewCell *cell=[tableview dequeueReusableCellWithIdentifier:locationVC_TableViewIdentity_current];
        [cell setCurrentCityName:self.currentCityName];
        cell.selectedHandler=^(){
            [LocationOperation defaultLocationOperation].currentCityName=weakSelf.currentCityName;
            [weakSelf cityChangeHandler];
       };
       return cell;

    }else if(indexPath.section==1){
        
        CityHotTableViewCell *cell=[tableview dequeueReusableCellWithIdentifier:locationVC_TableViewIdentity_hot];
        [cell setCitysArray:self.hotCitysArray];
        cell.selectedhandler=^(NSInteger index){
            [LocationOperation defaultLocationOperation].currentCityName=weakSelf.hotCitysArray[index];
            [weakSelf cityChangeHandler];
        };
        return cell;
        
    } else{
       
        UITableViewCell *cell=[tableview dequeueReusableCellWithIdentifier:locationVC_TableViewIdentity];
        cell.textLabel.text=self.allCitysArrary[indexPath.row];
        return cell;
    }
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section==0){
        return 60;
    }else if(indexPath.section==1){
        return 110;
    }else{
        return 30;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if(section==0){
        return @"定位城市";
    }else if(section==1){
        return @"热门城市";
    }else{
        return @"城市列表";
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [LocationOperation defaultLocationOperation].currentCityName=self.allCitysArrary[indexPath.row];
    [self cityChangeHandler];

}

- (void)cityChangeHandler {
    [self.appDelegate showHomeWeather];
}

@end
