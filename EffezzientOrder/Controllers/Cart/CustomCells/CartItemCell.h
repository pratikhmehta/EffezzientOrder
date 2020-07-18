//
//  CartItemCell.h
//  Meril
//
//  Created by Inspiro Infotech on 07/02/20.
//  Copyright © 2020 Inspiro Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CartItemCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imgProduct;

@property (strong, nonatomic) IBOutlet UILabel *lblBrandName;

@property (strong, nonatomic) IBOutlet UILabel *lblCategoryName;

@property (strong, nonatomic) IBOutlet UILabel *lblProductName;

@property (strong, nonatomic) IBOutlet UIView *vwQuantity;

@property (strong, nonatomic) IBOutlet UILabel *lblReadOnlyQuantity;
@property (strong, nonatomic) IBOutlet UIButton *btnMinus;
@property (strong, nonatomic) IBOutlet UILabel *lblQuantity;
@property (strong, nonatomic) IBOutlet UIButton *btnPlus;

@property (strong, nonatomic) IBOutlet UILabel *lblMRP;

@property (strong, nonatomic) IBOutlet UILabel *lblFullPrice;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightOfLblFullPrice;

@property (strong, nonatomic) IBOutlet UILabel *lblFullDiscount;

@property (strong, nonatomic) IBOutlet UILabel *lblSinglePrice;
@property (strong, nonatomic) IBOutlet UILabel *lblSingleDiscount;
@property (strong, nonatomic) IBOutlet UILabel *lblCartItemDiscount;

@property (strong, nonatomic) IBOutlet UIView *vwBottomContainer;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightOfVwBottomContainer;
@property (strong, nonatomic) IBOutlet UIButton *btnRemove;
@property (strong, nonatomic) IBOutlet UIButton *btnMoveToWishList;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightOfLblCategoryName;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightOfLblBrand;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightOfLblProductName;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *widthOfLblFullDiscount;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *widthOfLblSingleDiscount;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *widthOfLblCartItemDiscount;

@end

NS_ASSUME_NONNULL_END
