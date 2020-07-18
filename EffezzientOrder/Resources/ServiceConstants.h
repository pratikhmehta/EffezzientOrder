//
//  ServiceConstants.h
//  MerilInternational
//
//  Created by apple on 9/6/17.
//  Copyright © 2017 meril. All rights reserved.
//

#ifndef ServiceConstants_h
#define ServiceConstants_h

////////////////////////////////////////////////////////////////////////

    #define MM_ServerUrl                    [[NSUserDefaults standardUserDefaults] objectForKey:@"HOST_NAME"]
//        #define MM_ServerUrl                    @"http://sfa.arkray.co.in:8080/"
    #define MM_ApiFolder                    @"WebApi/api/"
//        #define MM_ApiFolder                    @"api/"
    #define MM_DefaultDomain                @""
    #define MM_DefaultImageFolder           @"taskportal"

    #define MM_ServerPath                   [NSString stringWithFormat:@"%@%@%@", MM_ServerUrl, [[NSUserDefaults standardUserDefaults] objectForKey:MM_DomainName], MM_ApiFolder]

    #define MM_ProductsImagePath            [NSString stringWithFormat:@"%@%@/images/item/", MM_ServerUrl, [[NSUserDefaults standardUserDefaults] objectForKey:MM_DomainImageFolder]]

    #define MM_DeviceIos                        @"/DeviceType=IOS"

    #define MM_DomainName                       @"DomainName"
    #define MM_DomainImageFolder                @"DomainImageFolder"
    
////////////////////////////////////////////////////////////////////////

#define     APP_NAME            @"Effezzient"

#define ShowNetworkIndicator(BOOL)      [UIApplication sharedApplication].networkActivityIndicatorVisible = BOOL

#define isService( key ) \
[requestURL isEqualToString: key ]


#define     DataNotAvailable        @"Data not available"
#define     Fail                    @"Fail"
#define     Success_str             @"Success"
#define     Error_str               @"Error"

#define     Msg_Internet_Unavailable    @"Internet Connection Unavailable!"

#define MM_UserTimeZoneID       @"UserTimeZoneID"
#define MM_UserTimeZone         @"UserTimeZone"
#define MM_UserTimeZoneAlias    @"UserTimeZoneAlias"

// Delegate
#define AppContext ((AppDelegate*)[[UIApplication sharedApplication]delegate])

// StoryBoard
#define getStroyboard(StoryboardWithName) [UIStoryboard storyboardWithName:StoryboardWithName bundle:NULL]

//View Controller
#define loadViewController(StroyBoardName, VCIdentifer) [getStroyboard(StroyBoardName) instantiateViewControllerWithIdentifier:VCIdentifer]

// Side Menu Constants
#define kMainViewController    (MainViewController *)[Global topViewController]
//(MainViewController *)[UIApplication sharedApplication].delegate.window.rootViewController
#define kNavigationController   (NavigationController *)[kMainViewController rootViewController]
//(NavigationController *)[(MainViewController *)[UIApplication sharedApplication].delegate.window.rootViewController rootViewController]

// Device
#define IOS_NEWER_OR_EQUAL_TO_8 ( [ [ [ UIDevice currentDevice ] systemVersion ] floatValue ] >= 8.0 )
#define IOS_NEWER_OR_EQUAL_TO_9 ( [ [ [ UIDevice currentDevice ] systemVersion ] floatValue ] >= 9.0 )
#define IOS_NEWER_OR_EQUAL_TO_10 ( [ [ [ UIDevice currentDevice ] systemVersion ] floatValue ] >= 10.0 )
#define IS_iPad     (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? YES : NO
#define IS_iPhone    (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) ? YES : NO

#define screenWidth               [[UIScreen mainScreen] bounds].size.width
#define screenHeight              [[UIScreen mainScreen] bounds].size.height

// Font
#define FONT_AWESOME(Size)             [UIFont fontWithName:@"Roboto-Regular" size:Size]
#define FONT_AWESOME_BOLD(Size)        [UIFont fontWithName:@"Roboto-Medium" size:Size]
#define ShowNetworkIndicator(BOOL)      [UIApplication sharedApplication].networkActivityIndicatorVisible = BOOL

// Current Timestamp
#define TimeStamp [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]] // * 1000

// Colors

#define THEME_BlueColor             [UIColor colorNamed:@"ThemeColor"]//RGB(1, 180, 221)
#define THEME_BackgroundGrayColor   [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1]
#define THEME_RedColor              [UIColor colorWithRed:204/255.0 green:0/255.0 blue:0/255.0 alpha:1]
#define THEME_LinkColor             [UIColor colorNamed:@"LinkColor"]

