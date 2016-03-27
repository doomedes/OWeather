//
//  CityTableViewCell.h
//  OWeather
//
//  Created by 袁永国 on 16/3/26.
//  Copyright © 2016年 youxinpai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectedCurrentCityHandler)( );

@interface CityUpdateingTableViewCell : UITableViewCell

@property (copy,nonatomic) SelectedCurrentCityHandler selectedHandler;

-(void)setCurrentCityName:(NSString *) cityName ;

@end
