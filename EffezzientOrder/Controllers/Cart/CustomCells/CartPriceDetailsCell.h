//
//  CartPriceDetailsCell.h
//  Meril
//
//  Created by Inspiro Infotech on 07/02/20.
//  Copyright © 2020 Inspiro Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CartPriceDetailsCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *lblNumberOfItems;

@property (strong, nonatomic) IBOutlet UILabel *lblCartTotal;
@property (strong, nonatomic) IBOutlet UILabel *lblDiscountOnItems;

@property (strong, nonatomic) IBOutlet UIImageView *radioPercentage;
@property (strong, nonatomic) IBOutlet UIButton *btnRadioPercentage;

@property (strong, nonatomic) IBOutlet UIImageView *radioAmount;
@property (strong, nonatomic) IBOutlet UIButton *btnRadioAmount;

@property (strong, nonatomic) IBOutlet UITextField *txtDiscount;

@property (strong, nonatomic) IBOutlet UILabel *lblGrossAmount;
@property (strong, nonatomic) IBOutlet UILabel *lblTax;
@property (strong, nonatomic) IBOutlet UILabel *lblNetAmount;
@property (strong, nonatomic) IBOutlet UILabel *lblRoundOff;
@property (strong, nonatomic) IBOutlet UILabel *lblTitleOrderTotal;
@property (strong, nonatomic) IBOutlet UILabel *lblOrderTotal;

@property (strong, nonatomic) IBOutlet UIView *viewPriceDetails;
@property (strong, nonatomic) IBOutlet UIView *viewCartTotal;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *viewCartTotalHeight;
@property (strong, nonatomic) IBOutlet UIView *viewProductDiscount;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *viewProductDiscountHeight;
@property (strong, nonatomic) IBOutlet UIView *viewDiscountPercentAmount;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *viewDiscountPercentAmountHeight;
@property (strong, nonatomic) IBOutlet UIView *viewGrossAmount;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *viewGrossAmountHeight;
@property (strong, nonatomic) IBOutlet UIView *viewTaxableAmount;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *viewTaxableAmountHeight;
@property (strong, nonatomic) IBOutlet UIView *viewNetAmount;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *viewNetAmountHeight;
@property (strong, nonatomic) IBOutlet UIView *viewRoundOff;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *viewRoundOffHeight;
@property (strong, nonatomic) IBOutlet UIView *viewOrderTotalAmount;


@end

NS_ASSUME_NONNULL_END
