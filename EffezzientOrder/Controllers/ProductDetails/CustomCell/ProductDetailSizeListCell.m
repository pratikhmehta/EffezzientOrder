//
//  ProductDetailSizeListCell.m
//  Meril
//
//  Created by Inspiro Infotech on 24/01/20.
//  Copyright © 2020 Inspiro Infotech. All rights reserved.
//

#import "ProductDetailSizeListCell.h"

#import "ProductDetailSizeItemCell.h"

#import "M_ProductSize.h"

@implementation ProductDetailSizeListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setArrSize:(NSMutableArray *)arrSize{
    _arrSize = arrSize;
    [_collectionView reloadData];
}

#pragma mark - CollectionView

-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ProductDetailSizeItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ProductDetailSizeItemCell class]) forIndexPath:indexPath];
    
    cell.vwSizeLabelContainer.layer.masksToBounds = YES;
    cell.vwSizeLabelContainer.layer.cornerRadius = cell.vwSizeLabelContainer.frame.size.width/2;
    cell.vwSizeLabelContainer.layer.borderColor = [UIColor blackColor].CGColor;
    cell.vwSizeLabelContainer.layer.borderWidth = 1;
    
    M_ProductSize *model = _arrSize[indexPath.item];
    cell.lblSizeName.text = model.sizename;
    [cell.vwLimitedContainer setHidden:!model.islimitedstock];
    
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _arrSize.count;
}

#pragma mark -


@end
