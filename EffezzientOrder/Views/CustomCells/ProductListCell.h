//
//  ProductListCell.h
//  Meril
//
//  Created by Inspiro Infotech on 21/01/20.
//  Copyright © 2020 Inspiro Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FaveButton.h"

#import "M_ProductList.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProductListCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imgProduct;
@property (strong, nonatomic) IBOutlet UIView *vwSinglePieceAvailability;

@property (strong, nonatomic) IBOutlet UILabel *lblBrandName;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightOfLblBrand;

@property (strong, nonatomic) IBOutlet FaveButton *btnWishlist;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *widthOfBtnWishlist;

@property (strong, nonatomic) IBOutlet UILabel *lblCategoryName;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightOfLblCategoryName;

@property (strong, nonatomic) IBOutlet UILabel *lblProductName;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightOfLblProductName;

@property (strong, nonatomic) IBOutlet UILabel *lblMRP;

@property (strong, nonatomic) IBOutlet UILabel *lblFullPrice;
@property (strong, nonatomic) IBOutlet UILabel *lblFullDiscount;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *widthOfLblFullDiscount;

@property (strong, nonatomic) IBOutlet UILabel *lblSinglePrice;
@property (strong, nonatomic) IBOutlet UILabel *lblSingleDiscount;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *widthOfLblSingleDiscount;

@property (strong, nonatomic) IBOutlet UILabel *lblFullPriceAndDiscount;
@property (strong, nonatomic) IBOutlet UILabel *lblSinglePriceAndDiscount;

@property (nonatomic, retain) M_ProductList *selectedProduct;

+(UIColor *)colorFromHexString:(NSString *)hexString;

@end

NS_ASSUME_NONNULL_END
