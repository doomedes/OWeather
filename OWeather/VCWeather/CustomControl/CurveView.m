//
//  CurveView.m
//  OWeather
//
//  Created by yuanyongguo on 16/3/29.
//  Copyright © 2016年 youxinpai. All rights reserved.
//

#import "CurveView.h"

@interface CurveView ()

@property (strong,nonnull) CAShapeLayer *arcLayer;
@property (strong,nonnull) CAShapeLayer *lineLayer;

@end

@implementation CurveView


-(CGFloat)maxData {
    if(_maxData<=0){
        return 100;
    }
    return _maxData;
}

-(instancetype)initWithFrame:(CGRect)frame {
    self=[super initWithFrame:frame];
    if(self){
        self.arcLayer=[[CAShapeLayer alloc]init];
        self.arcLayer.borderWidth=2;
        [self.layer addSublayer:self.arcLayer];
        self.lineLayer=[[CAShapeLayer alloc]init];
        self.lineLayer.borderWidth=2;
        [self.layer addSublayer:self.lineLayer];
    }
    return self;
}

-(void) drawCure {
    
    NSInteger width=self.bounds.size.width;
    NSInteger height=self.bounds.size.height;
    UIBezierPath *arcPath=[[UIBezierPath alloc]init];

    CGFloat startX=self.padding;
    CGFloat disX=(width-self.padding*2)/self.datas.count;
    NSMutableArray *marray=[NSMutableArray array];
    for (int i=0; i<self.datas.count; i++) {
        NSString *data= self.datas[i];
        CGFloat y= height-self.padding-(height-self.padding*2)*data.floatValue/self.maxData;
        [arcPath moveToPoint:CGPointMake(startX+i*disX, y)];
        [arcPath addArcWithCenter:CGPointMake(startX+i*disX, y) radius:4 startAngle:0 endAngle:2*M_PI clockwise:YES];
        [marray addObject:NSStringFromCGPoint(CGPointMake(startX+i*disX, y))];
    }
    
    self.arcLayer.strokeColor=[UIColor orangeColor].CGColor;
    self.arcLayer.fillColor=[UIColor orangeColor].CGColor;
    self.arcLayer.path=arcPath.CGPath;
    [self.arcLayer setNeedsDisplay];
    
    UIBezierPath *linePath=[[UIBezierPath alloc]init];
    for (int i=0; i<self.datas.count; i++) {
        NSString *strPoint=marray[i];
        if(i==0){
            [linePath moveToPoint:CGPointFromString(strPoint)];
        }else{
             [linePath addLineToPoint:CGPointFromString(strPoint)];
        }
    }
 
    self.lineLayer.strokeColor=[UIColor orangeColor].CGColor;
    self.lineLayer.fillColor=[UIColor clearColor].CGColor;
    self.lineLayer.path=linePath.CGPath;
    [self.lineLayer setNeedsDisplay];

    
    
    
}


@end
