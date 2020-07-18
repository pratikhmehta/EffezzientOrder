//
//  AddToCartPopUp.m
//  Meril
//
//  Created by Inspiro Infotech on 01/02/20.
//  Copyright © 2020 Inspiro Infotech. All rights reserved.
//

#import "AddToCartPopUp.h"
#import "UIImageView+WebCache.h"
#import "M_ProductSelectableSpec.h"
#import "CartManager.h"
#import "EffezzientOrder-Swift.h"

#define kDiscountIn @[@"Perc(%)", @"Amount"]

@interface AddToCartPopUp ()<UITextFieldDelegate>

@end

@implementation AddToCartPopUp

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupLayout];
    [self setData];
    
    [self calculateData];
}

-(void)setupLayout{
    _imgProduct.layer.masksToBounds = YES;
    _imgProduct.layer.cornerRadius = 4;
    _imgProduct.layer.borderWidth = 1;
    _imgProduct.layer.borderColor = [UIColor blackColor].CGColor;
    
    _btnAddToBag.layer.masksToBounds = YES;
    _btnAddToBag.layer.cornerRadius = 4;
    
    if(_selectedCartItem){
        _lblBtnAddUpdateCart.text = @"UPDATE CART";
    }else{
        _lblBtnAddUpdateCart.text = @"ADD TO CART";
    }
}

-(void)setData{
    NSString *strUrl = [NSString stringWithFormat:@"%@/%@", MM_ProductsImagePath, [_selectedProduct.coverimage stringByReplacingOccurrencesOfString:@" " withString:@"%20"]];
    NSURL *imgUrl = [NSURL URLWithString:strUrl];
    [_imgProduct sd_setImageWithURL:imgUrl placeholderImage:[UIImage imageNamed:@"img_effezient_banner"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if(error){
            [_imgProduct setImage:[UIImage imageNamed:@"img_effezient_banner"]];
        }
    }];
    
    _sellingPrice = _selectedProduct.offerprice;
    _quantity = 1;
    _amount = _sellingPrice * _quantity;
    _discountIn = DiscountInPercentage;
    _discountInput = 0;
    _discountAmount = 0;
    _finalAmount = _amount;
    
    [self setSelectedCartItemData];
    
    _txtPrice.text = [NSString stringWithFormat:@"%.2f", _sellingPrice];
    _txtQuantity.text = [NSString stringWithFormat:@"%ld", (long)_quantity];
    
    [self calculateData];
}

-(void)setSelectedCartItemData{
    if(_selectedCartItem){
        _sellingPrice = _selectedCartItem.sellingPrice;
        _quantity = _selectedCartItem.quantity;
        _amount = _sellingPrice * _quantity;
        
        if(_selectedCartItem.discountPerc > 0){
            _discountIn = DiscountInPercentage;
            _discountInput = _selectedCartItem.discountPerc;
        }else if(_selectedCartItem.discountAmount > 0){
            _discountIn = DiscountInAmount;
            _discountInput = _selectedCartItem.discountAmount;
        }
        _txtDiscountInput.text = [NSString stringWithFormat:@"%.2f", _discountInput];
    }
}

-(void)calculateData{
    _amount = _sellingPrice * _quantity;
    _txtDiscountIn.text = kDiscountIn[_discountIn];
    if(_discountIn == DiscountInPercentage){
        _discountAmount = ( _amount * _discountInput ) / 100;
    }else if(_discountIn == DiscountInAmount){
        _discountAmount = _discountInput;
    }
    _finalAmount = _amount - _discountAmount;
    
    if(_finalAmount < 0){
        _finalAmount = 0;
    }
    
    NSString *strTax = @"(Exclusive Tax)";
    if(_productDetails.priceinclusivetax){
        strTax = @"(Inclusive Tax)";
    }
    
    _txtAmount.text = [NSString stringWithFormat:@"%.2f", _amount];
    _txtFinalAmount.text = [NSString stringWithFormat:@"%.2f", _finalAmount];
    _lblFinalAmountTitle.text = [NSString stringWithFormat:@"Total Amount :\n%@", strTax];
    _lblFinalAmount.text = [NSString stringWithFormat:@"%.2f/-", _finalAmount];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.view setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.6]];
    }];
}

