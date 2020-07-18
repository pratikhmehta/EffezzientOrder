//
//  ProductDetailSpecificationListCell.m
//  Meril
//
//  Created by Inspiro Infotech on 24/01/20.
//  Copyright © 2020 Inspiro Infotech. All rights reserved.
//

#import "ProductDetailSpecificationListCell.h"

#import "ProductDetailSpecificationItemCell.h"

#import "M_ProductSpec.h"

@implementation ProductDetailSpecificationListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setArrSpecs:(NSMutableArray *)arrSpecs{
    _arrSpecs = arrSpecs;
    [_collectionView reloadData];
}

#pragma mark - CollectionView

-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ProductDetailSpecificationItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ProductDetailSpecificationItemCell class]) forIndexPath:indexPath];
    
    M_ProductSpec *spec = _arrSpecs[indexPath.item];
    cell.lblSpecTitle.text = spec.specname;
    cell.lblSpecValue.text = spec.specvalue;
        
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _arrSpecs.count;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    M_ProductSpec *spec = _arrSpecs[indexPath.item];
    [Global displayToastAlertAtBottom:[NSString stringWithFormat:@"%@: %@", spec.specname, spec.specvalue]];
}

#pragma mark -

@end
