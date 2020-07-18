//
//  AddToCartPopUp.h
//  Meril
//
//  Created by Inspiro Infotech on 01/02/20.
//  Copyright © 2020 Inspiro Infotech. All rights reserved.
//

#import "BaseVC.h"

#import "M_ProductList.h"
#import "M_ProductDetails.h"
#import "M_CartDetail.h"

NS_ASSUME_NONNULL_BEGIN

enum DiscountInType{
    DiscountInPercentage = 0,
    DiscountInAmount = 1
};

typedef void (^OnFailure)(void);
typedef void (^OnSuccess)(void);

@interface AddToCartPopUp : BaseVC

//typedef void (^OnAddUpdateCart)(void);

@property (strong, nonatomic) IBOutlet UIImageView *imgProduct;

@property (strong, nonatomic) IBOutlet ACFloatingTextField *txtPrice;
- (IBAction)priceDidChange:(id)sender;

@property (strong, nonatomic) IBOutlet ACFloatingTextField *txtQuantity;
- (IBAction)quantityDidChange:(id)sender;

@property (strong, nonatomic) IBOutlet ACFloatingTextField *txtAmount;

@property (strong, nonatomic) IBOutlet ACFloatingTextField *txtDiscountIn;
- (IBAction)btnDiscountInClicked:(id)sender;

@property (strong, nonatomic) IBOutlet ACFloatingTextField *txtDiscountInput;
- (IBAction)discountInputDidChange:(id)sender;

@property (strong, nonatomic) IBOutlet ACFloatingTextField *txtFinalAmount;

@property (strong, nonatomic) IBOutlet UILabel *lblFinalAmountTitle;
@property (strong, nonatomic) IBOutlet UILabel *lblFinalAmount;

@property (strong, nonatomic) IBOutlet UILabel *lblBtnAddUpdateCart;
@property (strong, nonatomic) IBOutlet UIView *btnAddToBag;
- (IBAction)btnAddToCartClicked:(id)sender;

- (IBAction)dismissVC:(id)sender;

@property (nonatomic, retain) M_ProductList *selectedProduct;

@property (nonatomic, retain) M_ProductDetails *productDetails;

@property (nonatomic, retain) M_CartDetail *selectedCartItem;

@property (nonatomic, retain) NSMutableArray *arrSelectedSpecs;

@property (nonatomic) CGFloat sellingPrice;
@property (nonatomic) NSInteger quantity;
@property (nonatomic) CGFloat amount;
@property (nonatomic) enum DiscountInType discountIn;
@property (nonatomic) CGFloat discountInput;
@property (nonatomic) CGFloat discountAmount;
@property (nonatomic) CGFloat finalAmount;

//@property (copy, nonatomic) OnAddUpdateCart onAddUpdateCart;

@property (copy, nonatomic) OnFailure onFailure;
@property (copy, nonatomic) OnSuccess onSuccess;

@property (nonatomic) BOOL shouldRemoveFromWishlist;

@end

NS_ASSUME_NONNULL_END
