//
//  ProductDetailsVC.m
//  Meril
//
//  Created by Inspiro Infotech on 24/01/20.
//  Copyright © 2020 Inspiro Infotech. All rights reserved.
//

#import "ProductDetailsVC.h"

#import "ProductDetailsTaxBannerCell.h"
#import "ProductDetailImagesListCell.h"
#import "ProductDetailNameAndPriceCell.h"
#import "ProductDetailSchemesHeaderCell.h"
#import "ProductDetailSchemesListCell.h"
#import "ProductDetailSizeListCell.h"
#import "ProductDetailDescriptionCell.h"
#import "ProductDetailSpecificationListCell.h"
#import "ProductDetailSimilarProductsListCell.h"
#import "ProductDetailCatalogueDetailListCell.h"
#import "ProductDetailExchangePolicyHeaderCell.h"
#import "ProductDetailExchangePolicyListCell.h"
#import "ProductDetailSelectableSpecificationListCell.h"

#import "M_ProductDetails.h"
#import "M_ProductScheme.h"
#import "M_ProductExchangePolicy.h"

#import "ProductImagesSliderVC.h"
#import "FormattedStringVC.h"
#import "AddToCartPopUp.h"

#import "CartManager.h"

#import "MWPhotoBrowser.h"
#import "MWPhoto.h"

typedef enum
{
    TaxBannerSection = 0,
    ImagesSection = 1,
    NameAndPriceSection = 2,
    SchemesSection = 3,
    CatalogueDetailsSection = 4,
    SizeSection = 5,
    SelectableSpecSection = 6,
    DescriptionSection = 7,
    SpecsSection = 8,
    SimilarProductsSection = 9,
    ExchangePolicySection = 10,
    TotalSections = 11
}Sections;

@interface ProductDetailsVC ()<UITableViewDataSource, UITableViewDelegate, CartCountDelegate, MWPhotoBrowserDelegate>

@property (nonatomic, retain) NSMutableArray *arrMWProductImages;
@property (nonatomic, retain) NSMutableArray *arrProductImages;
@property (nonatomic, retain) NSMutableArray *arrProductSizes;
@property (nonatomic, retain) NSMutableArray *arrProductSpecs;
@property (nonatomic, retain) NSMutableArray *arrSimilarProducts;
@property (nonatomic, retain) NSMutableArray *arrCatalogItems;
@property (nonatomic, retain) M_ProductDetails *productDetails;
@property (nonatomic, retain) NSMutableArray *arrSelectableSpecCopy;
@property (nonatomic, retain) NSMutableArray *arrSelectableSpec;

@property (nonatomic, retain) AddToCartPopUp *addToCartPopup;

@property (nonatomic, retain) UIBarButtonItem *btnGotoCart;

@end

@implementation ProductDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupLayout];
    
    [self callServices];
    
    [self disableAddToCartButton];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [[CartManager sharedObject] refreshCartCount];
    [CartManager sharedObject].delegate = self;
}

-(void)setupLayout{
    
    self.title = _selectedProduct.brandname;
    
    _btnGotoCart = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_nav_cart"] style:UIBarButtonItemStylePlain target:self action:@selector(btnGoToCartClicked:)];
    self.navigationItem.rightBarButtonItems = @[_btnGotoCart];
    
    _btnWishlistContainer.layer.masksToBounds = YES;
    _btnWishlistContainer.layer.cornerRadius = 4;
    _btnWishlistContainer.layer.borderWidth = 1;
    
    _btnAddToBagContainer.layer.masksToBounds = YES;
    _btnAddToBagContainer.layer.cornerRadius = 4;
    
    [self setWishlistButtonText];
    
    if(_selectedCartItem){
        _lblBtnAddUpdateCart.text = @"UPDATE CART";
    }else{
        _lblBtnAddUpdateCart.text = @"ADD TO CART";
    }
}

