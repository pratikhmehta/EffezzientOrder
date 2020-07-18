//
//  ProductDetailCatalogueDetailListCell.m
//  Meril
//
//  Created by Inspiro Infotech on 28/01/20.
//  Copyright © 2020 Inspiro Infotech. All rights reserved.
//

#import "ProductDetailCatalogueDetailListCell.h"

#import "ProductListCell.h"

#import "ProductDetailsVC.h"

#import "MainViewController.h"
#import "NavigationController.h"

@implementation ProductDetailCatalogueDetailListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setArrCatalogueItemsProducts:(NSMutableArray *)arrCatalogueItemsProducts{
    _arrCatalogueItemsProducts = arrCatalogueItemsProducts;
    [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ProductListCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([ProductListCell class])];
    [_collectionView reloadData];
}

#pragma mark - CollectionView

-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ProductListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ProductListCell class]) forIndexPath:indexPath];
    
    [cell setSelectedProduct:_arrCatalogueItemsProducts[indexPath.item]];
    cell.widthOfBtnWishlist.constant = 0;
    
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _arrCatalogueItemsProducts.count;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(collectionView.frame.size.width/2, 252);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    M_ProductList *selectedProduct = _arrCatalogueItemsProducts[indexPath.item];
    if(selectedProduct.canaddtocart){
        ProductDetailsVC *vc = loadViewController(SB_Order, VC_ProductDetails);
        vc.selectedProduct = selectedProduct;
        [kNavigationController pushViewController:vc animated:YES];
    }else{
        [Global displayToastAlertAtBottom:@"Single Unavailable"];
    }
}

#pragma mark -

@end
