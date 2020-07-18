//
//  CartVC.m
//  Meril
//
//  Created by Inspiro Infotech on 07/02/20.
//  Copyright © 2020 Inspiro Infotech. All rights reserved.
//

#import "CartVC.h"
#import "BrowseProductsVC.h"
#import "ProductDetailsVC.h"

#import "CartTaxBannerCell.h"
#import "CartItemCell.h"
#import "CartAvailableOffersHeaderCell.h"
#import "CartAvailableOfferCell.h"
#import "CartAddMoreFromWishListCell.h"
#import "CartApplyCouponCell.h"
#import "CartPriceDetailsCell.h"
#import "CartOtherDetailsCell.h"
#import "CartRemarksCell.h"

#import "CustomPicker.h"
#import "M_CustomPicker.h"
#import "LSLDatePickerDialog.h"

#import "M_DistributorList.h"
#import "M_OrderAchievement.h"
#import "M_DispatchType.h"

#import "M_CartData.h"
#import "M_CartAmountDetail.h"
#import "M_CartDetail.h"
#import "M_TaxDetail.h"
#import "M_ProductList.h"

#import "AddToCartPopUp.h"

#import "M_CartCount.h"
#import "CartManager.h"

#import "LocationManager.h"
#import "ProductCategoryVC.h"
#import "M_FormConfiguration.h"

enum CartSections{
    TaxBannerSection = 0,
    OffersSection = 1,
    ItemsSection = 2,
    AddMoreSection = 3,
    CouponSection = 4,
    PriceSection = 5,
    OtherDetailsSection = 6,
    RemarksSection = 7,
    TotalSectionsCount = 8
}Sections;
/*
enum CartSections{
    TaxBannerSection = 0,
    OffersSection = 1,
    ItemsSection = 2,
    AddMoreSection = 3,
    CouponSection = 4,
    PriceSection = 5,
    OtherDetailsSection = 6,
    RemarksSection = 7,
    TotalSectionsCount = 8
}OtherDetailRows;
*/
@interface CartVC ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UITextViewDelegate>
{
    BOOL isFirstLoad; // to call getCart for refreshing the details only when the form is not loaded the first time, as on first load, form configuration is to be done first and later getCart() is to be called.
}
@property (nonatomic, retain) NSMutableArray *arrDistributorList;
@property (nonatomic, retain) NSMutableArray *arrAchievementList;
@property (nonatomic, retain) NSMutableArray *arrDispatchTypeList;
@property (nonatomic, retain) NSArray *arrFreight;
@property (nonatomic) BOOL discountPercentageSelected;

@property (nonatomic) enum DiscountInType discountIn;
@property (nonatomic) CGFloat discountInput;

@property (nonatomic) M_CartData *cartData;

@property (nonatomic, retain) M_OrderAchievement *selectedOrderAchievement;
@property (nonatomic, retain) M_DistributorList *selectedDistributor;
@property (nonatomic, retain) M_DispatchType *selectedDispatchType;
@property (nonatomic, retain) NSDate *selectedExpectedDeliveryDate;
@property (nonatomic, retain) NSDictionary *selectedFreight;

@property (nonatomic, retain) NSString *remarks;

@property (nonatomic) BOOL isInstantOrder;

@property (nonatomic, retain) NSArray *arrFormConfigurations;
@property (nonatomic, assign) BOOL IsInstantView;

@end

@implementation CartVC
@synthesize IsInstantView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Cart";
    if(_isReadOnly){
        self.title = @"Order Confirmation";
        _lblBtnPlaceOrConfirmOrder.text = @"PLACE ORDER";
    }else{
        self.title = @"Cart";
        _lblBtnPlaceOrConfirmOrder.text = @"CONFIRM ORDER";
    }
    isFirstLoad = YES;
    _discountIn = DiscountInPercentage;
    
    _arrFreight = @[
                    @{ @"title" : @"Not Applicable", @"value" : @"NotApplicable" },
                    @{ @"title" : @"Include", @"value" : @"Include" },
                    @{ @"title" : @"Extra", @"value" : @"Extra" }
                    ];
    
    _bottomButtonsContainer.hidden = YES;
    _emptyCartButtonsContainer.hidden = YES;
    
    _selectedExpectedDeliveryDate = [NSDate date];
    _remarks = @"";
    
    [_bottomButtonsContainer setHidden:YES];
    [_tblView setHidden:YES];
    [_imgCartEmpty setHidden:YES];
    
    _isInstantOrder = [[NSUserDefaults standardUserDefaults] objectForKey:MM_ShowInstantOrder];
    
    [self getFormConfiguration];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if (!isFirstLoad) {
        [self getCart];
    }
}

-(void)getFormConfiguration
{
    [[WebServiceConnector alloc]init: URLFormConfiguration
                      withParameters: @{
                                        kCompanyID : [ShareInfo sharedManagerInfo].companyId,
                                        kPersonID : [ShareInfo sharedManagerInfo].personId,
                                        kModuleName : kModuleNameFieldManagement,
                                        kSubModuleName : kSubModuleNameNewOrderEntry
                                        }
                          withObject:self
                        withSelector:@selector(getFormConfigurationResponse:)
                      forServiceType:@"JSON"
                      showDisplayMsg:WebServiceDialogMsg];
}

-(void)getFormConfigurationResponse : (id)sender
{
    NSLog(@"getFormConfigurationResponse : %@", [sender responseDict]);
    
    if ([sender responseCode] != 100)
    {
        [self showAlertWithMessage:[sender responseError]];
    }
    else
    {
        if([[[sender responseDict] valueForKey:kStatusCode] boolValue])
        {
            _arrFormConfigurations = [sender responseArray];
//            [self manageFormConfiguration];
//            if (_arrFormConfigurations.count > 0) {
//                return;
//            }
        }
        else
        {
            NSString *errorMsg = [[[sender responseDict] valueForKey: kErrorData] valueForKey:kErrorMessage];
            [AZNotification showNotificationWithTitle: errorMsg controller:self notificationType:AZNotificationTypeError];

        }
    }
    isFirstLoad = NO;
    [self getCart];
}

-(void)manageFormConfiguration{
    for(M_FormConfiguration *configuration in _arrFormConfigurations){
        
        if(configuration.iosBoxId > 0){
            
            UIView *cell = [self.tblView viewWithTag:configuration.iosBoxId];
            
            BOOL isHidden = YES;
            if(IsInstantView){
                if(configuration.isinstantview && configuration.visible){
                    isHidden = NO;
                }
            }else{
                if(configuration.visible){
                    isHidden = NO;
                }
            }
            [cell setHidden:isHidden];
            
            BOOL required = NO;
            if(IsInstantView){
                if(configuration.isinstantview && configuration.isrequired && configuration.isenable){
                    required = YES;
                }
            }else{
                if(configuration.isrequired && configuration.isenable){
                    required = YES;
                }
            }
            
            
            for(UIView *subView in [cell allSubviews]){
                
                if(required){
                    if([subView isKindOfClass:[UIImageView class]]){
                        if(subView.frame.size.width == 6 && subView.frame.size.height == 6)
                            [subView setHidden:NO];
                    }
                }
                
                if([subView isKindOfClass:[UIButton class]] || [subView isKindOfClass:[UITextField class]]){
                    subView.userInteractionEnabled = configuration.isenable;
                }
                
                if([subView isKindOfClass:[UILabel class]] && subView.tag == 888){
                    UILabel *lbl = (UILabel *)subView;
                    lbl.text = configuration.newlabelname;
                }else if([subView isKindOfClass:[UITextField class]]){
                    UITextField *textField = (UITextField *)subView;
                    textField.placeholder = configuration.newlabelname;
                }
                
            }
            
        }
        
    }
    
//    [self.tblView reloadData];
}

#pragma mark - Table View

//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    if(section == OffersSection){
//        return [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CartAvailableOffersHeaderCell class])];
//    }
//    return nil;
//}

