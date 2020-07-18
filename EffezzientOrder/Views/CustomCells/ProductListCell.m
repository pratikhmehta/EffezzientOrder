//
//  ProductList_m
//  Meril
//
//  Created by Inspiro Infotech on 21/01/20.
//  Copyright © 2020 Inspiro Infotech. All rights reserved.
//

#import "ProductListCell.h"

@implementation ProductListCell

-(void)setSelectedProduct:(M_ProductList *)selectedProduct{
    [_btnWishlist setSelected:selectedProduct.iswishlisetd];
    
    [_btnWishlist animateSelected];
    
    _lblBrandName.text = selectedProduct.brandname;
    _lblCategoryName.text = selectedProduct.categoryname;
    _lblProductName.text = selectedProduct.itemname;
    
    _heightOfLblCategoryName.constant = 15;
    _heightOfLblBrand.constant = 15;
    _heightOfLblProductName.constant = 15;
    
    if(selectedProduct.brandname.length == 0){
        _heightOfLblBrand.constant = 0;
    }
    if(selectedProduct.categoryname.length == 0){
        _heightOfLblCategoryName.constant = 0;
    }
    if(selectedProduct.itemname.length == 0){
        _heightOfLblProductName.constant = 0;
    }
    
    NSDictionary *mrpAttributes = @{
                                    NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle),
                                    NSForegroundColorAttributeName:[UIColor colorFromHexString:@"FF4C4C"]
                                    };
    NSAttributedString *attributedMRP = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%.2f", selectedProduct.mrp] attributes:mrpAttributes];
    _lblMRP.attributedText = attributedMRP;
    
    NSString *strUrl = [NSString stringWithFormat:@"%@/%@", MM_ProductsImagePath, [selectedProduct.coverimage stringByReplacingOccurrencesOfString:@" " withString:@"%20"]];
    NSURL *imgUrl = [NSURL URLWithString:strUrl];
    [_imgProduct sd_setImageWithURL:imgUrl placeholderImage:[UIImage imageNamed:@"img_effezient_banner"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if(error){
            [self.imgProduct setImage:[UIImage imageNamed:@"img_effezient_banner"]];
        }
    }];
    
    _widthOfLblFullDiscount.constant = 0;
    _lblFullPrice.text = [NSString stringWithFormat:@"Full : %.2f", selectedProduct.offerprice];
    _lblFullDiscount.text = @"";
    if(selectedProduct.discount > 0){
        _lblFullDiscount.text = [NSString stringWithFormat:@"%.f%% off", selectedProduct.discount];
        _widthOfLblFullDiscount.constant = 49;
    }
    
    [_vwSinglePieceAvailability setHidden:YES];
    _lblSinglePrice.text = @"";
    _lblSingleDiscount.text = @"";
    
    _widthOfLblSingleDiscount.constant = 0;
    
    if(selectedProduct.iscatalogue){
        [_vwSinglePieceAvailability setHidden:NO];
        Cataloguedetail *catalogueDetails = selectedProduct.cataloguedetail;
        if(catalogueDetails.singlepcsavailable){
            _lblSinglePrice.text = [NSString stringWithFormat:@"Single : %@", catalogueDetails.singlepcsprice];
            if(catalogueDetails.singlepcsdiscount > 0){
                _lblSingleDiscount.text = [NSString stringWithFormat:@"%.f%% off", catalogueDetails.singlepcsdiscount];
                _widthOfLblSingleDiscount.constant = 49;
            }
        }
    }
    
    NSAttributedString *attrBlankSpace = [[NSAttributedString alloc] initWithString:@" " attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]}];
    
    NSMutableAttributedString *attrPriceDiscount = [[NSMutableAttributedString alloc] init];
    
    UIFont *fontOfferPrice = [UIFont boldSystemFontOfSize:13];
    NSAttributedString *attrOfferPrice = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%.2f/-", selectedProduct.offerprice] attributes:@{ NSFontAttributeName : fontOfferPrice }];
    [attrPriceDiscount appendAttributedString:attrOfferPrice];
    
    [attrPriceDiscount appendAttributedString:attrBlankSpace];
    
    UIFont *fontMRP = [UIFont systemFontOfSize:11.5];
    NSAttributedString *attrMRP = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%.2f", selectedProduct.mrp] attributes:@{NSStrikethroughStyleAttributeName : @(NSUnderlineStyleSingle),NSForegroundColorAttributeName:[UIColor lightGrayColor],NSFontAttributeName : fontMRP}];
    [attrPriceDiscount appendAttributedString:attrMRP];
    
    [attrPriceDiscount appendAttributedString:attrBlankSpace];
    
    UIFont *fontFullDiscount = [UIFont systemFontOfSize:13];
    NSAttributedString *attrFullDiscount = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%.2f%% OFF", selectedProduct.discount] attributes:@{NSFontAttributeName : fontFullDiscount, NSForegroundColorAttributeName:[UIColor colorFromHexString:@"FF4C4C"]}];
    [attrPriceDiscount appendAttributedString:attrFullDiscount];
    
    _lblFullPriceAndDiscount.attributedText = attrPriceDiscount;
    
    
    _lblSinglePriceAndDiscount.text = nil;
    _lblSinglePriceAndDiscount.attributedText = nil;
    
    if(selectedProduct.iscatalogue){
        Cataloguedetail *catalogueDetails = selectedProduct.cataloguedetail;
        if(catalogueDetails.singlepcsavailable){

            NSMutableAttributedString *attrSinglePriceDiscount = [[NSMutableAttributedString alloc] init];
            UIFont *fontSinglePrice = [UIFont boldSystemFontOfSize:13];
            NSAttributedString *attrSinglePrice = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"Single : %@/-", catalogueDetails.singlepcsprice] attributes:@{NSFontAttributeName:fontSinglePrice}];
            
            [attrSinglePriceDiscount appendAttributedString:attrSinglePrice];
            
            UIFont *fontSingleDiscount = [UIFont systemFontOfSize:13];
            NSAttributedString *attrSingleDiscount = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%.f%% OFF", catalogueDetails.singlepcsdiscount] attributes:@{NSFontAttributeName : fontSingleDiscount, NSForegroundColorAttributeName:[UIColor colorFromHexString:@"FF4C4C"]}];
            [attrSinglePriceDiscount appendAttributedString:attrSingleDiscount];
            
            _lblSinglePriceAndDiscount.attributedText = attrSinglePriceDiscount;
            
        }
        
    }
    
}

+ (UIColor *)colorFromHexString:(NSString *)hexString {
    if(hexString.length == 0){
        return nil;
    }
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    if ([[hexString substringToIndex:1] isEqualToString:@"#"]) {
        [scanner setScanLocation:1]; // bypass '#' character
    }
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

@end
