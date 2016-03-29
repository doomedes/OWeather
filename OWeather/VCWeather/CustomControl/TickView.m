//
//  TickView.m
//  OWeather
//
//  Created by yuanyongguo on 16/3/29.
//  Copyright © 2016年 youxinpai. All rights reserved.
//

#import "TickView.h"

@interface TickView ()

@property (strong,nonnull) CAShapeLayer *tickLayer;

@end

@implementation TickView

#pragma mark-属性

-(void)setTickColor:(UIColor *)tickColor {
    self.tickLayer.strokeColor=tickColor.CGColor;
    _tickColor=tickColor;
}

-(void)setGroupTick:(NSInteger)groupTick {
    if(groupTick<=0){
        return;
    }
    _groupTick=groupTick;
}

-(NSInteger)groupTick {
    if(_groupTick==0){
        return 10;
    }
    return _groupTick;
}

-(CGFloat)padding {
    if(_padding<=0){
        return 10;
    }
    return _padding;
}

#pragma  mark-事件

-(instancetype)initWithFrame:(CGRect)frame {
    self=[super initWithFrame:frame];
    if(self){
        self.tickLayer=[[CAShapeLayer alloc]init];
        self.tickLayer.lineWidth=1;
        [self.layer addSublayer:self.tickLayer];
        self.backgroundColor=[UIColor whiteColor];
    }
    return self;
}

-(void) drawTick {
    
    NSInteger width=self.bounds.size.width;
    NSInteger height=self.bounds.size.height;
    UIBezierPath *path=[[UIBezierPath alloc]init];
    
    CGFloat tickY=(height-2*self.padding)/(self.groupTick*self.groupCount);
    CGFloat startX=self.padding;
    CGFloat endX=width;
    CGFloat startY=self.padding;

    CGFloat startX1=1.5*self.padding;
    CGFloat endX1=width-0.5*self.padding;
    for (int i=0; i<=self.groupTick*self.groupCount; i++) {
        if(i%self.groupTick==0){
            [path moveToPoint:CGPointMake(startX, startY+tickY*i)];
            [path addLineToPoint:CGPointMake(endX, startY+tickY*i)];
        }else{
            [path moveToPoint:CGPointMake(startX1, startY+tickY*i)];
            [path addLineToPoint:CGPointMake(endX1, startY+tickY*i)];
        }
    }
    self.tickLayer.path=path.CGPath;
    [self.tickLayer setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect {
    NSInteger height=self.bounds.size.height;
    CGFloat disTick=(self.heightTick-self.lowTick)/self.groupCount;
    CGFloat tickY=(height-2*self.padding)/self.groupCount;
    CGFloat startX=0;
    CGFloat startY=self.padding;
    for (int i=0; i<=self.groupCount; i++) {
        NSString *currentTick=[NSString stringWithFormat:@"%ld",(NSInteger)(self.heightTick-disTick*i)];
       NSDictionary *dic=@{NSFontAttributeName:[UIFont boldSystemFontOfSize:9]};
       CGRect rect= [currentTick boundingRectWithSize:CGSizeMake(100, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
        [currentTick drawInRect:CGRectMake(startX, startY+tickY*i-self.padding/2, rect.size.width, rect.size.height) withAttributes:dic];
    }
}

@end
