//
//  ProductDetailDescriptionCell.m
//  Meril
//
//  Created by Inspiro Infotech on 24/01/20.
//  Copyright © 2020 Inspiro Infotech. All rights reserved.
//

#import "ProductDetailDescriptionCell.h"

@implementation ProductDetailDescriptionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setSelectedProduct:(M_ProductList *)selectedProduct{
    _lblDescription.text = [NSString stringWithFormat:@"%@\n\n%@", selectedProduct.shortdescription, selectedProduct.longdescription];
}

@end