-(void)setWishlistButtonText{
    if(_selectedProduct.iswishlisetd){
        UIColor *wishlistedColor = [_btnWishlistHeart selectedColor];
        _lblBtnWishList.text = @"WISHLISTED";
        _lblBtnWishList.textColor = wishlistedColor;
        _btnWishlistContainer.layer.borderColor = wishlistedColor.CGColor;
        [_btnWishlistHeart setSelected:YES];
        
    }else{
        _lblBtnWishList.text = @"WISHLIST";
        _lblBtnWishList.textColor = [UIColor blackColor];
        _btnWishlistContainer.layer.borderColor = [UIColor blackColor].CGColor;
        [_btnWishlistHeart setSelected:NO];
    }
    [_btnWishlistHeart animateSelected];
}

-(void)callServices{
    
    _arrProductImages = [NSMutableArray new];
    NSString *strUrl = [NSString stringWithFormat:@"%@/%@", MM_ProductsImagePath, [_selectedProduct.coverimage stringByReplacingOccurrencesOfString:@" " withString:@"%20"]];
    NSURL *imgUrl = [NSURL URLWithString:strUrl];
    [_arrProductImages addObject:imgUrl];
    
    
    _arrMWProductImages = [NSMutableArray new];
    MWPhoto *photo = [MWPhoto photoWithURL:imgUrl];
    [_arrMWProductImages addObject:photo];
    
    //TEMPORARY
//    for (int i = 0; i<40; i++) {
//        MWPhoto *tmp = [MWPhoto photoWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://loremflickr.com/37%d/64%d", i, i]]];
//        [_arrMWProductImages addObject:tmp];
//    }
    //TEMPORARY
    
    [self getProductImages];
//    [self getProductSize];
    [self getSelectableSpecs];
    [self getProductSpecs];
    [self getSimilarProducts];
    if(_selectedProduct.iscatalogue){
        [self getCatalogItems];
    }
    [self getProductDetails];
    
    /*#warning REMOVE THIS BEFORE GOING TO PRODUCTION
    
    NSDictionary *scheme = @{
                             @"description" : @"10% discount on Axis Cards",
                             @"scheme" : @"Axis Card",
                             @"schemedetail" : @"<b>AXIS SCHEME DETAILS</>"
                             };
    NSDictionary *exchangePolicy = @{
                                     @"title": @"30 day return",
                                     @"description": @"bhsgdkjashdkj"
                                     };
    _productDetails = [[M_ProductDetails alloc]
                       initWithDictionary:@{
                                            @"maxqtyallowed": @10,
                                            @"priceinclusivetax": @(true),
                                            @"availableschemes": @[scheme, scheme, scheme],
                                            @"exchangepolicy": @[exchangePolicy, exchangePolicy, exchangePolicy]
                                            }];*/
}

#pragma mark - Service Call Handling

-(void)getProductImages
{
    if ([Global checkForConnection])
    {
        NSDictionary *params = @{
                                 @"itemID" : @(_selectedProduct.itemid)
                                 };
//#warning REMOVE THIS BEFORE GOING TO PRODUCTION
//        params = @{
//                   @"itemID" : @(20027)
//                   };
        
        [[WebServiceConnector alloc] init:URLGetProductImages
                           withParameters:params
                               withObject:self
                             withSelector:@selector(getProductImagesResponse:)
                           forServiceType:@"JSON"
                           showDisplayMsg:nil];
    }
    else
    {
        [AZNotification showNotificationWithTitle: Msg_Internet_Unavailable controller: self notificationType:AZNotificationTypeError];
    }
}

