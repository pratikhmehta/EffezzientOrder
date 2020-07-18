//
//  ProductDetailSelectableSpecificationListCell.m
//  Meril
//
//  Created by Inspiro Infotech on 31/01/20.
//  Copyright © 2020 Inspiro Infotech. All rights reserved.
//

#import "ProductDetailSelectableSpecificationListCell.h"

#import "ProductDetailSelectableSpecificationItemCell.h"

#import "M_ProductSelectableSpec.h"
#import "M_ProductSpec.h"

@implementation ProductDetailSelectableSpecificationListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setArrSelectableSpecs:(NSMutableArray *)arrSelectableSpecs{
    _arrSelectableSpecs = arrSelectableSpecs;
    [_collectionView reloadData];
}

-(void)setArrPreSelectedSpecs:(NSMutableArray *)arrPreSelectedSpecs{
    _arrPreSelectedSpecs = arrPreSelectedSpecs;
    
    //NSLog(@"Arr Selectable Specs  : %@", _arrSelectableSpecs);
    //NSLog(@"Arr PreSelected Specs : %@", _arrPreSelectedSpecs);
    
    for(M_ProductSpec *preSelectedSpec in _arrPreSelectedSpecs){
        for(M_ProductSelectableSpec *selectableSpec in _arrSelectableSpecs){
            if([preSelectedSpec.specname isEqualToString:selectableSpec.specname]){
                selectableSpec.selectedvalue = preSelectedSpec.specvalue;
            }
        }
    }
    [_collectionView reloadData];
}

#pragma mark - CollectionView

-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ProductDetailSelectableSpecificationItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ProductDetailSelectableSpecificationItemCell class]) forIndexPath:indexPath];
    
    cell.containerView.layer.masksToBounds = YES;
    cell.containerView.layer.cornerRadius = 5;
    cell.containerView.layer.borderColor = [UIColor grayColor].CGColor;
    cell.containerView.layer.borderWidth = 1;
    
    M_ProductSelectableSpec *spec = _arrSelectableSpecs[indexPath.item];
    cell.lblSpecTitle.text = spec.specname;
    cell.lblSpecValue.text = spec.selectedvalue;
    
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _arrSelectableSpecs.count;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    M_ProductSelectableSpec *spec = _arrSelectableSpecs[indexPath.item];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    for(NSString *specValue in spec.specvalues){
        NSString *title = specValue;
        if([specValue isEqualToString:spec.selectedvalue]){
            title = [NSString stringWithFormat:@"✔︎ %@", title];
        }
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            NSInteger index = [alert.actions indexOfObject:action];
            spec.selectedvalue = spec.specvalues[index];
            [collectionView reloadItemsAtIndexPaths:@[indexPath]];
        }];
        [alert addAction:alertAction];
    }
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    
    [[Global topViewController] presentViewController:alert animated:YES completion:nil];
}

#pragma mark -

@end