- (IBAction)btnDiscountInClicked:(id)sender {
    [self.view endEditing:YES];
    DropDown *dropDown = [[DropDown alloc] init];
    [dropDown setAnchorView:sender];
    dropDown.dataSource = kDiscountIn;
    dropDown.selectionAction = ^(NSInteger selecetdIndex, NSString * _Nonnull selecetdString){
        if(_discountIn != selecetdIndex){
            _discountAmount = 0;
            _discountInput = 0;
            _txtDiscountInput.text = @"";
            _discountIn = selecetdIndex;
            [self calculateData];
        }
    };
    NSLog(@"%@",[dropDown show]);
}

- (IBAction)btnAddToCartClicked:(id)sender {
    if(_finalAmount > 0){
        [self addToCart];
    }else{
        [AZNotification showNotificationWithTitle:@"Final amount is 0" controller: self notificationType:AZNotificationTypeError];
    }
}

- (IBAction)dismissVC:(id)sender {
    _onSuccess();
    [UIView animateWithDuration:0.3 animations:^{
        [self.view setBackgroundColor:[UIColor clearColor]];
    } completion:^(BOOL finished) {
        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }];
}

- (IBAction)quantityDidChange:(id)sender {
    _quantity = [_txtQuantity.text integerValue];
    [self calculateData];
}

- (IBAction)priceDidChange:(id)sender {
    _sellingPrice = [_txtPrice.text floatValue];
    [self calculateData];
}

#pragma mark - UITextField

- (IBAction)discountInputDidChange:(id)sender {
    _discountInput = [_txtDiscountInput.text floatValue];
    [self calculateData];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if(textField == _txtQuantity){
        NSInteger maxQuantity = _productDetails.maxqtyallowed;
        if(maxQuantity > 0) {
            NSInteger newQuantity = [[NSString stringWithFormat:@"%@%@", _txtQuantity.text, string] integerValue];
            return newQuantity <= maxQuantity;
        }
    }
    
    NSInteger existingDotsCount = [[textField.text componentsSeparatedByString:@"."] count] - 1;
    if(existingDotsCount > 0 && [string isEqualToString:@"."]){
        return NO;
    }
    
    if(textField == _txtDiscountInput){
        NSString *strNewDiscountValue = [NSString stringWithFormat:@"%@%@", textField.text, string];
        CGFloat newDiscountValue = [strNewDiscountValue floatValue];
        if(_discountIn == DiscountInPercentage){
            return newDiscountValue <= 99.99;
        }else if(_discountIn == DiscountInAmount){
            return newDiscountValue < _amount;
        }
    }
    return YES;
}

#pragma mark -

#pragma mark - Service Call Handling

-(void)addToCart
{
    if ([Global checkForConnection])
    {
        NSMutableArray *arrSelectedSpecsForRequest = [NSMutableArray new];
        for(M_ProductSelectableSpec *selectableSpec in _arrSelectedSpecs){
            NSString *selectedvalue = @"";
            if(selectableSpec.selectedvalue) {
                selectedvalue = selectableSpec.selectedvalue;
            }
            
            NSDictionary *spec = @{
                                   @"specname" : selectableSpec.specname,
                                   @"specvalue" : selectedvalue
                                   };
            [arrSelectedSpecsForRequest addObject:spec];
        }
        
        NSDictionary *params = @{
                                 @"personid": [ShareInfo sharedManagerInfo].personId,
                                 @"companyid": [ShareInfo sharedManagerInfo].companyId,
                                 MM_DistributorId : @([CartManager sharedObject].distributorId),
                                 MM_CustomerId : @([CartManager sharedObject].customerId),
                                 MM_DistributorCustomerId : @([CartManager sharedObject].distributorCustomerId),
                                 @"cartdetails": @[
                                                    @{
                                                        @"CartDetailId": @(_selectedCartItem.cartDetailId),
                                                        @"ItemId": @(_selectedProduct.itemid),
                                                        @"Quantity": @(_quantity),
                                                        @"DiscountPerc": _discountIn == DiscountInPercentage ? _txtDiscountInput.text : @0,
                                                        @"DiscountAmount": _discountIn == DiscountInAmount ? @(_discountAmount) : @0,
                                                        @"NetAmount": @(_finalAmount),
                                                        @"OriginalPrice": @(_selectedProduct.offerprice),
                                                        @"SellingPrice": @(_sellingPrice),
                                                        @"TotalAmount" : @(_amount),
                                                        @"productvariant": arrSelectedSpecsForRequest,
                                                        MM_DistributorId : @([CartManager sharedObject].distributorId),
                                                        MM_CustomerId : @([CartManager sharedObject].customerId),
                                                        MM_DistributorCustomerId : @([CartManager sharedObject].distributorCustomerId)
                                                    }
                                                ]
                                 };
        
        [[WebServiceConnector alloc] init:URLAddUpdateCart
                           withParameters:params
                               withObject:self
                             withSelector:@selector(getAddToCartResponse:)
                           forServiceType:@"JSON"
                           showDisplayMsg:WebServiceDialogMsg];
    }
    else
    {
        [AZNotification showNotificationWithTitle: Msg_Internet_Unavailable controller: self notificationType:AZNotificationTypeError];
    }
}

