//
//  CityTableViewCell.m
//  OWeather
//
//  Created by 袁永国 on 16/3/26.
//  Copyright © 2016年 youxinpai. All rights reserved.
//

#import "CityUpdateingTableViewCell.h"
#import "CityCollectionViewCell.h"

#define cityTableViewCell_MinimumitemSpacing 10
#define cityTableViewCell_CollectionIdentity @"collectionCell"
#define cityUpdateIingTableViewCell_Height 60

@interface CityUpdateingTableViewCell ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property(strong,nonatomic) UICollectionView *collectionView;


@end

@implementation CityUpdateingTableViewCell {
   NSString * _cityName;
}

-(void)setCurrentCityName:(NSString *) cityName {
    _cityName=cityName;
    [self.collectionView reloadData];
}



- (void)awakeFromNib {
    // Initialization code
}

 
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self collectionViewLoad];
    }
    return self;
}

- (void) collectionViewLoad {
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    layout.itemSize=CGSizeMake((self.currentScreenWidth-cityTableViewCell_MinimumitemSpacing*4)/3, 40);
    layout.minimumInteritemSpacing=cityTableViewCell_MinimumitemSpacing;
    layout.minimumLineSpacing=cityTableViewCell_MinimumitemSpacing;
    layout.sectionInset=UIEdgeInsetsMake(cityTableViewCell_MinimumitemSpacing, cityTableViewCell_MinimumitemSpacing, cityTableViewCell_MinimumitemSpacing, cityTableViewCell_MinimumitemSpacing);
    
    self.collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.currentScreenWidth, cityUpdateIingTableViewCell_Height) collectionViewLayout:layout];
    [self.collectionView registerNib:[UINib nibWithNibName:@"CityCollectionViewCell"  bundle:nil] forCellWithReuseIdentifier:cityTableViewCell_CollectionIdentity];
    self.collectionView.delegate=self;
    self.collectionView.dataSource=self;
    self.collectionView.backgroundColor=[UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
    [self addSubview:self.collectionView];
    
}



#pragma mark- UICollectionViewDataSource,UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CityCollectionViewCell *cell=(CityCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cityTableViewCell_CollectionIdentity forIndexPath:indexPath];
    cell.backgroundColor=[UIColor whiteColor];
    if(!_cityName||_cityName.length==0){
        cell.textLable.text=@"定位中...";
    }else{
        cell.textLable.text=_cityName;
    }
    return cell;
  
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if(self.selectedHandler&&_cityName&&_cityName.length>0){
        self.selectedHandler();
    }
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
