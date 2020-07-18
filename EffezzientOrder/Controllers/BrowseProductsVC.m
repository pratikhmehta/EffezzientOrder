//
//  BrowseProductsVC.m
//  Meril
//
//  Created by Inspiro Infotech on 20/01/20.
//  Copyright © 2020 Inspiro Infotech. All rights reserved.
//

#import "BrowseProductsVC.h"

#import "CommonFilterVC.h"

#import "ProductListCell.h"

#import "Cataloguedetail.h"

#import "UIImageView+WebCache.h"

#import "ProductDetailsVC.h"

#import "CartManager.h"

@interface BrowseProductsVC ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate, WishListItemsChangeDelegate, CartCountDelegate>

@property (nonatomic) NSInteger currentPageNumber;
@property (nonatomic) NSInteger totalPage;
@property (nonatomic) NSInteger totalProducts;

@property (nonatomic, retain) NSMutableArray *arrData;
@property (nonatomic) BOOL isSearchBarVisible;
@property (nonatomic, retain) NSString *searchTerm;

@property (nonatomic) NSInteger wishlistedIndex;

@property (nonatomic) NSInteger selectedIndex;

@property (nonatomic, retain) UIBarButtonItem *btnSearch, *btnGotoCart, *btnGotoWishlist;

@property (nonatomic, retain) NSMutableArray *arrSelectedFilter;

@property (nonatomic, retain) NSArray *arrSortOptions;

@property (nonatomic, retain) NSString *selectedSortColumn;
@property (nonatomic, retain) NSString *selectedSortOrder;

@end

#define kDisplayName @"DisplayName"
#define kValue       @"Value"
#define kSortColumn  @"sortcolumn"
#define kSortOrder   @"sortorder"
#define kOfferPrice  @"offerprice"
#define kItemId      @"itemid"
#define kAsc         @"asc"
#define kDesc        @"desc"

@implementation BrowseProductsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Products";
    if(_isOnWishlist){
        self.title = @"Wishlist";
    }
    
    NSDictionary *dicSortLatestFirst = @{ kDisplayName: @"Latest First", kSortColumn : kItemId, kSortOrder : kDesc };
    NSDictionary *dicSortOldestFirst = @{ kDisplayName: @"Oldest First", kSortColumn : kItemId, kSortOrder : kAsc };
    NSDictionary *dicSortPriceLowestFirst = @{ kDisplayName: @"Price Lowest", kSortColumn : kOfferPrice, kSortOrder : kAsc };
    NSDictionary *dicSortPriceHighestFirst = @{ kDisplayName: @"Price Highest", kSortColumn : kOfferPrice, kSortOrder : kDesc };
    _arrSortOptions = @[ dicSortLatestFirst, dicSortPriceLowestFirst, dicSortPriceHighestFirst, dicSortOldestFirst ];
    
    _selectedSortColumn = kItemId;
    _selectedSortOrder = kDesc;
    
    _btnSearch = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"img_search_icon_white"] style:UIBarButtonItemStylePlain target:self action:@selector(btnSearchClicked:)];
    _btnGotoCart = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_nav_cart"] style:UIBarButtonItemStylePlain target:self action:@selector(btnGoToCartClicked:)];
    _btnGotoWishlist = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_nav_heart"] style:UIBarButtonItemStylePlain target:self action:@selector(btnGoToWishlistClicked:)];
    
    if(_isOnWishlist){
        self.navigationItem.rightBarButtonItems = @[_btnGotoCart, _btnSearch];
    }else{
        self.navigationItem.rightBarButtonItems = @[_btnGotoCart, _btnGotoWishlist, _btnSearch];
    }
    
    _selectedIndex = -1;
    
    [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ProductListCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([ProductListCell class])];
    
    _heightOfSearchBar.constant = 0;
    _txtSearch.delegate = self;
    _searchTerm = @"";
    
    UITapGestureRecognizer *tapVwScrollToTop = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollToTop:)];
    [_vwScrollToTop addGestureRecognizer:tapVwScrollToTop];
    
    [self callGetProducts];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [[CartManager sharedObject] refreshCartCount];
    [CartManager sharedObject].delegate = self;
    
    if(_selectedIndex >= 0){
        if(_isOnWishlist){
            M_ProductList *model = _arrData[_selectedIndex];
            if(model.iswishlisetd == NO){
                [_arrData removeObjectAtIndex:_selectedIndex];
                [_collectionView reloadData];
                if(_delegate){
                    if([_delegate respondsToSelector:@selector(itemRemovedFromWishList:)]){
                        [_delegate itemRemovedFromWishList:model];
                    }
                }
            }else{
                [_collectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:_selectedIndex inSection:0]]];
                _selectedIndex = -1;
            }
        }else{
            [_collectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:_selectedIndex inSection:0]]];
            _selectedIndex = -1;
        }
    }
}

-(void)callGetProducts{
    [_vwScrollToTop setAlpha:0];
    _arrData = [NSMutableArray new];
    _currentPageNumber = 1;
    [_collectionView reloadData];
    [self getProducts];
}