-(void)getProductImagesResponse : (id)sender
{
    NSLog(@"getProductImagesResponse : %@", [sender responseDict]);
    if ([sender responseCode] != 100)
    {
        [self showAlertWithMessage:[sender responseError]];
    }
    else
    {
        if([[[sender responseDict] valueForKey:kStatusCode] boolValue])
        {
            
            NSArray *arrImages = [[sender responseDict] objectForKey:kSuccessData];
            
            for(NSString *imageName in arrImages){
                
                NSString *strUrl = [NSString stringWithFormat:@"%@/%@", MM_ProductsImagePath, [imageName stringByReplacingOccurrencesOfString:@" " withString:@"%20"]];
                NSURL *imgUrl = [NSURL URLWithString:strUrl];
                [_arrProductImages addObject:imgUrl];
                
                MWPhoto *photo = [MWPhoto photoWithURL:imgUrl];
                [_arrMWProductImages addObject:photo];
                
            }
        }
        else
        {
            NSString *errorMsg = [[[sender responseDict] valueForKey: kErrorData] valueForKey:kErrorMessage];
            [AZNotification showNotificationWithTitle:errorMsg controller: self notificationType:AZNotificationTypeError];
        }
    }
    [_tblView reloadData];
}

//-(void)getProductSize
//{
//    if ([Global checkForConnection])
//    {
//        NSDictionary *params = @{
//                                 @"itemID" : @(_selectedProduct.itemid)
//                                 };
//#warning REMOVE THIS BEFORE GOING TO PRODUCTION
//        params = @{
//                   @"itemID" : @(2038)
//                   };
//
//        [[WebServiceConnector alloc] init:URLGetProductSize
//                           withParameters:params
//                               withObject:self
//                             withSelector:@selector(getProductSizeResponse:)
//                           forServiceType:@"JSON"
//                           showDisplayMsg:nil];
//    }
//    else
//    {
//        [AZNotification showNotificationWithTitle: Msg_Internet_Unavailable controller: self notificationType:AZNotificationTypeError];
//    }
//}
//
//-(void)getProductSizeResponse : (id)sender
//{
//    if ([sender responseCode] != 100)
//    {
//        [self showAlertWithMessage:[sender responseError]];
//    }
//    else
//    {
//        if([[[sender responseDict] valueForKey:kStatusCode] boolValue])
//        {
//            _arrProductSizes = [NSMutableArray arrayWithArray:[sender responseArray]];
//        }
//        else
//        {
//            NSString *errorMsg = [[[sender responseDict] valueForKey: kErrorData] valueForKey:kErrorMessage];
//            [AZNotification showNotificationWithTitle:errorMsg controller: self notificationType:AZNotificationTypeError];
//        }
//    }
//    [_tblView reloadData];
//}

-(void)getProductSpecs
{
    if ([Global checkForConnection])
    {
        NSDictionary *params = @{
                                 @"itemID" : @(_selectedProduct.itemid)
                                 };
//#warning REMOVE THIS BEFORE GOING TO PRODUCTION
//        params = @{
//                   @"itemID" : @(2038)
//                   };
        
        [[WebServiceConnector alloc] init:URLGetProductSpec
                           withParameters:params
                               withObject:self
                             withSelector:@selector(getProductSpecsResponse:)
                           forServiceType:@"JSON"
                           showDisplayMsg:nil];
    }
    else
    {
        [AZNotification showNotificationWithTitle: Msg_Internet_Unavailable controller: self notificationType:AZNotificationTypeError];
    }
}

-(void)getProductSpecsResponse : (id)sender
{
    NSLog(@"getProductSpecsResponse : %@", [sender responseDict]);
    if ([sender responseCode] != 100)
    {
        [self showAlertWithMessage:[sender responseError]];
    }
    else
    {
        if([[[sender responseDict] valueForKey:kStatusCode] boolValue])
        {
            _arrProductSpecs = [NSMutableArray arrayWithArray:[sender responseArray]];
        }
        else
        {
            NSString *errorMsg = [[[sender responseDict] valueForKey: kErrorData] valueForKey:kErrorMessage];
            [AZNotification showNotificationWithTitle:errorMsg controller: self notificationType:AZNotificationTypeError];
        }
    }
    [_tblView reloadData];
}

