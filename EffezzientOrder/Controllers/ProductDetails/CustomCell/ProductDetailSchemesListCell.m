//
//  ProductDetailSchemesListCell.m
//  Meril
//
//  Created by Inspiro Infotech on 30/01/20.
//  Copyright © 2020 Inspiro Infotech. All rights reserved.
//

#import "ProductDetailSchemesListCell.h"

@implementation ProductDetailSchemesListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setScheme:(M_ProductScheme *)scheme{
    _lblScheme.text = [NSString stringWithFormat:@"%@ : %@", scheme.scheme, scheme.productSchemeDescription];
}

@end
