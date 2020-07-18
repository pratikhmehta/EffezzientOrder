//
//  InstantOrderEntryVC.m
//  Meril
//
//  Created by Inspiro Infotech on 26/06/20.
//  Copyright © 2020 Inspiro Infotech. All rights reserved.
//

#import "InstantOrderEntryVC.h"
#import "M_ProductList.h"
#import "M_ProductSelectableSpec.h"
#import "M_CartData.h"
#import "M_CartDetail.h"
#import "CartManager.h"
#import "M_FilterValues.h"

@interface InstantOrderEntryVC () <UITextFieldDelegate, CartCountDelegate, UISearchBarDelegate>
{
    NSMutableArray *arrProducts, *arrCartProducts, *arrSelectedProducts;
}

@property (nonatomic) NSInteger currentPageNumber;
@property (nonatomic) NSInteger totalPage;
@property (nonatomic) NSInteger totalProducts;
@property (nonatomic, retain) UIBarButtonItem *btnSearch, *btnGotoCart;
@property (nonatomic) BOOL isSearchBarVisible;
@property (nonatomic, retain) NSString *searchTerm;

@end

@implementation InstantOrderEntryVC
@synthesize arrSelectedFilter;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Products";
    
    _btnSearch = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"img_search_icon_white"] style:UIBarButtonItemStylePlain target:self action:@selector(btnSearchClicked:)];
    _btnGotoCart = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_nav_cart"] style:UIBarButtonItemStylePlain target:self action:@selector(btnGoToCartClicked:)];
    self.navigationItem.rightBarButtonItems = @[_btnGotoCart, _btnSearch];
    
    
    _heightOfSearchBar.constant = 0;
    _txtSearch.delegate = self;
    _searchTerm = @"";
}

-(void)viewDidAppear:(BOOL)animated {
    [[CartManager sharedObject] refreshCartCount];
    [CartManager sharedObject].delegate = self;
    
    [self reloadProducts];
}

-(void)btnGoToCartClicked:(id)sender{
    [self.navigationController pushViewController:loadViewController(SB_Order, VC_Cart) animated:YES];
}

-(void)onRefreshCartCount:(NSInteger)cartCount{
    [_btnGotoCart setBadgeValue:[NSString stringWithFormat:@"%ld", (long)cartCount]];
    [_btnGotoCart setBadgeOriginY:0];
}

-(void)reloadProducts {
    arrProducts = [NSMutableArray new];
    arrCartProducts = [NSMutableArray new];
    arrSelectedProducts = [NSMutableArray new];
    _currentPageNumber = 1;
    [self getProducts];
}

-(void)getProducts
{
    if ([Global checkForConnection])
    {
        NSArray *arrAppliedFilters = [arrSelectedFilter valueForKey:@"toDictionary"];
        if(arrAppliedFilters.count == 0){
            arrAppliedFilters = @[];
        }
        NSDictionary *params = @{
                                 @"companyid" : [ShareInfo sharedManagerInfo].companyId,
                                 @"userid" : [ShareInfo sharedManagerInfo].personId,
                                 @"pagenumber": @(_currentPageNumber),
                                 @"searchstring": _searchTerm,
                                 @"selectedValues" : arrAppliedFilters,
                                 @"wishlistedonly": @(false),
                                 @"sortorder" : @"desc",
                                 @"sortcolumn" : @"itemid"
                                 };
        
        [[WebServiceConnector alloc] init:URLGetProductList
                           withParameters:params
                               withObject:self
                             withSelector:@selector(getProductsResponse:)
                           forServiceType:@"JSON"
                           showDisplayMsg:WebServiceDialogMsg];
    }
    else
    {
        [AZNotification showNotificationWithTitle:Msg_Internet_Unavailable controller: self notificationType:AZNotificationTypeError];
    }
}

-(void)getProductsResponse : (id)sender
{
    if ([sender responseCode] != 100)
    {
        [self showAlertWithMessage:[sender responseError]];
    }
    else
    {
        if([[[sender responseDict] valueForKey:kStatusCode] boolValue])
        {
            _totalPage = [[[sender responseDict] objectForKey:@"pagecount"] integerValue];
            _totalProducts = [[[sender responseDict] objectForKey:@"totalcount"] integerValue];
            
            [arrProducts addObjectsFromArray:[sender responseArray]];
        }
        else
        {
            NSString *errorMsg = [[[sender responseDict] valueForKey: kErrorData] valueForKey:kErrorMessage];
            [AZNotification showNotificationWithTitle:errorMsg controller: self notificationType:AZNotificationTypeError];
        }
    }
    
    [_tblProducts reloadData];
    
//    if(arrProducts.count == 0){
//        [_tblProducts setHidden:YES];
//        [_imgNoDataFound setHidden:NO];
//    }else{
//        [_tblProducts setHidden:NO];
//        [_imgNoDataFound setHidden:YES];
//    }
}

#pragma mark - TextField Delegates -

