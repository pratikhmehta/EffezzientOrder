//
//  ProductDetailNameAndPrice_m
//  Meril
//
//  Created by Inspiro Infotech on 24/01/20.
//  Copyright © 2020 Inspiro Infotech. All rights reserved.
//

#import "ProductDetailNameAndPriceCell.h"

@implementation ProductDetailNameAndPriceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setSelectedProduct:(M_ProductList *)selectedProduct{
    _lblBrandProductCategory.text = [NSString stringWithFormat:@"%@  %@  %@", selectedProduct.brandname, selectedProduct.itemname, selectedProduct.categoryname];
    
    NSDictionary *mrpAttributes = @{
                                    NSFontAttributeName : [UIFont systemFontOfSize:13 weight:UIFontWeightMedium],
                                    NSStrikethroughStyleAttributeName : @(NSUnderlineStyleSingle),
                                    NSForegroundColorAttributeName : [UIColor lightGrayColor]
                                    };
    NSAttributedString *attributedMRP = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%.2f", selectedProduct.mrp] attributes:mrpAttributes];
    _lblMRP.attributedText = attributedMRP;
    
    _lblFullPrice.text = [NSString stringWithFormat:@"%.2f/-", selectedProduct.offerprice];
    _lblFullDiscount.text = @"";
//    if(selectedProduct.discount > 0){
        _lblFullDiscount.text = [NSString stringWithFormat:@"%.f%% OFF", selectedProduct.discount];
//    }
    _lblSinglePrice.text = @"";
    _lblSingleDiscount.text = @"";
    
    _heightOfSinglePriceDetailsContainer.constant = 0;
    
    if(selectedProduct.iscatalogue){
        Cataloguedetail *catalogueDetails = selectedProduct.cataloguedetail;
        if(catalogueDetails.singlepcsavailable){
            _lblSinglePrice.text = [NSString stringWithFormat:@"Single : %@", catalogueDetails.singlepcsprice];
            _heightOfSinglePriceDetailsContainer.constant = 16;
            if(catalogueDetails.singlepcsdiscount > 0){
                _lblSingleDiscount.text = [NSString stringWithFormat:@"%.f%% OFF", catalogueDetails.singlepcsdiscount];
            }
        }
    }
}

@end
