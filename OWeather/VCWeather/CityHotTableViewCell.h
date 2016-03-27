//
//  CityHotTableViewCell.h
//  OWeather
//
//  Created by 袁永国 on 16/3/26.
//  Copyright © 2016年 youxinpai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SelectedHotCityHandler) (NSInteger index);

@interface CityHotTableViewCell : UITableViewCell

@property (copy,nonatomic) SelectedHotCityHandler selectedhandler;

-(void)setCitysArray:(NSArray *)citysArray ;

@end