-(void)getAddToCartResponse : (id)sender
{
    if ([sender responseCode] != 100)
    {
        [self showAlertWithMessage:[sender responseError]];
    }
    else
    {
        if([[[sender responseDict] valueForKey:kStatusCode] boolValue])
        {
            [[CartManager sharedObject] setCartCount:[[sender responseArray] firstObject]];
//            if(_onAddUpdateCart){
//                nAddUpdateCart();
//            }
            [AZNotification showNotificationWithTitle:@"Product added to cart" controller: self notificationType:AZNotificationTypeSuccess];
            if(_shouldRemoveFromWishlist && _selectedProduct.iswishlisetd){
                [self callRemoveWishList];
            }else{
                [Global delayCallback:^{
                    [self dismissVC:sender];
                } forTotalSeconds:1.2];
            }
        }
        else
        {
            NSString *errorMsg = [[[sender responseDict] valueForKey: kErrorData] valueForKey:kErrorMessage];
            [AZNotification showNotificationWithTitle:errorMsg controller: self notificationType:AZNotificationTypeError];
            
            [self setSelectedCartItemData];
            _onFailure();
            
        }
    }
}

-(void)callRemoveWishList{
    if ([Global checkForConnection])
    {
        NSDictionary *params = @{
                                 @"companyid" : [ShareInfo sharedManagerInfo].companyId,
                                 @"personId" : [ShareInfo sharedManagerInfo].personId,
                                 @"ItemId": @(_selectedProduct.itemid),
                                 MM_DistributorCustomerId: @([CartManager sharedObject].distributorCustomerId)
                                 };
        
        [[WebServiceConnector alloc] init:URLRemoveFromWishList
                           withParameters:params
                               withObject:self
                             withSelector:@selector(getCallAddOrRemoveWishListResponse:)
                           forServiceType:@"JSON"
                           showDisplayMsg:WebServiceDialogMsg];
    }
    else
    {
        [AZNotification showNotificationWithTitle: Msg_Internet_Unavailable controller: self notificationType:AZNotificationTypeError];
    }
}

-(void)getCallAddOrRemoveWishListResponse:(id)sender{
    if ([sender responseCode] != 100)
    {
        [self showAlertWithMessage:[sender responseError]];
    }
    else
    {
        if([[[sender responseDict] valueForKey:kStatusCode] boolValue])
        {
            _selectedProduct.iswishlisetd = NO;
        }
        else
        {
            NSString *errorMsg = [[[sender responseDict] valueForKey: kErrorData] valueForKey:kErrorMessage];
            [AZNotification showNotificationWithTitle:errorMsg controller: self notificationType:AZNotificationTypeError];
        }
    }
    
    [Global delayCallback:^{
        [self dismissVC:sender];
    } forTotalSeconds:1.2];
}

#pragma mark -

@end
