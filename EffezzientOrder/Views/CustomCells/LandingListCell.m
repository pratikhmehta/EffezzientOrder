//
//  HorizontalListCell.m
//  Meril
//
//  Created by Inspiro Infotech on 10/01/20.
//  Copyright © 2020 Inspiro Infotech. All rights reserved.
//

#import "LandingListCell.h"

#import "LandingListItem.h"

#import "UIImageView+WebCache.h"

#define kHorizontalList @"HorizontalList"
#define kGridView       @"GridView"
#define kSwipeView      @"SwipeView"
#define kVerticalList   @"VerticalList"

@implementation LandingListCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)setLandingSection:(M_LandingSection *)landingSection{
    
    _landingSection = landingSection;
    
    _collectionView.scrollEnabled = YES;
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)_collectionView.collectionViewLayout;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    [layout setSectionInset:UIEdgeInsetsMake(0, _landingSection.sectionMarginLeft, 0, _landingSection.sectionMarginRight)];
    
    NSString *viewType = _landingSection.type;
    
    if([viewType isEqualToString:kGridView] || [viewType isEqualToString:kVerticalList]){
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView.scrollEnabled = NO;
    }
    else if([viewType isEqualToString:kSwipeView]){
        _collectionView.pagingEnabled = YES;
    }
    
    [_collectionView reloadData];
}

#pragma mark - CollectionView

-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    M_LandingItem *landingItem = _landingSection.items[indexPath.item];
    LandingListItem *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([LandingListItem class]) forIndexPath:indexPath];
    NSURL *url = [NSURL URLWithString:landingItem.imageURL];
    [cell.imageView sd_setImageWithURL:url placeholderImage:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
    
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _landingSection.items.count;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    M_LandingItem *landingItem = _landingSection.items[indexPath.item];
    CGSize size = CGSizeMake(landingItem.itemWidth, landingItem.itemHeight);
    return size;
}

#pragma mark -

@end