- (IBAction)txtQuantityDidChange:(UITextField *)textField {

    M_ProductList *model = [arrProducts objectAtIndex:textField.tag];
    model.quantity = [textField.text integerValue];
    
    float price = model.offerprice;
    NSInteger qty = model.quantity;
    float amt = price * qty;
    model.totalAmount = amt;
    
    CustomTableViewCell *cell = [_tblProducts cellForRowAtIndexPath:[NSIndexPath indexPathForRow:textField.tag inSection:0]];
    cell.lblProductAmount.text = (model.totalAmount > 0) ? [NSString stringWithFormat:@"%0.2f", model.totalAmount] : @"0";
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    
    M_ProductList *model = [arrProducts objectAtIndex:textField.tag];
    M_CartDetail *detail = [[M_CartDetail alloc] init]; // WithDictionary:model.toDictionary
    
    if (model.quantity > 0) {
        
        detail.itemId = model.itemid;
        detail.discountAmount = 0;
        detail.discountPerc = 0;
        detail.itemTotalTaxPerc = 0;
        detail.itemTotalTaxValue = 0;
        detail.originalPrice = model.mrp;
        detail.productVariant = @[];
        detail.quantity = model.quantity;
        detail.sellingPrice = model.offerprice;
        detail.totalAmount = model.totalAmount;
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.ItemId == %d", model.itemid];
        NSArray *arrResult = [arrSelectedProducts filteredArrayUsingPredicate:predicate];
        
        NSMutableDictionary *dict = [detail.toDictionary mutableCopy];
        
        [dict removeObjectForKey:@"ProductVariantId"];
        
        if (arrResult.count == 1) {
            M_CartDetail *temp = arrResult.firstObject;
            [arrSelectedProducts replaceObjectAtIndex:[arrSelectedProducts indexOfObject:temp] withObject:dict];
        }
        else
            [arrSelectedProducts addObject:dict];
        
        NSArray *arrAmt = [arrSelectedProducts valueForKey:@"TotalAmount"];
        NSArray *arrQty = [arrSelectedProducts valueForKey:@"Quantity"];
        float total = 0;
        int qty = 0;
        for (NSString *strAmount in arrAmt) {
            float amount = [strAmount floatValue];
            total += amount;
        }
        for (NSString *strQty in arrQty) {
            int q = [strQty intValue];
            qty += q;
        }
        _lblTotalOrderAmount.text = (total > 0) ? [NSString stringWithFormat:@"%0.2f", total] : @"0";
        _lblTotalOrderQuantity.text = (qty > 0) ? [NSString stringWithFormat:@"%ld", (long)qty] : @"0";
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if([string containsOnlyNumbers])
        return YES;
    else
        return NO;
}

#pragma mark - Search Bar Delegates -

- (IBAction)btnSearchClicked:(id)sender {
    _isSearchBarVisible = !_isSearchBarVisible;
    
    if(_isSearchBarVisible){
        _heightOfSearchBar.constant = 56;
        [_txtSearch becomeFirstResponder];
    }else{
        _heightOfSearchBar.constant = 0;
        [self.view endEditing:YES];
        _txtSearch.text = @"";
        _searchTerm = @"";
        [self getProducts];
    }
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [self btnSearchClicked:searchBar];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    if(_txtSearch.text.length > 0){
        _searchTerm = searchBar.text;
        [self.view endEditing:YES];
        arrProducts = [NSMutableArray new];
        _currentPageNumber = 1;
        [self getProducts];
    }
}

#pragma mark - Table View Delegates & Data Source -

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrProducts count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"idProductCell"];
    
    M_ProductList *model = [arrProducts objectAtIndex:indexPath.row];
    
    cell.lblProductName.text = model.itemname;
    cell.lblProductSpecifications.text = model.shortdescription;
    cell.lblProductMRP.text = (model.mrp > 0) ? [NSString stringWithFormat:@"%0.2f", model.mrp] : @"0";
    cell.lblProductOfferPrice.text = (model.offerprice > 0) ? [NSString stringWithFormat:@"%0.2f", model.offerprice] : @"0";
    cell.lblProductAmount.text = (model.totalAmount > 0) ? [NSString stringWithFormat:@"%0.2f", model.totalAmount] : @"0";
    
    [Global addBorder:UIRectEdgeBottom forView:cell.lblProductAmount withColor:THEME_BackgroundGrayColor thickness:2 withFrame:cell.lblProductAmount.frame];
    
    cell.txtQuantity.text = (model.quantity > 0) ? [NSString stringWithFormat:@"%ld", (long)model.quantity] : @"";
    cell.txtQuantity.tag = indexPath.row;
    cell.txtQuantity.delegate = self;
    [cell.txtQuantity addTarget:self action:@selector(txtQuantityDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    // Call to next page of products when last cell is reached.
    if (indexPath.item == arrProducts.count-1)  {
        if(_totalPage > _currentPageNumber){
            _currentPageNumber++;
            [self getProducts];
        }
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{}


- (IBAction)btnAddToCartClicked:(UIButton *)sender {
    [self addToCart];
}

-(void)addToCart
{
    if ([Global checkForConnection])
    {
        NSDictionary *params = @{
                                 @"personid": [ShareInfo sharedManagerInfo].personId,
                                 @"companyid": [ShareInfo sharedManagerInfo].companyId,
                                 MM_DistributorId : @([CartManager sharedObject].distributorId),
                                 MM_CustomerId : @([CartManager sharedObject].customerId),
                                 MM_DistributorCustomerId : @([CartManager sharedObject].distributorCustomerId),
                                 @"cartdetails": arrSelectedProducts
                                 };
        NSLog(@"params : %@", params);
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

            [AZNotification showNotificationWithTitle:@"Product added to cart" controller: self notificationType:AZNotificationTypeSuccess];
            [self reloadProducts];
        }
        else
        {
            NSString *errorMsg = [[[sender responseDict] valueForKey: kErrorData] valueForKey:kErrorMessage];
            [AZNotification showNotificationWithTitle:errorMsg controller: self notificationType:AZNotificationTypeError];
        }
    }
}

@end