#pragma mark -Service Call Handling

-(void)getProducts
{
    if ([Global checkForConnection])
    {
        NSArray *arrAppliedFilters = [_arrSelectedFilter valueForKey:@"toDictionary"];
        if(arrAppliedFilters.count == 0){
            arrAppliedFilters = @[];
        }
        NSDictionary *params = @{
                                 @"companyid" : [ShareInfo sharedManagerInfo].companyId,
                                 @"userid" : [ShareInfo sharedManagerInfo].personId,
                                 @"pagenumber": @(_currentPageNumber),
                                 @"searchstring": _searchTerm,
                                 @"selectedValues" : arrAppliedFilters,
                                 @"wishlistedonly": @(_isOnWishlist),
                                 kSortOrder : _selectedSortOrder,
                                 kSortColumn : _selectedSortColumn
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
        [AZNotification showNotificationWithTitle: Msg_Internet_Unavailable controller: self notificationType:AZNotificationTypeError];
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
            
            [_arrData addObjectsFromArray:[sender responseArray]];
          
            if(_currentPageNumber == 1){
                [self setCurrentIndexInLblScrollToTop:0];
            }
        }
        else
        {
            NSString *errorMsg = [[[sender responseDict] valueForKey: kErrorData] valueForKey:kErrorMessage];
            [AZNotification showNotificationWithTitle:errorMsg controller: self notificationType:AZNotificationTypeError];
        }
    }
    
    [_collectionView reloadData];
    
    if(_arrData.count == 0){
        [_collectionView setHidden:YES];
        [_imgNoDataFound setHidden:NO];
    }else{
        [_collectionView setHidden:NO];
        [_imgNoDataFound setHidden:YES];
    }
}

-(void)callAddOrRemoveWishList{
    if ([Global checkForConnection])
    {
        M_ProductList *model = _arrData[_wishlistedIndex];
        NSDictionary *params = @{
                                 @"companyid" : [ShareInfo sharedManagerInfo].companyId,
                                 @"personId" : [ShareInfo sharedManagerInfo].personId,
                                 @"ItemId": @(model.itemid),
                                 MM_DistributorCustomerId: @([CartManager sharedObject].distributorCustomerId)
                                 };
        
        NSString *apiName = URLAddToWishList;
        if(model.iswishlisetd){
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
    if ([sender responseCode] != 100)
    {
        [self showAlertWithMessage:[sender responseError]];
    }
    else
    {
        if([[[sender responseDict] valueForKey:kStatusCode] boolValue])
        {
            M_ProductList *model = _arrData[_wishlistedIndex];
            if(_isOnWishlist){
                _totalProducts -= 1;
                [self setCurrentIndexInLblScrollToTop:0];
                [_arrData removeObjectAtIndex:_wishlistedIndex];
                if(_delegate){
                    if([_delegate respondsToSelector:@selector(itemRemovedFromWishList:)]){
                        [_delegate itemRemovedFromWishList:model];
                    }
                }
            }else{
                model.iswishlisetd = !model.iswishlisetd;
                _arrData[_wishlistedIndex] = model;
            }
        }
        else
        {
            NSString *errorMsg = [[[sender responseDict] valueForKey: kErrorData] valueForKey:kErrorMessage];
            [AZNotification showNotificationWithTitle:errorMsg controller: self notificationType:AZNotificationTypeError];
        }
    }
    
    if(_isOnWishlist){
        [_collectionView reloadData];
    }
    else{
        [_collectionView reloadItemsAtIndexPaths:@[ [NSIndexPath indexPathForItem:_wishlistedIndex inSection:0] ]];
    }
    _wishlistedIndex = -1;
}

#pragma mark -

#pragma mark - CollectionView

-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ProductListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ProductListCell class]) forIndexPath:indexPath];
    cell.vwSinglePieceAvailability.clipsToBounds = YES;
    cell.vwSinglePieceAvailability.layer.cornerRadius = 5;
    cell.vwSinglePieceAvailability.layer.maskedCorners = kCALayerMaxXMaxYCorner|kCALayerMaxXMinYCorner;
    
    M_ProductList *model = _arrData[indexPath.item];
    [cell setSelectedProduct:model];
    
    cell.btnWishlist.tag = indexPath.item;
    [cell.btnWishlist addTarget:self action:@selector(btnWishlistClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    //_lblScrollToTopProductCount.text = [NSString stringWithFormat:@"%ld/%ld", indexPath.item+1, (long)_totalProducts];
    
    [self setCurrentIndexInLblScrollToTop:indexPath.item+1];
    
    if (indexPath.item == _arrData.count-1)  {
        if(_totalPage > _currentPageNumber){
            _currentPageNumber++;
            [self getProducts];
        }
    }
    
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _arrData.count;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(collectionView.frame.size.width/2, 292);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    _selectedIndex = indexPath.item;
    ProductDetailsVC *vc = loadViewController(SB_Order, VC_ProductDetails);
    vc.selectedProduct = _arrData[_selectedIndex];
    vc.cameFromWishList = _isOnWishlist;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(scrollView.contentOffset.y > 800){
        if(_vwScrollToTop.alpha == 0){
            [UIView animateWithDuration:0.3 animations:^{
                [_vwScrollToTop setAlpha:1.0];
            }];
        }
    }else{
        if(_vwScrollToTop.alpha != 0){
            [UIView animateWithDuration:0.3 animations:^{
                [_vwScrollToTop setAlpha:0];
            }];
        }
    }
}

-(void)scrollToTop:(UITapGestureRecognizer *)tapGesture{
    if(_arrData.count > 0){
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
    }
}

-(void)btnWishlistClicked:(FaveButton *)btn{
    _wishlistedIndex = btn.tag;
    [self callAddOrRemoveWishList];
}

#pragma mark -

#pragma mark - SearchBar

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [self btnSearchClicked:searchBar];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    if(_txtSearch.text.length > 0){
        _searchTerm = searchBar.text;
        [self.view endEditing:YES];
        _arrData = [NSMutableArray new];
        _currentPageNumber = 1;
        [self callGetProducts];
    }
}

