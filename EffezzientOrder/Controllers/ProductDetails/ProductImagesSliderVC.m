    //
//  ProductImagesSliderVC.m
//  Meril
//
//  Created by Inspiro Infotech on 30/01/20.
//  Copyright © 2020 Inspiro Infotech. All rights reserved.
//

#import "ProductImagesSliderVC.h"

#import "ProductDetailImageItemCell.h"

#import "UIImageView+WebCache.h"
#import "UIView+Category.h"

@interface ProductImagesSliderVC ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@end

@implementation ProductImagesSliderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupLayout];
    
    self.title = _selectedProduct.itemname;
    _pageControl.numberOfPages = _arrImageURLs.count;
}

-(void)setupLayout{
    _btnNextContainer.layer.masksToBounds = YES;
    _btnNextContainer.layer.cornerRadius = _btnNextContainer.frame.size.width/2;
    
    _btnPreviousContainer.layer.masksToBounds = YES;
    _btnPreviousContainer.layer.cornerRadius = _btnPreviousContainer.frame.size.width/2;
}

- (IBAction)btnPreviousClicked:(id)sender {
    if(_currentIndex > 0){
        [self scrollToIndex:_currentIndex-1 animated:YES];
    }
}

- (IBAction)btnNextClicked:(id)sender {
    if(_currentIndex < _arrImageURLs.count-1){
        [self scrollToIndex:_currentIndex+1 animated:YES];
    }
}

-(void)scrollToIndex:(NSInteger)index animated:(BOOL)animated{
    _currentIndex = index;
    _pageControl.currentPage = index;
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:animated];
}

#pragma mark - CollectionView

-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ProductDetailImageItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ProductDetailImageItemCell class]) forIndexPath:indexPath];
    
    [cell setup];
    
    [cell.itemImage sd_setImageWithURL:_arrImageURLs[indexPath.item] placeholderImage:[UIImage imageNamed:@"img_effezient_banner"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if(error){
            [cell.itemImage setImage:[UIImage imageNamed:@"img_effezient_banner"]];
        }
    }];
    
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _arrImageURLs.count;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return collectionView.size;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat pageWidth = self.collectionView.frame.size.width;
    _currentIndex = self.collectionView.contentOffset.x / pageWidth;
    self.pageControl.currentPage = _currentIndex;
}

#pragma mark -

@end