//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    if(section == OffersSection){
//        return 44;
//    }
//    return 0;
//}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case TaxBannerSection:{
            CartTaxBannerCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CartTaxBannerCell class]) forIndexPath:indexPath];
            
            NSString *inclusiveOrExclusive = _cartData.priceinclusivetax ? @"inclusive" : @"exclusive";
            cell.lblCartTaxBanner.text = [NSString stringWithFormat:@"Price %@ of tax", inclusiveOrExclusive];
            
            if (cell.isHidden) {
                CGRect frame = cell.contentView.frame;
                frame.size.height = 0;
                cell.contentView.frame = frame;
            }
            else {
                CGRect frame = cell.contentView.frame;
                frame.size.height = 31;
                cell.contentView.frame = frame;
            }
            return cell;
        }
        case OffersSection:
        {
            CartAvailableOfferCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CartAvailableOfferCell class]) forIndexPath:indexPath];
            
            if (cell.isHidden) {
                CGRect frame = cell.contentView.frame;
                frame.size.height = 0;
                cell.contentView.frame = frame;
            }
            else {
                CGRect frame = cell.contentView.frame;
                frame.size.height = 31;
                cell.contentView.frame = frame;
            }
            return cell;
        }
            break;
        case ItemsSection:
        {
            if (_isInstantOrder) {
                CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"idProductCell" forIndexPath:indexPath];
                
                if(_isReadOnly){
                    [cell.vwQuantity setHidden:YES];
                    [cell.lblReadOnlyQuantity setHidden:NO];
                }else{
                    [cell.vwQuantity setHidden:NO];
                    [cell.lblReadOnlyQuantity setHidden:YES];
                }
                
                M_CartDetail *cartDetails = _cartData.cartDetails[indexPath.row];
                M_ProductList *product = cartDetails.productDetails;
                
                cell.lblProductName.text = product.itemname;
                cell.lblProductSpecifications.text = product.shortdescription;
                cell.lblProductMRP.text = (product.mrp > 0) ? [NSString stringWithFormat:@"%0.2f", product.mrp] : @"0";
                cell.lblProductOfferPrice.text = (product.offerprice > 0) ? [NSString stringWithFormat:@"%0.2f", product.offerprice] : @"0";
                
                cell.lblQuantity.text = [NSString stringWithFormat:@"%.f", cartDetails.quantity];
                cell.lblReadOnlyQuantity.text = [NSString stringWithFormat:@"Qty: %.f", cartDetails.quantity];
                
                float price = product.offerprice;
                NSInteger qty = cartDetails.quantity;
                float amt = price * qty;
                product.totalAmount = amt;
                
                cell.lblProductAmount.text = (product.totalAmount > 0) ? [NSString stringWithFormat:@"%0.2f", product.totalAmount] : @"0";
                [Global addBorder:UIRectEdgeBottom forView:cell.lblProductAmount withColor:THEME_BackgroundGrayColor thickness:2 withFrame:cell.lblProductAmount.frame];
                
                cell.vwQuantity.layer.masksToBounds = YES;
                cell.vwQuantity.layer.cornerRadius = 2;
                
                cell.btnPlus.tag = indexPath.row;
                cell.btnMinus.tag = indexPath.row;
                
                [cell.btnPlus addTarget:self action:@selector(btnIncreaseQtyClicked:) forControlEvents:UIControlEventTouchUpInside];
                [cell.btnMinus addTarget:self action:@selector(btnDecreaseQtyClicked:) forControlEvents:UIControlEventTouchUpInside];
                
                
                return cell;
            }
            else {
                CartItemCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CartItemCell class]) forIndexPath:indexPath];
                
                if(_isReadOnly){
                    cell.heightOfVwBottomContainer.constant = 0;
                    [cell.vwQuantity setHidden:YES];
                    [cell.lblReadOnlyQuantity setHidden:NO];
                }else{
                    cell.heightOfVwBottomContainer.constant = 40;
                    [cell.vwQuantity setHidden:NO];
                    [cell.lblReadOnlyQuantity setHidden:YES];
                }
                
                cell.vwQuantity.layer.masksToBounds = YES;
                cell.vwQuantity.layer.cornerRadius = 2;
                
                cell.vwBottomContainer.layer.masksToBounds = YES;
                cell.vwBottomContainer.layer.cornerRadius = 4;
                cell.vwBottomContainer.layer.borderColor = [UIColor lightGrayColor].CGColor;
                cell.vwBottomContainer.layer.borderWidth = 1;
                
                cell.btnPlus.tag = indexPath.row;
                cell.btnMinus.tag = indexPath.row;
                cell.btnRemove.tag = indexPath.row;
                cell.btnMoveToWishList.tag = indexPath.row;
                
                [cell.btnPlus addTarget:self action:@selector(btnIncreaseQtyClicked:) forControlEvents:UIControlEventTouchUpInside];
                [cell.btnMinus addTarget:self action:@selector(btnDecreaseQtyClicked:) forControlEvents:UIControlEventTouchUpInside];
                
                [cell.btnRemove addTarget:self action:@selector(btnRemoveFromCartClicked:) forControlEvents:UIControlEventTouchUpInside];
                [cell.btnMoveToWishList addTarget:self action:@selector(btnMoveToWishlistClicked:) forControlEvents:UIControlEventTouchUpInside];
                
                M_CartDetail *cartDetails = _cartData.cartDetails[indexPath.row];
                M_ProductList *product = cartDetails.productDetails;
                
                NSString *strUrl = [NSString stringWithFormat:@"%@/%@", MM_ProductsImagePath, [product.coverimage stringByReplacingOccurrencesOfString:@" " withString:@"%20"]];
                NSURL *imgUrl = [NSURL URLWithString:strUrl];
                [cell.imgProduct sd_setImageWithURL:imgUrl placeholderImage:[UIImage imageNamed:@"img_effezient_banner"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                    if(error){
                        [cell.imgProduct setImage:[UIImage imageNamed:@"img_effezient_banner"]];
                    }
                }];
                
                cell.lblQuantity.text = [NSString stringWithFormat:@"%.f", cartDetails.quantity];
                
                cell.lblReadOnlyQuantity.text = [NSString stringWithFormat:@"Qty: %.f", cartDetails.quantity];
                
                cell.lblBrandName.text = product.brandname;
                cell.lblCategoryName.text = product.categoryname;
                cell.lblProductName.text = product.itemname;
                
                cell.heightOfLblCategoryName.constant = 15;
                cell.heightOfLblBrand.constant = 15;
                cell.heightOfLblProductName.constant = 15;
                
                if(product.brandname.length == 0){
                    cell.heightOfLblBrand.constant = 0;
                }
                if(product.categoryname.length == 0){
                    cell.heightOfLblCategoryName.constant = 0;
                }
                if(product.itemname.length == 0){
                    cell.heightOfLblProductName.constant = 0;
                }
                
                NSDictionary *mrpAttributes = @{
                                                NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle),
                                                NSForegroundColorAttributeName:[UIColor lightGrayColor]
                                                };
                NSAttributedString *attributedMRP = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%.2f", product.mrp] attributes:mrpAttributes];
                
                NSDictionary *sellingAttributed = @{
                                                    NSForegroundColorAttributeName:[UIColor blackColor]
                                                    };
                NSAttributedString *attributedSelling = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"Bill. Pr.: %.2f/-  ", cartDetails.sellingPrice] attributes:sellingAttributed];
                
                NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] init];
                [attr appendAttributedString:attributedSelling];
                [attr appendAttributedString:attributedMRP];
                
                cell.lblMRP.attributedText = attr;
                
                cell.widthOfLblFullDiscount.constant = 0;
                cell.lblFullPrice.text = [NSString stringWithFormat:@"%.2f/-", cartDetails.originalPrice];
                cell.lblFullDiscount.text = @"";
                if(product.discount > 0){
                    cell.lblFullDiscount.text = [NSString stringWithFormat:@"%.f%% OFF", product.discount];
                    cell.widthOfLblFullDiscount.constant = 49;
                }
                
                cell.lblSinglePrice.text = @"";
                cell.lblSingleDiscount.text = @"";
                
                cell.widthOfLblSingleDiscount.constant = 0;
                
                if(product.iscatalogue){
                    Cataloguedetail *catalogueDetails = product.cataloguedetail;
                    if(catalogueDetails.singlepcsavailable){
                        cell.lblSinglePrice.text = [NSString stringWithFormat:@"Single : %@/-", catalogueDetails.singlepcsprice];
                        if(catalogueDetails.singlepcsdiscount > 0){
                            cell.lblSingleDiscount.text = [NSString stringWithFormat:@"%.f%% OFF", catalogueDetails.singlepcsdiscount];
                            cell.widthOfLblSingleDiscount.constant = 49;
                        }
                    }
                }
                
                cell.widthOfLblCartItemDiscount.constant = 0;
                cell.lblCartItemDiscount.text = @"";
                if(cartDetails.discountPerc > 0){
                    cell.lblCartItemDiscount.text = [NSString stringWithFormat:@"%.2f%% OFF", cartDetails.discountPerc];
                    cell.widthOfLblCartItemDiscount.constant = 97;
                }else if(cartDetails.discountAmount > 0){
                    cell.lblCartItemDiscount.text = [NSString stringWithFormat:@"%.2f/- OFF", cartDetails.discountAmount];
                    cell.widthOfLblCartItemDiscount.constant = 97;
                }
                
                return cell;
            }
        }
            break;
        case AddMoreSection:
        {
            CartAddMoreFromWishListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CartAddMoreFromWishListCell class]) forIndexPath:indexPath];
            
            if (cell.isHidden) {
                CGRect frame = cell.contentView.frame;
                frame.size.height = 0;
                cell.contentView.frame = frame;
            }
            else {
                CGRect frame = cell.contentView.frame;
                frame.size.height = 44;
                cell.contentView.frame = frame;
            }
            return cell;
        }
            break;
        case CouponSection:
        {
            CartApplyCouponCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CartApplyCouponCell class]) forIndexPath:indexPath];
            
            if (cell.isHidden) {
                CGRect frame = cell.contentView.frame;
                frame.size.height = 0;
                cell.contentView.frame = frame;
            }
            else {
                CGRect frame = cell.contentView.frame;
                frame.size.height = 44;
                cell.contentView.frame = frame;
            }
            return cell;
        }
            break;
        case PriceSection:
        {
            CartPriceDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CartPriceDetailsCell class]) forIndexPath:indexPath];
            
            [cell.btnRadioAmount addTarget:self action:@selector(btnDiscountAmountClicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.btnRadioPercentage addTarget:self action:@selector(btnDiscountPercentageClicked:) forControlEvents:UIControlEventTouchUpInside];
            cell.txtDiscount.delegate = self;
            [cell.txtDiscount addTarget:self action:@selector(discountInputDidChange:) forControlEvents:UIControlEventEditingChanged];
            
            if(_isReadOnly){
                [cell.btnRadioAmount setUserInteractionEnabled:NO];
                [cell.btnRadioPercentage setUserInteractionEnabled:NO];
                [cell.txtDiscount setUserInteractionEnabled:NO];
                [cell.txtDiscount setBackgroundColor:[UIColor clearColor]];
            }else{
                [cell.btnRadioAmount setUserInteractionEnabled:YES];
                [cell.btnRadioPercentage setUserInteractionEnabled:YES];
                [cell.txtDiscount setUserInteractionEnabled:YES];
                [cell.txtDiscount setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
            }
            
            [cell.radioPercentage setImage:[UIImage imageNamed:@"radio_unchecked"]];
            [cell.radioAmount setImage:[UIImage imageNamed:@"radio_unchecked"]];
            if(_discountIn == DiscountInPercentage){
                [cell.radioPercentage setImage:[UIImage imageNamed:@"radio_checked"]];
            }else{
                [cell.radioAmount setImage:[UIImage imageNamed:@"radio_checked"]];
            }
            
            if(_cartData.cartDetails.count > 1){
                cell.lblNumberOfItems.text = [NSString stringWithFormat:@"(%ld Items)", (long)_cartData.cartDetails.count];
            }else{
                cell.lblNumberOfItems.text = [NSString stringWithFormat:@"(%ld Item)", (long)_cartData.cartDetails.count];
            }
            
            M_CartAmountDetail *amountDetails = _cartData.cartAmountDetail;
            cell.lblCartTotal.text = [NSString stringWithFormat:@"%.2f", amountDetails.totalAmount];
            cell.lblDiscountOnItems.text = [NSString stringWithFormat:@"-%.2f", amountDetails.totlItemDiscount];
            cell.lblGrossAmount.text = [NSString stringWithFormat:@"%.2f", amountDetails.grossAmount];
            cell.lblTax.text = [NSString stringWithFormat:@"%.2f", amountDetails.taxAmount];
            cell.lblNetAmount.text = [NSString stringWithFormat:@"%.2f", amountDetails.netAmount];
            cell.lblRoundOff.text = [NSString stringWithFormat:@"%.2f", amountDetails.roundOff];
            cell.lblTitleOrderTotal.text = [NSString stringWithFormat:@"Order Total (%@ of tax)", _cartData.priceinclusivetax ? @"Inclusive" : @"Exclusive"];
            cell.lblOrderTotal.text = [NSString stringWithFormat:@"%.2f", amountDetails.finalAmount];
            cell.txtDiscount.text = [NSString stringWithFormat:@"%.2f", _discountInput];
            
            if (cell.isHidden) {
                CGRect frame = cell.contentView.frame;
                frame.size.height = 0;
                cell.contentView.frame = frame;
            }
            else {
                if (cell.viewCartTotal.isHidden) {
                    cell.viewCartTotalHeight.constant = 0;
                    [cell.viewCartTotal setNeedsUpdateConstraints];
                }
                if (cell.viewProductDiscount.isHidden) {
                    cell.viewProductDiscountHeight.constant = 0;
                    [cell.viewProductDiscount setNeedsUpdateConstraints];
                }
                if (cell.viewDiscountPercentAmount.isHidden) {
                    cell.viewDiscountPercentAmountHeight.constant = 0;
                    [cell.viewDiscountPercentAmount setNeedsUpdateConstraints];
                }
                if (cell.viewGrossAmount.isHidden) {
                    cell.viewGrossAmountHeight.constant = 0;
                    [cell.viewGrossAmount setNeedsUpdateConstraints];
                }
                if (cell.viewTaxableAmount.isHidden) {
                    cell.viewTaxableAmountHeight.constant = 0;
                    [cell.viewTaxableAmount setNeedsUpdateConstraints];
                }
                if (cell.viewNetAmount.isHidden) {
                    cell.viewNetAmountHeight.constant = 0;
                    [cell.viewNetAmount setNeedsUpdateConstraints];
                }
                if (cell.viewRoundOff.isHidden) {
                    cell.viewRoundOffHeight.constant = 0;
                    [cell.viewRoundOff setNeedsUpdateConstraints];
                }
            }
            return cell;
        }
            break;
        case OtherDetailsSection:
        {
            CartOtherDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CartOtherDetailsCell class]) forIndexPath:indexPath];
            
            [cell.btnDistributor addTarget:self action:@selector(btnDistributorClicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.btnOrderAchievement addTarget:self action:@selector(btnOrderAchievementClicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.btnExpectedDelivery addTarget:self action:@selector(btnExpectedDeliveryDateClicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.btnDispatchMode addTarget:self action:@selector(btnDispatchModeClicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.btnFreight addTarget:self action:@selector(btnFreightClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            
            BOOL saveButtonVisible = [self isOtherDetailSaveButtonVisibile];
            [cell.btnSave setAlpha: saveButtonVisible ? 1.0 : 0.00];
            
            [cell.btnSave addTarget:self action:@selector(btnSaveOtherDetailsClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell.btnDistributor setTitle:@"Select" forState:UIControlStateNormal];
            if(_selectedDistributor){
                [cell.btnDistributor setTitle:_selectedDistributor.distributorName forState:UIControlStateNormal];
            }
            
            [cell.btnOrderAchievement setTitle:@"Select" forState:UIControlStateNormal];
            if(_selectedOrderAchievement){
                [cell.btnOrderAchievement setTitle:_selectedOrderAchievement.orderachievement forState:UIControlStateNormal];
            }
            
            [cell.btnDispatchMode setTitle:@"Select" forState:UIControlStateNormal];
            if(_selectedDispatchType){
                [cell.btnDispatchMode setTitle:_selectedDispatchType.dispatchTypeName forState:UIControlStateNormal];
            }
            
            [cell.btnExpectedDelivery setTitle:@"Select" forState:UIControlStateNormal];
            if(_selectedExpectedDeliveryDate){
                NSString *strDate = [Global getStringFromDate:_selectedExpectedDeliveryDate formatter:@"dd MMM yyyy"];
                [cell.btnExpectedDelivery setTitle:strDate forState:UIControlStateNormal];
            }
            
            if(_selectedDispatchType == nil || _selectedDispatchType.freightApplicable == NO){
                [cell.lblFreight setHidden:YES];
                [cell.btnFreight setHidden:YES];
            }else{
                [cell.lblFreight setHidden:NO];
                [cell.btnFreight setHidden:NO];
                [cell.btnFreight setTitle:@"Select" forState:UIControlStateNormal];
                if(_selectedFreight){
                    [cell.btnFreight setTitle:_selectedFreight[@"title"] forState:UIControlStateNormal];
                }
            }
            
            if(_isReadOnly){
                [cell.btnSave setUserInteractionEnabled:NO];
                [cell.btnSave setHidden:YES];
                
                [cell.btnDistributor setUserInteractionEnabled:NO];
                [cell.btnOrderAchievement setUserInteractionEnabled:NO];
                [cell.btnExpectedDelivery setUserInteractionEnabled:NO];
                [cell.btnDispatchMode setUserInteractionEnabled:NO];
                [cell.btnFreight setUserInteractionEnabled:NO];
            }else{
                [cell.btnSave setUserInteractionEnabled:YES];
                [cell.btnSave setHidden:NO];
                
                [cell.btnDistributor setUserInteractionEnabled:YES];
                [cell.btnOrderAchievement setUserInteractionEnabled:YES];
                [cell.btnExpectedDelivery setUserInteractionEnabled:YES];
                [cell.btnDispatchMode setUserInteractionEnabled:YES];
                [cell.btnFreight setUserInteractionEnabled:YES];
            }
            
            if (cell.isHidden) {
                CGRect frame = cell.contentView.frame;
                frame.size.height = 0;
                cell.contentView.frame = frame;
            }
            else {
                if (cell.viewDistributor.isHidden) {
                    cell.viewDistributorHeight.constant = 0;
                    [cell.viewDistributor setNeedsUpdateConstraints];
                }
                if (cell.viewOrderAchievement.isHidden) {
                    cell.viewOrderAchievementHeight.constant = 0;
                    [cell.viewOrderAchievement setNeedsUpdateConstraints];
                }
                if (cell.viewExpectedDeliveryDate.isHidden) {
                    cell.viewExpectedDeliveryDateHeight.constant = 0;
                    [cell.viewExpectedDeliveryDate setNeedsUpdateConstraints];
                }
                if (cell.viewDispatchMode.isHidden) {
                    cell.viewDispatchModeHeight.constant = 0;
                    [cell.viewDispatchMode setNeedsUpdateConstraints];
                }
                if (cell.viewFreight.isHidden) {
                    cell.viewFreightHeight.constant = 0;
                    [cell.viewFreight setNeedsUpdateConstraints];
                }
            }
            return cell;
        }
        case RemarksSection :{
            CartRemarksCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CartRemarksCell class]) forIndexPath:indexPath];
            if(_isReadOnly){
                [cell.txtRemarks setUserInteractionEnabled:YES];
            }else{
                [cell.txtRemarks setUserInteractionEnabled:NO];
            }
            cell.txtRemarks.delegate = self;
            return cell;
        }
        default:
            break;
    }
    return nil;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return TotalSectionsCount;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == ItemsSection){
        return _cartData.cartDetails.count;
    }
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

//    UITableViewCell* cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
//
//    if(cell.isHidden){
//        return 0;
//    }

    switch (indexPath.section) {
        case TaxBannerSection:
            return _isReadOnly ? 0 : 0;//31;
            break;
        case OffersSection:
            return _isReadOnly ? 0 : 0;//31;
            break;
        case ItemsSection:
            return (_isInstantOrder) ? UITableViewAutomaticDimension : (_isReadOnly) ? 202-48 : 202;
            break;
        case AddMoreSection:
            return (_isInstantOrder) ? 0 : (_isReadOnly ? 0 : 44);
            break;
        case CouponSection:
            return _isReadOnly ? 0 : 0;//44;
            break;
        case PriceSection:
            return 350;
            break;
        case OtherDetailsSection:
            return 240;
        case RemarksSection:
            return _isReadOnly ? 177 : 0;
            break;
        default:
            break;
    }
    return 202;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if(section == OffersSection || section == CouponSection){
        return 0;
    }
    
    if(_isReadOnly){
        if(section == TaxBannerSection || section == OffersSection || section == AddMoreSection || section == CouponSection){
            return 0;
        }
    }
    
    return 10;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(_isReadOnly){
        return;
    }
    if(indexPath.section == ItemsSection){
        if (!_isInstantOrder) {
            M_CartDetail *cartDetails = _cartData.cartDetails[indexPath.row];
            M_ProductList *product = cartDetails.productDetails;
            ProductDetailsVC *vc = loadViewController(SB_Order, VC_ProductDetails);
            vc.selectedProduct = product;
            vc.selectedCartItem = cartDetails;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    else if(indexPath.section == AddMoreSection){
        BrowseProductsVC *vc = loadViewController(SB_Order, VC_BrowseProducts);
        vc.isOnWishlist = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark -

#pragma mark - Cell Button Clicks

-(void)btnDecreaseQtyClicked:(UIButton *)sender{
    M_CartDetail *cartDetail = _cartData.cartDetails[sender.tag];
    NSInteger quantity = cartDetail.quantity - 1;
    if(quantity < 1){
        [self btnRemoveFromCartClicked:sender];
    }else{
        [self callUpdateQuantity:cartDetail newQuantity:quantity];
    }
}

-(void)btnIncreaseQtyClicked:(UIButton *)sender{
    M_CartDetail *cartDetail = _cartData.cartDetails[sender.tag];
    NSInteger quantity = cartDetail.quantity + 1;
    [self callUpdateQuantity:cartDetail newQuantity:quantity];
}

-(void)btnRemoveFromCartClicked:(UIButton *)sender{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"Are you sure to delete this item from your cart?" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        M_CartDetail *cartDetails = _cartData.cartDetails[sender.tag];
        [self removeCartItem:cartDetails];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)btnMoveToWishlistClicked:(UIButton *)sender{
    [self callMoveToWishList:_cartData.cartDetails[sender.tag]];
}

-(void)btnDiscountPercentageClicked:(UIButton *)sender{
    _discountIn = DiscountInPercentage;
    _discountInput = 0;
    [self reloadPriceCell];
}

-(void)btnDiscountAmountClicked:(UIButton *)sender{
    _discountIn = DiscountInAmount;
    _discountInput = 0;
    [self reloadPriceCell];
}

-(void)btnDistributorClicked:(UIButton *)sender{
    if(_arrDistributorList.count == 0){
        [self getDistributorList];
    }else{
        NSMutableArray *arrData = [NSMutableArray new];
        
        CustomPicker *picker = [[CustomPicker alloc] initWithData:arrData];
        for(M_DistributorList *distributor in _arrDistributorList){
            M_CustomPicker *model = [[M_CustomPicker alloc] initWithKey:distributor.distributorID Value:distributor.distributorName andCustomObject:distributor];
            [arrData addObject:model];
            if(_selectedDistributor.distributorID == distributor.distributorID){
                picker.arrSelectedValues = [[NSMutableArray alloc] initWithObjects:model, nil];
            }
        }

        picker.onlySingleSelection = true;
        [picker showWithTitle:@"Select Distributor" SelectionHandler:^(NSMutableArray * _Nonnull selectedValues) {
            _selectedDistributor = nil;
            if(selectedValues.count > 0){
                M_CustomPicker *selected = selectedValues[0];
                _selectedDistributor = selected.customObject;
            }
            [self reloadOtherDetailsCell];
        }];
    }
}

-(void)btnOrderAchievementClicked:(UIButton *)sender{
    if(_arrAchievementList.count == 0){
        [self getOrderAchievementList];
    }else{
        NSMutableArray *arrData = [NSMutableArray new];
        
        CustomPicker *picker = [[CustomPicker alloc] initWithData:arrData];
        for(M_OrderAchievement *achievement in _arrAchievementList){
            M_CustomPicker *model = [[M_CustomPicker alloc] initWithKey:[achievement.orderachievementid integerValue] Value:achievement.orderachievement andCustomObject:achievement];
            [arrData addObject:model];
            if([_selectedOrderAchievement.orderachievementid isEqualToString:achievement.orderachievementid]){
                picker.arrSelectedValues = [[NSMutableArray alloc] initWithObjects:model, nil];
            }
        }
        
        picker.onlySingleSelection = true;
        [picker showWithTitle:@"Select Order Achievement" SelectionHandler:^(NSMutableArray * _Nonnull selectedValues) {
            _selectedOrderAchievement = nil;
            if(selectedValues.count > 0){
                M_CustomPicker *selected = selectedValues[0];
                _selectedOrderAchievement = selected.customObject;
            }
            [self reloadOtherDetailsCell];
        }];
    }
}

-(void)btnExpectedDeliveryDateClicked:(UIButton *)sender{
    LSLDatePickerDialog *dpDialog = [[LSLDatePickerDialog alloc] init];
    [dpDialog showWithTitle:@"Expected Delivery Date" doneButtonTitle:@"Done" cancelButtonTitle:@"Cancel"
                defaultDate:_selectedExpectedDeliveryDate ? _selectedExpectedDeliveryDate : [NSDate date] minimumDate:[NSDate date] maximumDate:nil datePickerMode:UIDatePickerModeDate
                   callback:^(NSDate * _Nullable date){
                       if(date){
                           _selectedExpectedDeliveryDate = date;
                       }
                       [self reloadOtherDetailsCell];
                   }
     ];
}

-(void)btnDispatchModeClicked:(UIButton *)sender{
    if(_arrDispatchTypeList.count == 0){
        [self getDispatchTypeList];
    }else{
        NSMutableArray *arrData = [NSMutableArray new];
        
        CustomPicker *picker = [[CustomPicker alloc] initWithData:arrData];
        for(M_DispatchType *dispatchType in _arrDispatchTypeList){
            M_CustomPicker *model = [[M_CustomPicker alloc] initWithKey:dispatchType.dispatchTypeId Value:dispatchType.dispatchTypeName andCustomObject:dispatchType];
            [arrData addObject:model];
            if(_selectedDispatchType.dispatchTypeId == dispatchType.dispatchTypeId){
                picker.arrSelectedValues = [[NSMutableArray alloc] initWithObjects:model, nil];
            }
        }
        
        picker.onlySingleSelection = true;
        [picker showWithTitle:@"Select Dispatch Mode" SelectionHandler:^(NSMutableArray * _Nonnull selectedValues) {
            _selectedDispatchType = nil;
            if(selectedValues.count > 0){
                M_CustomPicker *selected = selectedValues[0];
                _selectedDispatchType = selected.customObject;
                if(_selectedDispatchType.freightApplicable == NO){
                    _selectedFreight = nil;
                }
            }
            [self reloadOtherDetailsCell];
        }];
    }
}

-(void)btnFreightClicked:(UIButton *)sender{
    NSMutableArray *arrData = [NSMutableArray new];
    
    CustomPicker *picker = [[CustomPicker alloc] initWithData:arrData];
    for(NSDictionary *freight in _arrFreight){
        M_CustomPicker *model = [[M_CustomPicker alloc] initWithKey:[_arrFreight indexOfObject:freight] Value:freight[@"title"] andCustomObject:freight];
        [arrData addObject:model];
        if([_selectedFreight[@"value"] isEqualToString: freight[@"value"]]){
            picker.arrSelectedValues = [[NSMutableArray alloc] initWithObjects:model, nil];
        }
    }
    
    picker.onlySingleSelection = true;
    [picker showWithTitle:@"Select Freight" SelectionHandler:^(NSMutableArray * _Nonnull selectedValues) {
        _selectedFreight = nil;
        if(selectedValues.count > 0){
            M_CustomPicker *selected = selectedValues[0];
            _selectedFreight = selected.customObject;
        }
        [self reloadOtherDetailsCell];
    }];
}

-(void)btnSaveOtherDetailsClicked:(UIButton *)sender{
    if([self isOtherDetailSaveButtonVisibile] == NO){
        return;
    }
    [self updateCartOtherDetail];
}

#pragma mark -

#pragma mark - VC Button Clicks

- (IBAction)btnGoToHomeClicked:(id)sender {
    UIViewController *vc = [self.navigationController.viewControllers firstObject];
    [self.navigationController popToViewController:vc animated:YES];
}

- (IBAction)btnContinueShopping:(id)sender {
    
    if (_isInstantOrder) {
        ProductCategoryVC *categoryVC;
        for (UIViewController *vc in self.navigationController.viewControllers) {
            if([vc isKindOfClass:[ProductCategoryVC class]]){
                categoryVC = (ProductCategoryVC *) vc;
                break;
            }
        }
        if(categoryVC){
            [self.navigationController popToViewController:categoryVC animated:YES];
        }
        else
            [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else {
        BrowseProductsVC *browseProductsVC;
        for (UIViewController *vc in self.navigationController.viewControllers) {
            if([vc isKindOfClass:[BrowseProductsVC class]]){
                browseProductsVC = (BrowseProductsVC *) vc;
                break;
            }
        }
        if(browseProductsVC){
            [self.navigationController popToViewController:browseProductsVC animated:YES];
        }
        else
            [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (IBAction)btnViewDetailsClicked:(id)sender {
    NSIndexPath *lastIndex = [NSIndexPath indexPathForRow:0 inSection:TotalSectionsCount-1];
    [_tblView scrollToRowAtIndexPath:lastIndex atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

- (IBAction)btnPlaceOrderClicked:(id)sender {
    if(_isReadOnly == NO){
        
        if([self isValidData]){
            CartVC *vc = loadViewController(SB_Order, VC_Cart);
            vc.isReadOnly = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }else{
        [self placeOrder];
    }
}

#pragma mark -

#pragma mark - Shorthand Methods

-(void)reloadPriceCell{
//    [self manageFormConfiguration];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:PriceSection];
    [_tblView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

-(void)reloadOtherDetailsCell{
    [self manageFormConfiguration];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:OtherDetailsSection];
    [_tblView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

-(void)setInitialCartDiscount{
    _discountInput = 0;
    _discountIn = DiscountInPercentage;
    
    M_CartAmountDetail *amountDetails = _cartData.cartAmountDetail;
    if(amountDetails.cartDiscountAmt > 0){
        _discountInput = amountDetails.cartDiscountAmt;
        _discountIn = DiscountInAmount;
    }else if(amountDetails.cartDiscountPerc > 0){
        _discountInput = amountDetails.cartDiscountPerc;
        _discountIn = DiscountInPercentage;
    }
//    [self manageFormConfiguration];
    [_tblView reloadData];
}

-(BOOL)isOtherDetailSaveButtonVisibile{
    BOOL saveButtonVisible = NO;
    
    BOOL isDistributorChanged = _selectedDistributor.distributorID != _cartData.supplierId;
    BOOL isOrderAchievementChanged = [_selectedOrderAchievement.orderachievementid integerValue] != _cartData.orderAchievementID;
    
    BOOL isExpectedDeliveryDateChanged = NO;
    if(_selectedExpectedDeliveryDate){
        isExpectedDeliveryDateChanged = ![[Global getStringFromDate:_selectedExpectedDeliveryDate formatter:@"dd-MM-yyyy"] isEqualToString:_cartData.expectedDeliveryDate];
    }
    
    BOOL isDispatchTypeChanged = _selectedDispatchType.dispatchTypeId != _cartData.dispatchTypeId;
    
    BOOL isFreightChanged = NO;
    if(_selectedFreight){
        isFreightChanged = ![_selectedFreight[@"value"] isEqualToString:_cartData.freight];
    }
    
    saveButtonVisible = isDistributorChanged || isOrderAchievementChanged || isExpectedDeliveryDateChanged || isDispatchTypeChanged || isFreightChanged;
    return saveButtonVisible;
}

#pragma mark -

#pragma mark - Service Call

-(void)getDistributorList
{
    if([Global checkForConnection])
    {
        [[WebServiceConnector alloc] init: URLGetListOfDistributors
                           withParameters: @{
                                             kUserID : [ShareInfo sharedManagerInfo].personId,
                                             kCompanyID : [ShareInfo sharedManagerInfo].companyId,
                                             @"customerid" : @([CartManager sharedObject].distributorCustomerId)
                                             }
                               withObject:self
                             withSelector:@selector(getDistributorListResponse:)
                           forServiceType:@"JSON"
                           showDisplayMsg:WebServiceDialogMsg];
    }
    else
    {
        [AZNotification showNotificationWithTitle: Msg_Internet_Unavailable controller: self notificationType:AZNotificationTypeError];
    }
}

-(void)getDistributorListResponse : (id)sender
{
    if ([sender responseCode] != 100)
    {
        [self showAlertWithMessage:[sender responseError]];
    }
    else
    {
        if([[[sender responseDict] valueForKey:kStatusCode] boolValue])
        {
            _arrDistributorList = [NSMutableArray arrayWithArray:[sender responseArray]];
            [self btnDistributorClicked:nil];
        }
        else
        {
            NSString *errorMsg = [[[sender responseDict] valueForKey:kErrorData] valueForKey:kErrorMessage];
            [AZNotification showNotificationWithTitle: errorMsg controller: self notificationType:AZNotificationTypeError];
        }
    }
}

-(void)getOrderAchievementList
{
    if([Global checkForConnection])
    {
        [[WebServiceConnector alloc] init: URLGetOrderAchievementList
                           withParameters: @{
                                             kPersonID : [ShareInfo sharedManagerInfo].personId,
                                             kCompanyID : [ShareInfo sharedManagerInfo].companyId
                                             }
                               withObject:self
                             withSelector:@selector(getOrderAchievementListResponse:)
                           forServiceType:@"JSON"
                           showDisplayMsg:WebServiceDialogMsg];
    }
    else
    {
        [AZNotification showNotificationWithTitle: Msg_Internet_Unavailable controller: self notificationType:AZNotificationTypeError];
    }
}

-(void)getOrderAchievementListResponse : (id)sender
{
    if ([sender responseCode] != 100)
    {
        [self showAlertWithMessage:[sender responseError]];
    }
    else
    {
        if([[[sender responseDict] valueForKey:kStatusCode] boolValue])
        {
            _arrAchievementList = [NSMutableArray arrayWithArray:[sender responseArray]];
            [self btnOrderAchievementClicked:nil];
        }
        else
        {
            NSString *errorMsg = [[[sender responseDict] valueForKey:kErrorData] valueForKey:kErrorMessage];
            [AZNotification showNotificationWithTitle: errorMsg controller: self notificationType:AZNotificationTypeError];
        }
    }
}

-(void)getDispatchTypeList
{
    if([Global checkForConnection])
    {
        [[WebServiceConnector alloc] init: URLGetDispatchType
                           withParameters: @{
                                             kPersonID : [ShareInfo sharedManagerInfo].personId,
                                             kCompanyID : [ShareInfo sharedManagerInfo].companyId
                                             }
                               withObject:self
                             withSelector:@selector(getDispatchTypeListResponse:)
                           forServiceType:@"JSON"
                           showDisplayMsg:WebServiceDialogMsg];
    }
    else
    {
        [AZNotification showNotificationWithTitle: Msg_Internet_Unavailable controller: self notificationType:AZNotificationTypeError];
    }
}

-(void)getDispatchTypeListResponse : (id)sender
{
    if ([sender responseCode] != 100)
    {
        [self showAlertWithMessage:[sender responseError]];
    }
    else
    {
        if([[[sender responseDict] valueForKey:kStatusCode] boolValue])
        {
            _arrDispatchTypeList = [NSMutableArray arrayWithArray:[sender responseArray]];
            [self btnDispatchModeClicked:nil];
        }
        else
        {
            NSString *errorMsg = [[[sender responseDict] valueForKey:kErrorData] valueForKey:kErrorMessage];
            [AZNotification showNotificationWithTitle: errorMsg controller: self notificationType:AZNotificationTypeError];
        }
    }
}

-(void)updateCartOrderDetail{
    if([Global checkForConnection])
    {
        
        CGFloat cartDiscountAmount = 0;
        CGFloat cartDiscountPerc = 0;

        if(_discountIn == DiscountInAmount){
            cartDiscountAmount = _discountInput;
        }else if(_discountIn == DiscountInPercentage){
            cartDiscountPerc = _discountInput;
        }


        [[WebServiceConnector alloc] init: URLUpdateCartOrderDetail
                           withParameters: @{
                                             kPersonID : [ShareInfo sharedManagerInfo].personId,
                                             kCompanyID : [ShareInfo sharedManagerInfo].companyId,
                                             MM_DistributorId : @([CartManager sharedObject].distributorId),
                                             MM_CustomerId : @([CartManager sharedObject].customerId),
                                             MM_DistributorCustomerId : @([CartManager sharedObject].distributorCustomerId),
                                             @"SalesPersonDiscountAmt": @(cartDiscountAmount),
                                             @"SalesPersonDiscountPerc": @(cartDiscountPerc),
                                             }
                               withObject:self
                             withSelector:@selector(getUpdateCartOtherDetailResponse:)
                           forServiceType:@"JSON"
                           showDisplayMsg:WebServiceDialogMsg];
    }
    else
    {
        [AZNotification showNotificationWithTitle: Msg_Internet_Unavailable controller: self notificationType:AZNotificationTypeError];
    }
}

-(void)getUpdateCartOrderDetailResponse : (id)sender
{
    if ([sender responseCode] != 100)
    {
        [self showAlertWithMessage:[sender responseError]];
    }
    else
    {
        if([[[sender responseDict] valueForKey:kStatusCode] boolValue])
        {
            _cartData.cartAmountDetail = [[sender responseArray] firstObject];
            [self getCart];
        }
        else
        {
            NSString *errorMsg = [[[sender responseDict] valueForKey:kErrorData] valueForKey:kErrorMessage];
            [AZNotification showNotificationWithTitle: errorMsg controller: self notificationType:AZNotificationTypeError];
        }
    }
}

-(void)updateCartOtherDetail
{
    if([Global checkForConnection])
    {
        
//        CGFloat cartDiscountAmount = 0;
//        CGFloat cartDiscountPerc = 0;
//
//        if(_discountIn == DiscountInAmount){
//            cartDiscountAmount = _discountInput;
//        }else if(_discountIn == DiscountInPercentage){
//            cartDiscountPerc = _discountInput;
//        }
        
        NSString *orderAchievementId = _selectedOrderAchievement.orderachievementid;;
        NSInteger supplierId = _selectedDistributor.distributorID;
        
        NSString *dispatchTypeId = [NSString stringWithFormat:@"%ld", _selectedDispatchType.dispatchTypeId];
        if([dispatchTypeId integerValue] == 0){
            dispatchTypeId = nil;
        }
        
        NSString *freight = _selectedFreight[@"value"];
        NSString *strExpectedDeliveryDate = [Global getStringFromDate:_selectedExpectedDeliveryDate formatter:@"dd-MM-yyyy"];
        
        [[WebServiceConnector alloc] init: URLUpdateCartOtherDetail
                           withParameters: @{
                                             kPersonID : [ShareInfo sharedManagerInfo].personId,
                                             kCompanyID : [ShareInfo sharedManagerInfo].companyId,
                                             MM_DistributorId : @([CartManager sharedObject].distributorId),
                                             MM_CustomerId : @([CartManager sharedObject].customerId),
                                             MM_DistributorCustomerId : @([CartManager sharedObject].distributorCustomerId),
//                                             @"SalesPersonDiscountAmt": @(cartDiscountAmount),
//                                             @"SalesPersonDiscountPerc": @(cartDiscountPerc),
                                             @"OrderAchievementID": orderAchievementId ? orderAchievementId : [NSNull null],
                                             @"SupplierId": @(supplierId),
                                             @"DispatchTypeId": dispatchTypeId ? dispatchTypeId : [NSNull null],
                                             @"Freight": freight ? freight : [NSNull null],
                                             @"ExpectedDeliveryDate": strExpectedDeliveryDate ? strExpectedDeliveryDate : [NSNull null]
                                             }
                               withObject:self
                             withSelector:@selector(getUpdateCartOtherDetailResponse:)
                           forServiceType:@"JSON"
                           showDisplayMsg:WebServiceDialogMsg];
    }
    else
    {
        [AZNotification showNotificationWithTitle: Msg_Internet_Unavailable controller: self notificationType:AZNotificationTypeError];
    }
}

-(void)getUpdateCartOtherDetailResponse : (id)sender
{
    if ([sender responseCode] != 100)
    {
        [self showAlertWithMessage:[sender responseError]];
    }
    else
    {
        if([[[sender responseDict] valueForKey:kStatusCode] boolValue])
        {
            [self getCart];
        }
        else
        {
            NSString *errorMsg = [[[sender responseDict] valueForKey:kErrorData] valueForKey:kErrorMessage];
            [AZNotification showNotificationWithTitle: errorMsg controller: self notificationType:AZNotificationTypeError];
        }
    }
}

-(void)removeCartItem:(M_CartDetail *)cartItem
{
    
    if([Global checkForConnection])
    {
        [[WebServiceConnector alloc] init: URLRemvoeFromCart
                           withParameters: @{
                                             kPersonID : [ShareInfo sharedManagerInfo].personId,
                                             kCompanyID : [ShareInfo sharedManagerInfo].companyId,
                                             MM_DistributorId : @([CartManager sharedObject].distributorId),
                                             MM_CustomerId : @([CartManager sharedObject].customerId),
                                             MM_DistributorCustomerId : @([CartManager sharedObject].distributorCustomerId),
                                             @"CartDetailId": @(cartItem.cartDetailId)
                                             }
                               withObject:self
                             withSelector:@selector(getRemoveCartItemResponse:)
                           forServiceType:@"JSON"
                           showDisplayMsg:WebServiceDialogMsg];
    }
    else
    {
        [AZNotification showNotificationWithTitle: Msg_Internet_Unavailable controller: self notificationType:AZNotificationTypeError];
    }
}

-(void)getRemoveCartItemResponse : (id)sender
{
    if ([sender responseCode] != 100)
    {
        [self showAlertWithMessage:[sender responseError]];
    }
    else
    {
        if([[[sender responseDict] valueForKey:kStatusCode] boolValue])
        {
            [self getCart];
        }
        else
        {
            NSString *errorMsg = [[[sender responseDict] valueForKey:kErrorData] valueForKey:kErrorMessage];
            [AZNotification showNotificationWithTitle: errorMsg controller: self notificationType:AZNotificationTypeError];
        }
    }
}

-(void)callMoveToWishList:(M_CartDetail *)cartDetail{
    if ([Global checkForConnection])
    {
        M_ProductList *model = cartDetail.productDetails;
        NSDictionary *params = @{
                                 @"companyid" : [ShareInfo sharedManagerInfo].companyId,
                                 @"personId" : [ShareInfo sharedManagerInfo].personId,
                                 @"ItemId": @(model.itemid),
                                 @"CartDetailId": @(cartDetail.cartDetailId),
                                 MM_DistributorCustomerId: @([CartManager sharedObject].distributorCustomerId)
                                 };
        
        [[WebServiceConnector alloc] init:URLAddToWishList
                           withParameters:params
                               withObject:self
                             withSelector:@selector(getMoveToWishListResponse:)
                           forServiceType:@"JSON"
                           showDisplayMsg:WebServiceDialogMsg];
    }
    else
    {
        [AZNotification showNotificationWithTitle: Msg_Internet_Unavailable controller: self notificationType:AZNotificationTypeError];
    }
}

-(void)getMoveToWishListResponse:(id)sender{
    if ([sender responseCode] != 100)
    {
        [self showAlertWithMessage:[sender responseError]];
    }
    else
    {
        if([[[sender responseDict] valueForKey:kStatusCode] boolValue])
        {
            [self getCart];
        }
        else
        {
            NSString *errorMsg = [[[sender responseDict] valueForKey: kErrorData] valueForKey:kErrorMessage];
            [AZNotification showNotificationWithTitle:errorMsg controller: self notificationType:AZNotificationTypeError];
        }
    }
}

-(void)callUpdateQuantity:(M_CartDetail *)cartDetail newQuantity:(NSInteger)quantity{
    if ([Global checkForConnection])
    {
        NSDictionary *params = @{
                                 @"companyid" : [ShareInfo sharedManagerInfo].companyId,
                                 @"personId" : [ShareInfo sharedManagerInfo].personId,
                                 @"Quantity": @(quantity),
                                 @"CartDetailId": @(cartDetail.cartDetailId)
                                 };
        
        NSString *apiName = URLUpdateCartItemQuantity;
        [[WebServiceConnector alloc] init:apiName
                           withParameters:params
                               withObject:self
                             withSelector:@selector(getUpdateQuantityResponse:)
                           forServiceType:@"JSON"
                           showDisplayMsg:WebServiceDialogMsg];
    }
    else
    {
        [AZNotification showNotificationWithTitle: Msg_Internet_Unavailable controller: self notificationType:AZNotificationTypeError];
    }
}

-(void)getUpdateQuantityResponse:(id)sender{
    if ([sender responseCode] != 100)
    {
        [self showAlertWithMessage:[sender responseError]];
    }
    else
    {
        if([[[sender responseDict] valueForKey:kStatusCode] boolValue])
        {
            [self getCart];
        }
        else
        {
            NSString *errorMsg = [[[sender responseDict] valueForKey: kErrorData] valueForKey:kErrorMessage];
            [AZNotification showNotificationWithTitle:errorMsg controller: self notificationType:AZNotificationTypeError];
        }
    }
}

-(void)getCart{
    if([Global checkForConnection])
    {
        [[WebServiceConnector alloc] init: URLGetCart
                           withParameters: @{
                                             kPersonID : [ShareInfo sharedManagerInfo].personId,
                                             kCompanyID : [ShareInfo sharedManagerInfo].companyId,
                                             MM_DistributorId : @([CartManager sharedObject].distributorId),
                                             MM_CustomerId : @([CartManager sharedObject].customerId),
                                             MM_DistributorCustomerId : @([CartManager sharedObject].distributorCustomerId),
                                             }
                               withObject:self
                             withSelector:@selector(getCartResponse:)
                           forServiceType:@"JSON"
                           showDisplayMsg:WebServiceDialogMsg];
    }
    else
    {
        [AZNotification showNotificationWithTitle: Msg_Internet_Unavailable controller: self notificationType:AZNotificationTypeError];
    }
}

-(void)getCartResponse : (id)sender{
    
    _bottomButtonsContainer.hidden = YES;
    _tblView.hidden = YES;
    
    if ([sender responseCode] != 100)
    {
        [self showAlertWithMessage:[sender responseError]];
    }
    else
    {
        if([[[sender responseDict] valueForKey:kStatusCode] boolValue])
        {
            _cartData = [[sender responseArray] firstObject];
            
            if(_cartData.expectedDeliveryDate != nil && _cartData.expectedDeliveryDate.length != 0){
                NSDate *dt = [Global getDateFromString:_cartData.expectedDeliveryDate formatter:@"dd-MM-yyyy"];
                if(dt != nil){
                    _selectedExpectedDeliveryDate = [Global getDateFromString:_cartData.expectedDeliveryDate formatter:@"dd-MM-yyyy"];
                }
            }
            //TEMPORARY
//            _cartData.supplierName = @"";
//            _cartData.orderAchievementName = @"";
//            _cartData.dispatchTypeName = @"";
//            _cartData.freight = @"";
            
            if(_cartData.supplierId > 0){
                _selectedDistributor = [[M_DistributorList alloc]
                                        initWithDictionary: @{
                                                              @"DistributorName" : _cartData.supplierName,
                                                              @"DistributorID" : @(_cartData.supplierId)
                                                              }
                                        ];
            }
            
            if(_cartData.orderAchievementID > 0){
                _selectedOrderAchievement = [[M_OrderAchievement alloc]
                                             initWithDictionary:@{
                                                                  @"orderachievement" : _cartData.orderAchievementName,
                                                                  @"orderachievementid" : [@(_cartData.orderAchievementID) stringValue]
                                                                  }
                                             ];
            }
            
            if(_cartData.dispatchTypeId > 0){
                _selectedDispatchType = [[M_DispatchType alloc]
                                         initWithDictionary:@{
                                                              @"DispatchTypeId" : @(_cartData.dispatchTypeId),
                                                              @"DispatchTypeName" : _cartData.dispatchTypeName,
                                                              @"FreightApplicable" : @(_cartData.freightApplicable)
                                                              }
                                         ];
            }
            
            if(_cartData.freight){
                NSDictionary *selectedFreight = nil;
                for(NSDictionary *freight in _arrFreight){
                    if([freight[@"value"] isEqualToString:_cartData.freight]){
                        selectedFreight = freight;
                        break;
                    }
                }
                _selectedFreight = selectedFreight;
            }
            
            _lblOrderTotal.text = [NSString stringWithFormat:@"%.2f", _cartData.cartAmountDetail.finalAmount];
            
            [self setInitialCartDiscount];
            
            [_tblView reloadData];
            
            M_CartCount *cartCount = [[M_CartCount alloc] initWithDictionary:@{@"CartCount":@(_cartData.noOfProducts)}];
            [[CartManager sharedObject] setCartCount:cartCount];
        }
        else
        {
            _cartData = nil;
            NSString *errorMsg = [[[sender responseDict] valueForKey:kErrorData] valueForKey:kErrorMessage];
            if([errorMsg isEqualToString:@"Cart is Empty"] == NO){
                [AZNotification showNotificationWithTitle: errorMsg controller: self notificationType:AZNotificationTypeError];
            }
        }
    }
    
    if(_cartData == nil){
        [_bottomButtonsContainer setHidden:YES];
        [_tblView setHidden:YES];
        [_imgCartEmpty setHidden:NO];
        [_emptyCartButtonsContainer setHidden:NO];
    }else{
        [_bottomButtonsContainer setHidden:NO];
        [_tblView setHidden:NO];
        [_imgCartEmpty setHidden:YES];
        [_emptyCartButtonsContainer setHidden:YES];
    }
    
    [self manageFormConfiguration];
    [self.tblView reloadData];
}

-(void)placeOrder{
    if ([Global checkForConnection])
    {
        
        NSString *latitude = [LocationManager sharedManagerInfo].lattitude;
        NSString *longitude = [LocationManager sharedManagerInfo].longitude;
        
        NSString *checkInID = @"";
        if([[CartManager sharedObject].orderType isEqualToString:kOrderTypeCheckIn]){
            checkInID = [[NSUserDefaults standardUserDefaults] objectForKey:kCheckedInID];
        }
        
        NSDictionary *params = @{
                                 @"companyid" : [ShareInfo sharedManagerInfo].companyId,
                                 @"personId" : [ShareInfo sharedManagerInfo].personId,
                                 MM_DistributorCustomerId: @([CartManager sharedObject].distributorCustomerId),
                                 @"Longitude": longitude,
                                 @"Latitude": latitude,
                                 @"checkinid": checkInID,
                                 @"Type": [CartManager sharedObject].type,
                                 @"OrderType": [CartManager sharedObject].orderType,
                                 @"DeviceType": @"IOS",
                                 @"IsAssetOrder": @NO,
                                 @"ShippingAddress": [NSNull null],
                                 @"remarks": _remarks
                                 };
        
        [[WebServiceConnector alloc] init:URLPlaceOrder
                           withParameters:params
                               withObject:self
                             withSelector:@selector(getPlaceOrderResponse:)
                           forServiceType:@"JSON"
                           showDisplayMsg:WebServiceDialogMsg];
    }
    else
    {
        [AZNotification showNotificationWithTitle: Msg_Internet_Unavailable controller: self notificationType:AZNotificationTypeError];
    }
}

-(void)getPlaceOrderResponse:(id)sender{
    NSLog(@"getPlaceOrderResponse: %@", [sender responseDict]);
    
    if ([sender responseCode] != 100)
    {
        [self showAlertWithMessage:[sender responseError]];
    }
    else
    {
        if([[[sender responseDict] valueForKey:kStatusCode] boolValue])
        {
            [_bottomButtonsContainer setUserInteractionEnabled:NO];
            [AZNotification showNotificationWithTitle:@"Order Placed Successfully." controller: self notificationType:AZNotificationTypeSuccess];
            M_CartCount *cartCount = [[M_CartCount alloc] initWithDictionary:@{ @"CartCount" : @0 }];
            [[CartManager sharedObject] setCartCount:cartCount];
            [Global delayCallback:^{
                [self.navigationController popViewControllerAnimated:YES];
            } forTotalSeconds:3];
        }
        else
        {
            NSString *errorMsg = [[[sender responseDict] valueForKey: kErrorData] valueForKey:kErrorMessage];
            [AZNotification showNotificationWithTitle:errorMsg controller: self notificationType:AZNotificationTypeError];
        }
    }
}

#pragma mark -

#pragma mark - UITextField & TextView

- (IBAction)discountInputDidChange:(UITextField *)sender {
    _discountInput = [sender.text floatValue];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSInteger existingDotsCount = [[textField.text componentsSeparatedByString:@"."] count] - 1;
    if(existingDotsCount > 0 && [string isEqualToString:@"."]){
        return NO;
    }
    
    NSString *strNewDiscountValue = [NSString stringWithFormat:@"%@%@", textField.text, string];
    CGFloat newDiscountValue = [strNewDiscountValue floatValue];
    if(_discountIn == DiscountInPercentage){
        return newDiscountValue <= 99.99;
    }else if(_discountIn == DiscountInAmount){
        return newDiscountValue < (_cartData.cartAmountDetail.totalAmount - _cartData.cartAmountDetail.totlItemDiscount);
    }
    
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if([textField.text floatValue] == 0){
        textField.text = @"";
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    if(textField.text.length == 0){
        textField.text = @"0.00";
    }
    
    BOOL isDiscountChanged = NO;
    if(_discountIn == DiscountInPercentage){
        isDiscountChanged = _discountInput != _cartData.salesPersonDiscountPerc;
    }else{
        isDiscountChanged = _discountInput != _cartData.salesPersonDiscountAmt;
    }
    
    if(isDiscountChanged == NO){
        return;
    }
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"Are you sure to update discount on cart?" preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self updateCartOrderDetail];
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self setInitialCartDiscount];
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)textViewDidChange:(UITextView *)textView{
    _remarks = textView.text;
}

#pragma mark -

-(BOOL)isValidData{
    
    NSString *errMsg = @"";
    
    CartOtherDetailsCell *cell = [self.tblView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:OtherDetailsSection]];
    if (cell.isHidden) {
        return 1;
    }
    else {
//        if (!cell.viewDistributor.isHidden) {
//        }
//        if (!cell.viewExpectedDeliveryDate.isHidden) {
//        }
        if (!cell.viewFreight.isHidden) {
            
            if(_selectedDispatchType != nil){
                if(_selectedDispatchType.freightApplicable && _selectedFreight == nil){
                    errMsg = @"Please select Freight.";
                }
            }
        }
        if (!cell.viewDispatchMode.isHidden) {
            
            if(_selectedDispatchType == nil){
                errMsg = @"Please select Dispatch Mode.";
            }
        }
        if (!cell.viewOrderAchievement.isHidden) {
            
            if(_selectedOrderAchievement == nil){
                errMsg = @"Please select Order Achievement";
            }
        }
        
        if(errMsg.length == 0){
            if([self isOtherDetailSaveButtonVisibile]){
                errMsg = @"Save other details first to continue.";
            }
        }
        
    }
    
    if(errMsg.length > 0){
        [AZNotification showNotificationWithTitle:errMsg controller: self notificationType:AZNotificationTypeError];
    }
    
    return errMsg.length == 0;
}

@end