-(void)getSimilarProducts
{
    if ([Global checkForConnection])
    {
        
        NSNumber *itemId = @(_selectedProduct.itemid);
//        #warning REMOVE THIS BEFORE GOING TO PRODUCTION
//        itemId = @(14762);
        
        NSDictionary *params = @{
                                 @"companyid": [ShareInfo sharedManagerInfo].companyId,
                                 @"numberofproductloadperpage": @(10),
                                 @"userid": [ShareInfo sharedManagerInfo].personId,
                                 @"pagenumber": @(1),
                                 @"itemid": itemId
                                 };
        
        [[WebServiceConnector alloc] init:URLGetSimilarProductList
                           withParameters:params
                               withObject:self
                             withSelector:@selector(getSimilarProductsResponse:)
                           forServiceType:@"JSON"
                           showDisplayMsg:nil];
    }
    else
    {
        [AZNotification showNotificationWithTitle: Msg_Internet_Unavailable controller: self notificationType:AZNotificationTypeError];
    }
}

-(void)getSimilarProductsResponse : (id)sender
{
    NSLog(@"getSimilarProductsResponse : %@", [sender responseDict]);
    if ([sender responseCode] != 100)
    {
        [self showAlertWithMessage:[sender responseError]];
    }
    else
    {
        if([[[sender responseDict] valueForKey:kStatusCode] boolValue])
        {
            _arrSimilarProducts = [NSMutableArray arrayWithArray:[sender responseArray]];
        }
        else
        {
            NSString *errorMsg = [[[sender responseDict] valueForKey: kErrorData] valueForKey:kErrorMessage];
            [AZNotification showNotificationWithTitle:errorMsg controller: self notificationType:AZNotificationTypeError];
        }
    }
    [_tblView reloadData];
}

-(void)getCatalogItems
{
    if ([Global checkForConnection])
    {
        
        NSNumber *itemId = @(_selectedProduct.itemid);
//#warning REMOVE THIS BEFORE GOING TO PRODUCTION
//        itemId = @(20017);
        
        NSDictionary *params = @{
                                 @"companyid": [ShareInfo sharedManagerInfo].companyId,
                                 @"userid": [ShareInfo sharedManagerInfo].personId,
                                 @"itemid": itemId
                                 };
        
        [[WebServiceConnector alloc] init:URLGetOrderCatalogueItemData
                           withParameters:params
                               withObject:self
                             withSelector:@selector(getCatalogItemsResponse:)
                           forServiceType:@"JSON"
                           showDisplayMsg:nil];
    }
    else
    {
        [AZNotification showNotificationWithTitle: Msg_Internet_Unavailable controller: self notificationType:AZNotificationTypeError];
    }
}

-(void)getCatalogItemsResponse : (id)sender
{
    NSLog(@"getCatalogItemsResponse : %@", [sender responseDict]);
    if ([sender responseCode] != 100)
    {
        [self showAlertWithMessage:[sender responseError]];
    }
    else
    {
        if([[[sender responseDict] valueForKey:kStatusCode] boolValue])
        {
            _arrCatalogItems = [NSMutableArray arrayWithArray:[sender responseArray]];
        }
        else
        {
            NSString *errorMsg = [[[sender responseDict] valueForKey: kErrorData] valueForKey:kErrorMessage];
            [AZNotification showNotificationWithTitle:errorMsg controller: self notificationType:AZNotificationTypeError];
        }
    }
    [_tblView reloadData];
}

-(void)getProductDetails{
    if ([Global checkForConnection])
    {
        
        NSNumber *itemId = @(_selectedProduct.itemid);
//#warning REMOVE THIS BEFORE GOING TO PRODUCTION
//        itemId = @(20017);
        
        NSDictionary *params = @{
                                 @"itemid": itemId
                                 };
        
        [[WebServiceConnector alloc] init:URLGetProductDetail
                           withParameters:params
                               withObject:self
                             withSelector:@selector(getProductDetailsResponse:)
                           forServiceType:@"JSON"
                           showDisplayMsg:nil];
    }
    else
    {
        [AZNotification showNotificationWithTitle: Msg_Internet_Unavailable controller: self notificationType:AZNotificationTypeError];
    }
}

