//
//  ProductDetailImagesListCell.m
//  Meril
//
//  Created by Inspiro Infotech on 24/01/20.
//  Copyright © 2020 Inspiro Infotech. All rights reserved.
//

#import "ProductDetailImagesListCell.h"

#import "ProductDetailImageItemCell.h"

#import "UIImageView+WebCache.h"

@implementation ProductDetailImagesListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setArrImages:(NSMutableArray *)arrImages{
    _arrImages = arrImages;
    _pageControl.numberOfPages = _arrImages.count;
    [_collectionView reloadData];
}

#pragma mark - CollectionView

-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ProductDetailImageItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ProductDetailImageItemCell class]) forIndexPath:indexPath];
    
    [cell.itemImage sd_setImageWithURL:_arrImages[indexPath.item] placeholderImage:[UIImage imageNamed:@"img_effezient_banner"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if(error){
            [cell.itemImage setImage:[UIImage imageNamed:@"img_effezient_banner"]];
        }
    }];
    
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _arrImages.count;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(collectionView.frame.size.width, 300);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"IMAGE : %@", _arrImages[indexPath.item]);
    [_selectorObject performSelectorOnMainThread:_onPressImage withObject:@(indexPath.item) waitUntilDone:NO];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat pageWidth = self.collectionView.frame.size.width;
    self.pageControl.currentPage = self.collectionView.contentOffset.x / pageWidth;
}

#pragma mark -

@end