#pragma mark -

-(void)btnSearchClicked:(id)sender{
    _isSearchBarVisible = !_isSearchBarVisible;
    
    if(_isSearchBarVisible){
        _heightOfSearchBar.constant = 56;
        [_txtSearch becomeFirstResponder];
    }else{
        _heightOfSearchBar.constant = 0;
        [self.view endEditing:YES];
        _txtSearch.text = @"";
        _searchTerm = @"";
        [self callGetProducts];
    }
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
}

-(void)btnGoToCartClicked:(id)sender{
    [self.navigationController pushViewController:loadViewController(SB_Order, VC_Cart) animated:YES];
}

-(void)btnGoToWishlistClicked:(id)sender{
    BrowseProductsVC *vc = loadViewController(SB_Order, VC_BrowseProducts);
    vc.isOnWishlist = YES;
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)btnSortClicked:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    for(NSDictionary *sortDic in _arrSortOptions){
        
        NSString *sortColumn = sortDic[kSortColumn];
        NSString *sortOrder = sortDic[kSortOrder];
        
        NSString *displayName = sortDic[kDisplayName];
        if([sortColumn isEqualToString:_selectedSortColumn] && [sortOrder isEqualToString:_selectedSortOrder]){
            displayName = [NSString stringWithFormat:@"✔︎ %@", sortDic[kDisplayName]];
        }
        
        [alert addAction:[UIAlertAction actionWithTitle:displayName style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSInteger index = [alert.actions indexOfObject:action];
            NSDictionary *sortDic = _arrSortOptions[index];
            
            NSString *newSortColumn = sortDic[kSortColumn];
            NSString *newSortOrder = sortDic[kSortOrder];
            if(
               [_selectedSortColumn isEqualToString:newSortColumn] == NO ||
               [_selectedSortOrder isEqualToString:newSortOrder] == NO
               ){
                _selectedSortColumn = newSortColumn;
                _selectedSortOrder = newSortOrder;
                [self callGetProducts];
            }
        }]];
    }
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Close" style:UIAlertActionStyleCancel handler:nil]];
    
    [self.navigationController presentViewController:alert animated:YES completion:nil];
}

- (IBAction)btnFilterClicked:(id)sender {
    CommonFilterVC *vc = loadViewController(SB_CommonFilter, VC_CommonFilter);
    vc.moduleName = @"item";
    vc.onFilter = ^(NSMutableArray * _Nonnull selectedModuleFilters) {
        [_vwFilterIndication setHidden:NO];
        _arrSelectedFilter = selectedModuleFilters;
        [self callGetProducts];
    };
    vc.onClear = ^{
        [_vwFilterIndication setHidden:YES];
        _arrSelectedFilter = [NSMutableArray new];
        [self callGetProducts];
    };
    vc.arrSelectedFilterValues = _arrSelectedFilter;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)setCurrentIndexInLblScrollToTop:(NSInteger)currentIndex{
    _lblScrollToTopProductCount.text = [NSString stringWithFormat:@"%ld/%ld", (long)currentIndex, (long)_totalProducts];
}

#pragma mark - Delegate

- (void)itemRemovedFromWishList:(nonnull M_ProductList *)product {
    M_ProductList *foundProduct;
    NSInteger foundIndex = -1;
    for(M_ProductList *model in _arrData){
        if(model.itemid == product.itemid){
            foundProduct = model;
            foundIndex = [_arrData indexOfObject:foundProduct];
            break;
        }
    }
    if(foundProduct && foundIndex>=0){
        foundProduct.iswishlisetd = NO;
        _arrData[foundIndex] = foundProduct;
        [_collectionView reloadItemsAtIndexPaths:@[ [NSIndexPath indexPathForItem:foundIndex inSection:0] ]];
    }
}

-(void)onRefreshCartCount:(NSInteger)cartCount{
    [_btnGotoCart setBadgeValue:[NSString stringWithFormat:@"%ld", (long)cartCount]];
    [_btnGotoCart setBadgeOriginY:0];
}

#pragma mark -

@end