-(void)getProductDetailsResponse : (id)sender{
    NSLog(@"getProductDetailsResponse : %@", [sender responseDict]);
    if ([sender responseCode] != 100)
    {
        [self showAlertWithMessage:[sender responseError]];
    }
    else
    {
        if([[[sender responseDict] valueForKey:kStatusCode] boolValue])
        {
//            NSDictionary *responseDict = [sender responseDict];
//            _maxQuantity = [NSString stringWithFormat:@"%ld", (long)[responseDict[@"maxqtyallowed"] integerValue]];
//            _isPriceInclusiveTax = [responseDict[@"priceinclusivetax"] boolValue];
//            NSArray *arrSchemes = [[sender responseArray] firstObject];
//            NSArray *arrExchangePolicy = [[sender responseArray] lastObject];
//            _arrSchemes = [NSMutableArray arrayWithArray:arrSchemes];
//            _arrExchangePolicy = [NSMutableArray arrayWithArray:arrExchangePolicy];
            _productDetails = [[sender responseArray] firstObject];
        }
        else
        {
            NSString *errorMsg = [[[sender responseDict] valueForKey: kErrorData] valueForKey:kErrorMessage];
            [AZNotification showNotificationWithTitle:errorMsg controller: self notificationType:AZNotificationTypeError];
        }
    }
    [_tblView reloadData];
}

-(void)getSelectableSpecs
{
    if ([Global checkForConnection])
    {
        NSNumber *itemId = @(_selectedProduct.itemid);
//#warning REMOVE THIS BEFORE GOING TO PRODUCTION
//        itemId = @(21133);
        NSDictionary *params = @{
                                 @"itemID" : itemId,
                                 @"PersonId" : [ShareInfo sharedManagerInfo].personId,
                                 @"CompanyId" : [ShareInfo sharedManagerInfo].companyId,
                                 };
        
        [[WebServiceConnector alloc] init:URLGetSelectableSpecs
                           withParameters:params
                               withObject:self
                             withSelector:@selector(getSelectableSpecsResponse:)
                           forServiceType:@"JSON"
                           showDisplayMsg:nil];
    }
    else
    {
        [AZNotification showNotificationWithTitle: Msg_Internet_Unavailable controller: self notificationType:AZNotificationTypeError];
    }
}

-(void)getSelectableSpecsResponse : (id)sender
{
    NSLog(@"getSelectableSpecsResponse : %@", [sender responseDict]);
    if ([sender responseCode] != 100)
    {
        [self showAlertWithMessage:[sender responseError]];
    }
    else
    {
        if([[[sender responseDict] valueForKey:kStatusCode] boolValue])
        {
            _arrSelectableSpec = [NSMutableArray arrayWithArray:[sender responseArray]];
            _arrSelectableSpecCopy = [_arrSelectableSpec mutableCopy];
        }
        else
        {
            NSString *errorMsg = [[[sender responseDict] valueForKey: kErrorData] valueForKey:kErrorMessage];
            [AZNotification showNotificationWithTitle:errorMsg controller: self notificationType:AZNotificationTypeError];
        }
    }
    [self enableAddToCartButton];
    [_tblView reloadData];
}