// Nav Slider Menu

#define sliderMenuColor THEME_BlueColor//[UIColor colorWithRed:1.0f/255.0f green:180.0f/255.0f blue:221.0f/255.0f alpha:1]
#define lblGrayColor    [UIColor colorWithRed:103.0f/255.0f green:103.0f/255.0f blue:103.0f/255.0f alpha:1]
#define cellBackColor   [UIColor colorWithRed:250.0f/255.0f green:250.0f/255.0f blue:250.0f/255.0f alpha:1]
#define navColor        sliderMenuColor//[UIColor colorWithRed:255.0f/255.0f green:51.0f/255.0f blue:102.0f/255.0f alpha:1]
#define disableColor    [Global colorFromHexString:@"959595"]
#define subLabelColor   [UIColor colorWithRed:110.0f/255.0f green:110.0f/255.0f blue:110.0f/255.0f alpha:1]
#define viewBorderColor     [UIColor lightGrayColor]

static CGFloat sliderHeight = 45;
#define MM_statusBarHeight         [UIApplication sharedApplication].statusBarFrame.size.height
#define navigationBarHeight     44//[UINavigationBar appearance].frame.size.height
#define subViewHeight   (sliderHeight + MM_statusBarHeight + navigationBarHeight)

////////////////////////////////////////////////////////////////////////

#pragma mark - API Keys -

#define GooglePlacesAPIKey  @"AIzaSyAEgTIc4rywDwX05qtunI7UFQAhpJGgyT0"

#pragma mark - Web Service Requests -

#define DeviceTypeIOS       @"DeviceType=IOS"

// Order (Products & Catalogue Browse and Purchase)
#define URLGetProductList [NSString stringWithFormat:@"%@/ProductNew/GetProductList/%@", MM_ServerPath, DeviceTypeIOS]
#define URLAddToWishList [NSString stringWithFormat:@"%@/WishList/AddToWishList/", MM_ServerPath]
#define URLRemoveFromWishList [NSString stringWithFormat:@"%@/WishList/RemoveFromWishList/", MM_ServerPath]
#define URLWishList [NSString stringWithFormat:@"%@/WishList/Get/", MM_ServerPath]
#define URLGetProductImages [NSString stringWithFormat:@"%@/ProductNew/GetProductImages/", MM_ServerPath]
#define URLGetProductSize [NSString stringWithFormat:@"%@/ProductNew/GetProductSize/", MM_ServerPath]
#define URLGetProductSpec [NSString stringWithFormat:@"%@/ProductNew/GetProductSpec/", MM_ServerPath]
#define URLGetSimilarProductList [NSString stringWithFormat:@"%@/ProductNew/GetSimilarProductList/", MM_ServerPath]
#define URLGetOrderCatalogueItemData [NSString stringWithFormat:@"%@/ProductNew/GetOrderCatalogueItemData/", MM_ServerPath]
#define URLGetProductDetail [NSString stringWithFormat:@"%@/ProductNew/GetProductDetail/", MM_ServerPath]
#define URLGetSelectableSpecs [NSString stringWithFormat:@"%@/ProductNew/GetSelectableSpecs/", MM_ServerPath]
#define URLAddUpdateCart [NSString stringWithFormat:@"%@/Cart/AddToCart/", MM_ServerPath]
#define URLGetCart [NSString stringWithFormat:@"%@/Cart/Get/", MM_ServerPath]
#define URLRemvoeFromCart [NSString stringWithFormat:@"%@/Cart/RemvoeFromCart/", MM_ServerPath]
#define URLUpdateCartOrderDetail [NSString stringWithFormat:@"%@/Cart/UpdateCartOrderDetail/", MM_ServerPath]
#define URLUpdateCartOtherDetail [NSString stringWithFormat:@"%@/Cart/UpdateCartOtherDetail/", MM_ServerPath]
#define URLGetDispatchType [NSString stringWithFormat:@"%@/DispatchType/GetDispatchType/", MM_ServerPath]
#define URLUpdateCartItemQuantity [NSString stringWithFormat:@"%@/Cart/UpdateCartItemQuantity/", MM_ServerPath]
#define URLGetCartCount [NSString stringWithFormat:@"%@/Cart/GetCartCount/", MM_ServerPath]
#define URLPlaceOrder [NSString stringWithFormat:@"%@/Cart/PlaceOrder/", MM_ServerPath]
#define URLGetOrderAchievementList [NSString stringWithFormat:@"%@/OrderAchievement/GetAcheivementListForMobile/%@", MM_ServerPath, DeviceTypeIOS]

