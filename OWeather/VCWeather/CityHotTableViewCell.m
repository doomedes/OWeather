//
//  CityHotTableViewCell.m
//  OWeather
//
//  Created by 袁永国 on 16/3/26.
//  Copyright © 2016年 youxinpai. All rights reserved.
//

#import "CityHotTableViewCell.h"
#import "CityCollectionViewCell.h"

#define cityHotTableViewCell_MinimumitemSpacing 10
#define cityHotTableViewCell_CollectionIdentity @"collectionCell"
#define cityHotTableViewCell_Height 110

@interface CityHotTableViewCell ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property(strong,nonatomic) UICollectionView *collectionView;


@end

@implementation CityHotTableViewCell {
    NSArray * _citysArray; 
}
-(void)setCitysArray:(NSArray *)citysArray {
    _citysArray=citysArray;
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
    layout.itemSize=CGSizeMake((self.currentScreenWidth-cityHotTableViewCell_MinimumitemSpacing*4)/3, 40);
    layout.minimumInteritemSpacing=cityHotTableViewCell_MinimumitemSpacing;
    layout.minimumLineSpacing=cityHotTableViewCell_MinimumitemSpacing;
    layout.sectionInset=UIEdgeInsetsMake(cityHotTableViewCell_MinimumitemSpacing, cityHotTableViewCell_MinimumitemSpacing, cityHotTableViewCell_MinimumitemSpacing, cityHotTableViewCell_MinimumitemSpacing);
    
    self.collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.currentScreenWidth, cityHotTableViewCell_Height) collectionViewLayout:layout];
    [self.collectionView registerNib:[UINib nibWithNibName:@"CityCollectionViewCell"  bundle:nil] forCellWithReuseIdentifier:cityHotTableViewCell_CollectionIdentity];
    self.collectionView.delegate=self;
    self.collectionView.dataSource=self;
    self.collectionView.backgroundColor=[UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
    [self addSubview:self.collectionView];
     
}

 

#pragma mark- UICollectionViewDataSource,UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
        return _citysArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CityCollectionViewCell *cell=(CityCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cityHotTableViewCell_CollectionIdentity forIndexPath:indexPath];
    cell.backgroundColor=[UIColor whiteColor];
    cell.textLable.text=_citysArray[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if(self.selectedhandler){
        self.selectedhandler(indexPath.row);
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