-(void)callAddOrRemoveWishList{
    if ([Global checkForConnection])
    {
        NSDictionary *params = @{
                                 @"companyid" : [ShareInfo sharedManagerInfo].companyId,
                                 @"personId" : [ShareInfo sharedManagerInfo].personId,
                                 @"ItemId": @(_selectedProduct.itemid)
                                 };
        
        NSString *apiName = URLAddToWishList;
        if(_selectedProduct.iswishlisetd){
            apiName = URLRemoveFromWishList;
        }
        
        [[WebServiceConnector alloc] init:apiName
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
    NSLog(@"getCallAddOrRemoveWishListResponse : %@", [sender responseDict]);
    if ([sender responseCode] != 100)
    {
        [self showAlertWithMessage:[sender responseError]];
    }
    else
    {
        if([[[sender responseDict] valueForKey:kStatusCode] boolValue])
        {
            _selectedProduct.iswishlisetd = !_selectedProduct.iswishlisetd;
        }
        else
        {
            NSString *errorMsg = [[[sender responseDict] valueForKey: kErrorData] valueForKey:kErrorMessage];
            [AZNotification showNotificationWithTitle:errorMsg controller: self notificationType:AZNotificationTypeError];
        }
    }
    
    [self setWishlistButtonText];
}

#pragma mark -

#pragma mark - TableView

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    switch (section) {
        case SchemesSection:
            {
                return [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ProductDetailSchemesHeaderCell class])];
            }
            break;
        case ExchangePolicySection:
        {
            return [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ProductDetailExchangePolicyHeaderCell class])];
        }
            break;
        default:
            break;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    switch (section) {
        case SchemesSection:
        {
            if(_productDetails.availableschemes.count > 0){
                return 28;
            }
        }
            break;
        case ExchangePolicySection:
        {
            if(_productDetails.exchangepolicy.count > 0){
                return 28;
            }
        }
            break;
        default:
            break;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        
        case TaxBannerSection:{
            ProductDetailsTaxBannerCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ProductDetailsTaxBannerCell class]) forIndexPath:indexPath];
            
            NSString *inclusiveOrExclusive = _productDetails.priceinclusivetax ? @"inclusive" : @"exclusive";
            cell.lblCartTaxBanner.text = [NSString stringWithFormat:@"Price %@ of taxes", inclusiveOrExclusive];
            
            return cell;
        }
            break;
        case ImagesSection:{
            ProductDetailImagesListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ProductDetailImagesListCell class]) forIndexPath:indexPath];
            [cell setArrImages:_arrProductImages];
            
            cell.selectorObject = self;
            cell.onPressImage = @selector(productImagePressed:);
            
            return cell;
        }
            break;
            
        case NameAndPriceSection:{
            ProductDetailNameAndPriceCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ProductDetailNameAndPriceCell class]) forIndexPath:indexPath];
            [cell setSelectedProduct:_selectedProduct];
            return cell;
        }
            break;
        case SchemesSection:{
            ProductDetailSchemesListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ProductDetailSchemesListCell class]) forIndexPath:indexPath];
            [cell setScheme: _productDetails.availableschemes[indexPath.row]];
            return cell;
        }
            break;
        case CatalogueDetailsSection:{
            ProductDetailCatalogueDetailListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ProductDetailCatalogueDetailListCell class]) forIndexPath:indexPath];
            [cell setArrCatalogueItemsProducts:_arrCatalogItems];
            return cell;
        }
            break;
        case SizeSection:{
            ProductDetailSizeListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ProductDetailSizeListCell class]) forIndexPath:indexPath];
            [cell setArrSize:_arrProductSizes];
            return cell;
        }
            break;
        case SelectableSpecSection:{
            ProductDetailSelectableSpecificationListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ProductDetailSelectableSpecificationListCell class]) forIndexPath:indexPath];
            [cell setArrSelectableSpecs:_arrSelectableSpecCopy];
            [cell setArrPreSelectedSpecs:[NSMutableArray arrayWithArray:_selectedCartItem.productVariant]];
            return cell;
        }
            break;
        case DescriptionSection:{
            ProductDetailDescriptionCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ProductDetailDescriptionCell class]) forIndexPath:indexPath];
            [cell setSelectedProduct:_selectedProduct];
            return cell;
        }
            break;
            
        case SpecsSection:{
            ProductDetailSpecificationListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ProductDetailSpecificationListCell class]) forIndexPath:indexPath];
            [cell setArrSpecs:_arrProductSpecs];
            return cell;
        }
            break;
            
        case SimilarProductsSection:{
            ProductDetailSimilarProductsListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ProductDetailSimilarProductsListCell class]) forIndexPath:indexPath];
            [cell setArrSimilarProducts:_arrSimilarProducts];
            return cell;
        }
            break;
            
        case ExchangePolicySection:{
            ProductDetailExchangePolicyListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ProductDetailExchangePolicyListCell class]) forIndexPath:indexPath];
            [cell setExchangePolicy:_productDetails.exchangepolicy[indexPath.row]];
            return cell;
        }
            
        default:
            break;
    }
    return [UITableViewCell new];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case TaxBannerSection:
            return 0;//_productDetails != nil ? 31 : 0;
            break;
        case ImagesSection:
            return _arrProductImages.count > 0 ? 300 : 0;
            break;
        case SchemesSection:
            return 31;
            break;
        case CatalogueDetailsSection:
            if(!_selectedProduct.iscatalogue || _arrCatalogItems.count == 0){
                return 0;
            }else{
                return 282;
            }
        case SizeSection:
            return _arrProductSizes.count > 0 ? 110 : 0;
            break;
        case SelectableSpecSection:
            return _arrSelectableSpecCopy.count > 0 ? 93 : 0;
            break;
        case DescriptionSection:
            if(_selectedProduct.shortdescription.length == 0 && _selectedProduct.longdescription.length == 0){
                return 0;
            }
            break;
        case SpecsSection:
            return _arrProductSpecs.count > 0 ? 83 : 0;
            break;
        case SimilarProductsSection:
            return _arrSimilarProducts.count > 0 ? 282 : 0;
            break;
        case ExchangePolicySection:
            return 31;
            break;
        default:
            break;
    }
    return UITableViewAutomaticDimension;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case SchemesSection:
            return _productDetails.availableschemes.count;
            break;
        case ExchangePolicySection:
            return _productDetails.exchangepolicy.count;
            break;
        default:
            break;
    }
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return TotalSections;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    CGFloat height = 10;
    
    switch (section) {
        case ImagesSection || TaxBannerSection:
            height = 0;
            break;
        case SchemesSection:
            if(_productDetails.availableschemes.count == 0){
                height = 0;
            }
            break;
        case CatalogueDetailsSection:
            if(!_selectedProduct.iscatalogue || _arrCatalogItems.count == 0){
                return 0;
            }
            break;
        case SizeSection:
            if (_arrProductSizes.count == 0){
                height = 0;
            }
            break;
        case SelectableSpecSection:
            if(_arrSelectableSpecCopy.count == 0) {
                height = 0;
            }
            break;
        case DescriptionSection:
            if(_selectedProduct.shortdescription.length == 0 && _selectedProduct.longdescription.length == 0){
                height = 0;
            }
            break;
        case SpecsSection:
            if(_arrProductSpecs.count == 0) {
                height = 0;
            }
            break;
        case SimilarProductsSection:
            if(_arrSimilarProducts.count == 0) {
                height = 0;
            }
            break;
        case ExchangePolicySection:
            if(_productDetails.exchangepolicy.count == 0){
                height = 0;
            }
        default:
            break;
    }
    
    return height;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == SchemesSection){
        M_ProductScheme *scheme = _productDetails.availableschemes[indexPath.row];
        FormattedStringVC *vc = loadViewController(SB_Order, VC_FormattedString);
        
        vc.strTitle = scheme.scheme;
        
        NSString *str = [NSString stringWithFormat:@"%@<br/>%@", scheme.productSchemeDescription, scheme.schemedetail];
        NSAttributedString *attr = [[NSAttributedString alloc] initWithData:[str dataUsingEncoding:NSUTF8StringEncoding]
                                                                    options:@{
                                                                              NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
                                                                              NSCharacterEncodingDocumentAttribute: @(NSUTF8StringEncoding)
                                                                              }
                                                         documentAttributes:nil error:nil];
        
        vc.strAttributed = attr;
        
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if(indexPath.section == ExchangePolicySection){
        M_ProductExchangePolicy *exchangePolicy = _productDetails.exchangepolicy[indexPath.row];
        FormattedStringVC *vc = loadViewController(SB_Order, VC_FormattedString);
        
        vc.strTitle = exchangePolicy.title;
        
        NSString *str = [NSString stringWithFormat:@"%@", exchangePolicy.exchangePolicyDescription];
        NSAttributedString *attr = [[NSAttributedString alloc] initWithData:[str dataUsingEncoding:NSUTF8StringEncoding]
                                                                    options:@{
                                                                              NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
                                                                              NSCharacterEncodingDocumentAttribute: @(NSUTF8StringEncoding)
                                                                              }
                                                         documentAttributes:nil error:nil];
        
        vc.strAttributed = attr;
        
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(void)productImagePressed:(NSNumber *)index{
//    ProductImagesSliderVC *vc = loadViewController(SB_Order, VC_ProductImagesSlider);
//    vc.arrImageURLs = _arrProductImages;
//    [Global delayCallback:^{
//        [vc scrollToIndex:[index integerValue] animated:NO];
//    } forTotalSeconds:0.5];
//    [self.navigationController pushViewController:vc animated:YES];
//    vc.currentIndex = [index integerValue];
//    [vc setCurrentIndex:[index integerValue]];
    
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    // Set options
    browser.displayActionButton = NO; // Show action button to allow sharing, copying, etc (defaults to YES)
    browser.displayNavArrows = NO; // Whether to display left and right nav arrows on toolbar (defaults to NO)
    browser.displaySelectionButtons = NO; // Whether selection buttons are shown on each image (defaults to NO)
    browser.zoomPhotosToFill = NO; // Images that almost fill the screen will be initially zoomed to fill (defaults to YES)
    browser.alwaysShowControls = YES; // Allows to control whether the bars and controls are always visible or whether they fade away to show the photo full (defaults to NO)
    browser.enableGrid = YES; // Whether to allow the viewing of all the photo thumbnails on a grid (defaults to YES)
    browser.startOnGrid = NO; // Whether to start on the grid of thumbnails instead of the first photo (defaults to NO)
    browser.autoPlayOnAppear = NO; // Auto-play first video
    
    [browser setCurrentPhotoIndex:[index integerValue]];
    
    [self.navigationController pushViewController:browser animated:YES];
}

#pragma mark -

#pragma mark - MWPhotoBrowser

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return _arrMWProductImages.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < _arrMWProductImages.count) {
        return [_arrMWProductImages objectAtIndex:index];
    }
    return nil;
}