// Module Filter
#define URLGetModuleFilter [NSString stringWithFormat:@"%@/ModuleFilter/GetModuleFilter/", MM_ServerPath]
#define URLGetModuleFilterValues [NSString stringWithFormat:@"%@/ModuleFilter/GetModuleFilterValues/", MM_ServerPath]

#define URLGetListOfDistributors [NSString stringWithFormat:@"%@/CustomerDistributorMapping/GetListOfDistributors/", MM_ServerPath]

// GetProductCategory
#define URLGetProductCategory [NSString stringWithFormat:@"%@/Category", MM_ServerPath]

#define URLFormConfiguration [NSString stringWithFormat:@"%@/FormConfiguration", MM_ServerPath]

////////////////////////////////////////////////////////////////////////

#pragma mark - Web Service Classes -

#define WebServiceDialogMsg @"Loading"

#define LandingSectionClass         @"M_LandingSection"
#define ProductListClass            @"M_ProductList"
#define ProductSizeClass            @"M_ProductSize"
#define ProductSpecClass            @"M_ProductSpec"
#define ProductDetailsClass         @"M_ProductDetails"
#define ProductSelectableSpecClass  @"M_ProductSelectableSpec"
#define DispatchTypeClass           @"M_DispatchType"
#define CartDataClass               @"M_CartData"
#define CartCountClass              @"M_CartCount"
#define FilterClass                 @"M_Filter"
#define FilterValuesClass           @"M_FilterValues"

#define DistributorListClass        @"M_DistributorList"
#define ProductCategoryClass @"M_ProductCategory"
#define FormConfigurationClass      @"M_FormConfiguration"
#define OrderAchievementClass       @"M_OrderAchievement"

////////////////////////////////////////////////////////////////////////

#pragma mark - Web Service Keys -

// Service response constants
#define kStatusCode         @"statuscode"
#define kStatusCodeTrue     1
#define kStatusCodeFalse    0

#define kCurrentPage        @"current"
#define kLastPage           @"last"

#define kSuccessData        @"data"
#define kErrorKey           @"error"
#define kErrorData          @"errordata"
#define kErrorMessage       @"message"
#define kErrorCode          @"errorcode"
#define kErrorCodeNoDataFound   99

// Users
#define kUserIDCaps         @"UserId"
#define kPersonID           @"personid"
#define kCompanyID          @"CompanyId"
#define kUserID             @"userid"
#define kFileName           @"filename"

#define MM_DistributorId                @"distributorid"
#define MM_CustomerId               @"customerid"
#define MM_DistributorCustomerId    @"distributorcustomerid"

#define kModuleName                 @"modulename"
#define kSubModuleName              @"submodulename"

#define kModuleNameFieldManagement  @"FieldManagement"
#define kSubModuleNameNewOrderEntry @"NewOrderEntry"

#define MM_ShowInstantOrder     @"showInstantOrder"

#define kOrderAchievementID     @"orderachievementid"
#define kOrderAchievement       @"orderachievement"

#define kOrderTypeCheckIn       @"checkin"
#define kOrderTypeDirect        @"direct"

#define kOrderType_SalesPerson  @"U"
#define kOrderType_POB          @"O"
#define kOrderType_Prescription @"P"

#define kCheckedInID            @"checkedinid"

////////////////////////////////////////////////////////////////////////

#define     SB_Order                                @"Order"
#define     SB_CommonFilter                         @"CommonFilter"

#define     VC_LandingScreen                        @"idLandingScreenVC"
#define     VC_CommonFilter                         @"idCommonFilterVC"
#define     VC_BrowseProducts                       @"idBrowseProductsVC"
#define     VC_ProductDetails                       @"idProductDetailsVC"
#define     VC_ProductImagesSlider                  @"idProductImagesSliderVC"
#define     VC_AddToCartPopUp                       @"idAddToCartPopUp"
#define     VC_FormattedString                      @"idFormattedStringVC"
#define     VC_Cart                                 @"idCartVC"
#define     VC_ProductCategory                      @"idProductCategoryVC"
#define     VC_InstantOrderEntry                    @"idInstantOrderEntryVC"


#endif /* ServiceConstants_h */