#pragma mark -

-(void)btnGoToCartClicked:(id)sender{
    [self.navigationController pushViewController:loadViewController(SB_Order, VC_Cart) animated:YES];
}

- (IBAction)btnWishlistClicked:(id)sender {
    [self callAddOrRemoveWishList];
}

- (IBAction)btnAddToCartClicked:(id)sender {
    if(_productDetails){
        if(_addToCartPopup == nil){
            _addToCartPopup = loadViewController(SB_Order, VC_AddToCartPopUp);
            _addToCartPopup.selectedProduct = _selectedProduct;
            _addToCartPopup.productDetails = _productDetails;
            _addToCartPopup.selectedCartItem = _selectedCartItem;
            _addToCartPopup.shouldRemoveFromWishlist = _cameFromWishList;
            _addToCartPopup.onFailure = ^{
                _arrSelectableSpecCopy = [_arrSelectableSpec mutableCopy];
                [_tblView reloadData];
            };
            _addToCartPopup.onSuccess = ^{
                [_tblView reloadData];
                [self setWishlistButtonText];
            };
            _addToCartPopup.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        }
        _addToCartPopup.arrSelectedSpecs = _arrSelectableSpecCopy;
        [self presentViewController:_addToCartPopup animated:YES completion:nil];
    }
}

#pragma mark - Delegate

-(void)onRefreshCartCount:(NSInteger)cartCount{
    [_btnGotoCart setBadgeValue:[NSString stringWithFormat:@"%ld", (long)cartCount]];
    [_btnGotoCart setBadgeOriginY:0];
}

#pragma mark -

-(void)enableAddToCartButton{
    [_btnAddToBagContainer setAlpha:1];
    [_btnAddToBagContainer setUserInteractionEnabled:YES];
}

-(void)disableAddToCartButton{
    [_btnAddToBagContainer setAlpha:0.3];
    [_btnAddToBagContainer setUserInteractionEnabled:NO];
}

@end
