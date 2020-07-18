//
//  BaseVC.m
//  CPSServices
//
//  Created by apple on 8/31/17.
//  Copyright © 2017 apple. All rights reserved.
//

#import "BaseVC.h"
#import <sys/sysctl.h>

@interface BaseVC ()

@end

@implementation BaseVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityDidChange:) name:kReachabilityChangedNotification object:nil];
}

-(void)reachabilityDidChange:(NSNotification *)notification
{
    Reachability *reachability = (Reachability *)[notification object];
    
    if ([reachability isReachable])
    {
        NSLog(@"===> Reachable");
    }
    else
    {
        NSLog(@"===> Unreachable");
    }
}

- (BOOL)hasTopNotch {
    if (@available(iOS 11.0, *)) {
        return [[[UIApplication sharedApplication] delegate] window].safeAreaInsets.top > 20.0;
    }
    
    return  NO;
}

+ (NSDate *) localizedDateFromString:(NSString *)string withFormat:(NSString *)format
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:format];
    formatter.locale = [NSLocale localeWithLocaleIdentifier:NSLocale.currentLocale.localeIdentifier];
    formatter.timeZone = [NSTimeZone timeZoneWithName:NSTimeZone.localTimeZone.name];
    NSDate *date = [formatter dateFromString:string];
    return date;
}

+ (NSString *) stringFromDate:(NSDate *)date withFormat:(NSString *)format
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = format;
    formatter.locale = [NSLocale localeWithLocaleIdentifier:NSLocale.currentLocale.localeIdentifier];
    formatter.timeZone = [NSTimeZone timeZoneWithName:NSTimeZone.localTimeZone.name];
    NSString *strDate = [formatter stringFromDate:date];
    return strDate;
}

-(NSString *)getDocumentDirectoryForAppMedia
{
    //Get path directory
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths firstObject];
    
    //Create Documents directory
    documentsDirectory = [documentsDirectory stringByAppendingPathComponent:@"Meril Media"];
    
    return documentsDirectory;
}

#pragma mark - ----------- addCustomLineToView ----------- -

-(void)addCustomLineToView : (NSArray *)views color : (UIColor *)color
{
    
    for (UIView *view in views)
    {
        UIBezierPath *path = [UIBezierPath bezierPath];
        
        [path moveToPoint: CGPointMake(0, view.frame.size.height / 1.2)];
        [path addLineToPoint: CGPointMake(0, view.frame.size.height)];
        [path addLineToPoint: CGPointMake(view.frame.size.width, view.frame.size.height)];
        [path addLineToPoint: CGPointMake(view.frame.size.width, view.frame.size.height / 1.2)];
        
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.lineWidth = 1.5f;
        shapeLayer.path = path.CGPath;
        shapeLayer.strokeColor = [color CGColor];
        shapeLayer.fillColor = [[UIColor clearColor] CGColor];
        [view.layer addSublayer:shapeLayer];
    }
}


#pragma mark - ----------- setNavigationLeftButtonWithImage ----------- -

-(UIButton *) setNavigationLeftButtonWithImage : (NSString *) imageName
{
    //Create a container for the button
    UIView *buttonContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
    
    NSInteger iconSize = 38;
    UIButton *leftButton = [[UIButton alloc] initWithFrame: CGRectMake(0, 3, iconSize, iconSize)];
    UIImage *leftImage = [UIImage imageNamed:imageName] ;
    [buttonContainer addSubview:leftButton];
    UIBarButtonItem *fixedspace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedspace.width = -15.0f;
    [leftButton setImage:leftImage  forState:UIControlStateNormal];
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:buttonContainer];
    
//    self.navigationItem.leftBarButtonItems=@[fixedspace,backButtonItem];
    self.navigationItem.leftBarButtonItems=@[backButtonItem];
    return leftButton;
}

-(void)showAlertWithMessage : (NSString *)message
{
    UIAlertController *alert = [UIAlertController
                                alertControllerWithTitle:APP_NAME
                                message:message
                                preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action)
                               {}];
    
    [alert addAction:okAction];
    [self presentViewController: alert animated: YES completion: nil];
}

-(void)dismissKeyboard
{
    [self.view endEditing:YES];
}

-(NSString *)getFormattedAmount:(NSString *)amount
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    numberFormatter.locale = [NSLocale currentLocale];// this ensures the right separator behavior
    numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    numberFormatter.usesGroupingSeparator = YES;
    
    NSString *strAmount = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:[amount doubleValue]]];
    
    return strAmount;
}


#pragma mark - ----- imageByScalingAndCroppingImage: forSize: ----- -

- (UIImage *)imageByScalingAndCroppingImage : (UIImage *)image forSize:(CGSize)targetSize
{
    UIImage *sourceImage = image;
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO) {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor) {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else if (widthFactor < heightFactor) {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(targetSize); // this will crop
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if (newImage == nil) {
        NSLog(@"could not scale image");
    }
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}


#pragma mark - ----------- Button clicks ----------- -

-(void)btnBack : (id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)btnMenu : (id)sender
{
//    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

//#pragma mark - ----------- Order Amount Calculation Helper Methods ----------- -
//
//-(NSString *)roundDecimalValue : (NSDecimalNumber *)value withScale : (NSUInteger)scale andFormatterRoundingMode : (NSNumberFormatterRoundingMode)mode
//{
//    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
//    [formatter setNumberStyle:NSNumberFormatterNoStyle];
//    [formatter setMaximumFractionDigits:scale];
//    [formatter setRoundingMode: mode];
//
//    NSString *numberString = [formatter stringFromNumber:value];
//    return numberString;
//}
//
//-(NSString *)calculateUnitPriceAfterDiscountOnOriginalPrice : (NSDecimalNumber *)priceCart ofPercentage : (NSDecimalNumber *)percentage
//{
////    NSNumber *price = [NSNumber numberWithDouble:priceCart];
////    NSNumber *disc = [NSNumber numberWithDouble:percentage];
//
//    NSDecimalNumber *orgPrice = [NSDecimalNumber decimalNumberWithString:[self roundDecimalValue:priceCart withScale:4 andFormatterRoundingMode:NSNumberFormatterRoundHalfEven]]; // [NSDecimalNumber decimalNumberWithDecimal:[price decimalValue]]
//
//    NSDecimalNumber *discount = [NSDecimalNumber decimalNumberWithString:[self roundDecimalValue:percentage withScale:4 andFormatterRoundingMode:NSNumberFormatterRoundHalfEven]]; // [NSDecimalNumber decimalNumberWithDecimal:[disc decimalValue]]
//
//    NSDecimalNumber *newUnitPrice = [orgPrice decimalNumberBySubtracting:([[discount decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithDecimal:[@100.00 decimalValue]]] decimalNumberByMultiplyingBy:orgPrice])];
//
////    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
////    [formatter setMaximumFractionDigits:4];
////    [formatter setRoundingMode: NSNumberFormatterRoundHalfEven];
//
//    NSString *numberString = [self roundDecimalValue:newUnitPrice withScale:4 andFormatterRoundingMode:NSNumberFormatterRoundHalfEven];
//    return numberString;
//}
//
//-(NSString *)calculateDiscountAfterChangeInUnitPrice : (NSDecimalNumber *)changedPrice andOriginalPrice : (NSDecimalNumber *)orgUnitPrice
//{
//    NSLog(@"priceCart-- %@ --orgUnitPrice-- %@", changedPrice ,orgUnitPrice);
//    NSDecimalNumber *discAmt = [orgUnitPrice decimalNumberBySubtracting:changedPrice];
//    NSLog(@"discAmt----%@", discAmt);
//
//    if ([discAmt compare:[NSDecimalNumber numberWithInt:0]] != NSOrderedAscending)
//    {
////        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
////        [formatter setMaximumFractionDigits:7];
////        [formatter setRoundingMode: NSNumberFormatterRoundHalfUp];
//
//        @try
//        {
//            NSString *roundedOrgPrice = [self roundDecimalValue:orgUnitPrice withScale:7 andFormatterRoundingMode:NSNumberFormatterRoundHalfUp];
//            NSDecimalNumber *roundedDecimal = [NSDecimalNumber decimalNumberWithString:roundedOrgPrice];
//            NSDecimalNumber *discPer = [NSDecimalNumber decimalNumberWithDecimal:[@0.00 decimalValue]];
//
//            if([roundedDecimal compare:[NSDecimalNumber decimalNumberWithDecimal:[@0.00 decimalValue]]] == NSOrderedDescending)
////            if (roundedDecimal > [NSDecimalNumber decimalNumberWithDecimal:[@0.00 decimalValue]])
//            {
//                discPer = [[discAmt decimalNumberByDividingBy:roundedDecimal] decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"100"]];
//            }
//
//            NSLog(@"Per----%@", discPer);
//
////            NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
////            [formatter setMaximumFractionDigits:4];
////            [formatter setRoundingMode: NSNumberFormatterRoundHalfEven];
////
////            NSLog(@"%@", [formatter stringFromNumber:discPer]);
//            NSString *stringDisc = [self roundDecimalValue:discPer withScale:4 andFormatterRoundingMode:NSNumberFormatterRoundHalfEven];
//            return stringDisc;
//        }
//        @catch (NSException *exception)
//        {
//            NSLog(@"Exception in BaseVC -> calculateDiscountAfterChangeInUnitPrice : %@", [exception description]);
//            return @"0.0";
//        }
//    }
//
//    return @"0.0";
//}
//
//-(NSString *)calculateTotalProductPriceWithNoofPieces : (NSString *)noOfPieces quantity : (NSString *)qtyCart changedPrice : (NSDecimalNumber *)priceCart
//{
//    NSDecimalNumber *nooFPiecesTotal = [NSDecimalNumber decimalNumberWithString:noOfPieces];
//    NSDecimalNumber *qty = [NSDecimalNumber decimalNumberWithString:qtyCart];
//    NSDecimalNumber *price = priceCart;
//
//    price = [price decimalNumberByMultiplyingBy:nooFPiecesTotal];
//
//    NSDecimalNumber *total = [qty decimalNumberByMultiplyingBy:price];
//    NSLog(@"%@", [NSString stringWithFormat:@"%@", total]);
//
//    return [NSString stringWithFormat:@"%@", total];
//}
//
//#pragma mark -- openScheme: --
//
//- (void)openScheme:(NSString *)scheme
//{
//    UIApplication *application = [UIApplication sharedApplication];
//    NSURL *URL = [NSURL URLWithString:scheme];
//
//    if ([application respondsToSelector:@selector(openURL:options:completionHandler:)])
//    {
//        [application openURL:URL options:@{}
//           completionHandler:^(BOOL success) {
//               NSLog(@"Open %@: %d",scheme,success);
//           }];
//    }
//    else
//    {
//        BOOL success = [application openURL:URL];
//        NSLog(@"Open %@: %d",scheme,success);
//    }
//}
//
//-(void)sendSMSWithText:(NSString *)body andRecipients : (NSString *)recipient
//{
//    NSArray *arrRecipients = [recipient componentsSeparatedByString:@","];
//
//    if([MFMessageComposeViewController canSendText])
//    {
//        MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
//        controller.body = body;
//        controller.recipients = arrRecipients;
//        controller.messageComposeDelegate = self;
//        [self presentViewController:controller animated:YES completion:nil];
//    }
//}
//
//- (void)messageComposeViewController:(MFMessageComposeViewController *)controller
//                 didFinishWithResult:(MessageComposeResult)result
//{
//    switch(result)
//    {
//        case MessageComposeResultCancelled:
//            // user canceled sms
//            NSLog(@"Msg Cancelled");
//            break;
//        case MessageComposeResultSent:
//            // user sent sms
//            //perhaps put an alert here and dismiss the view on one of the alerts buttons
//            NSLog(@"Msg Sent");
//            break;
//        case MessageComposeResultFailed:
//            // sms send failed
//            //perhaps put an alert here and dismiss the view when the alert is canceled
//            NSLog(@"Msg Failed");
//            break;
//        default:
//            break;
//    }
//
//    [controller dismissViewControllerAnimated:YES completion:nil];
//}
//
//+ (NSString *)getModel {
//    size_t size;
//    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
//    char *model = malloc(size);
//    sysctlbyname("hw.machine", model, &size, NULL, 0);
//    NSString *deviceModel = [NSString stringWithCString:model encoding:NSUTF8StringEncoding];
//    free(model);
//    return deviceModel;
//}
//
//-(NSMutableArray *)setupCellControls : (NSMutableArray *)arrControls forCell : (CustomTableViewCell *)cell
//{
//    NSMutableArray *arrCellControls = [NSMutableArray new];
//
//    for (UIView *view in arrControls)
//    {
//        if ([view isKindOfClass:[UIButton class]])
//        {
//            NSLog(@"-------> Its Button!");
//            cell.btnPopupList = (UIButton *)view;
//
//            UIButton *button = (UIButton *)view;
//            [arrCellControls addObject:button];
//
//        }
//
//        if ([view isKindOfClass:[UITextField class]])
//        {
//            NSLog(@"-------> It is a Text Field..");
//            cell.txtInput = (UITextField *)view;
//
//            UITextField *txt = (UITextField *)view;
//            [arrCellControls addObject:txt];
//        }
//
//        if ([view isKindOfClass:[UILabel class]])
//        {
//            NSLog(@"-------> It is a Label.");
//            cell.lblTitle = (UILabel *)view;
//
//            UILabel *lbl = (UILabel *)view;
//            [arrCellControls addObject:lbl];
//        }
//
//        if ([view isKindOfClass:[UIView class]])
//        {
//            NSLog(@"-------> It is a View.");
//            cell.viewCellBg = (UIView *)view;
//
//            UIView *vw = (UIView *)view;
//            [arrCellControls addObject:vw];
//        }
//    }
//
//    return arrCellControls;
//}
//
//-(NSMutableArray *)getPriviledgedModules
//{
//    NSMutableArray *arrModules = [NSMutableArray new];
//    NSArray *list = [NSArray arrayWithContentsOfFile:MM_MenuDataList];
////    NSLog(@"kPriviledgedModules : %@", list);
//
//    for (int i=0; i < [list count]; i++)
//    {
////        for (NSDictionary *dict in list)
////        {
//        NSDictionary *dict = [list objectAtIndex:i];
//        NSArray *menuDetail = [dict objectForKey:MM_MenuDetail];
//        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K = %d",MM_IsView,true];
//        NSArray *filtered = [menuDetail filteredArrayUsingPredicate:predicate];
//
//        for (NSDictionary *dictMenu in filtered)
//        {
//            NSString *menuTitle = [dictMenu objectForKey: MM_MenuTitle];
//            [arrModules addObject:menuTitle];
//        }
////        }
//    }
//
//    return arrModules;
//}

#pragma mark - Check Permissions -

- (void)requestCameraPermissions
{
    // check camera authorization status
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    switch (authStatus)
    {
        case AVAuthorizationStatusAuthorized:
        { // camera authorized
            // do camera intensive stuff
            [self openCamera];
        }
            break;
            
        case AVAuthorizationStatusNotDetermined:
        { // request authorization
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if(granted)
                    {
                        // do camera intensive stuff
                        [self openCamera];
                    }
                    else
                    {
                        [self notifyUserOfCameraAccessDenial];
                    }
                });
            }];
        }
            break;
            
        case AVAuthorizationStatusRestricted:
        case AVAuthorizationStatusDenied:
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self notifyUserOfCameraAccessDenial];
            });
        }
            break;
            
        default:
            break;
    }
}

-(void)openCamera
{
    [self openCamera];
}

- (void)notifyUserOfCameraAccessDenial
{
    // display a useful message asking the user to grant permissions from within Settings > Privacy > Camera
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"Permission Needed" message:@"Effezzient does not have access to your Camera. Please enable access from Settings." preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:@"Cancel"
                               style:UIAlertActionStyleCancel
                               handler:^(UIAlertAction * _Nonnull action)
                               {}];
    
    UIAlertAction *settingsAction = [UIAlertAction
                                     actionWithTitle:@"Settings"
                                     style:UIAlertActionStyleDefault
                                     handler:^(UIAlertAction * _Nonnull action)
                                     {
                                         NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                                         
                                         if([[UIApplication sharedApplication] canOpenURL:url])
                                             [[UIApplication sharedApplication] openURL:url];
                                         else
                                             [self.navigationController popViewControllerAnimated:YES];
                                     }];
    
    [alertController addAction:okAction];
    [alertController addAction:settingsAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)requestPhotoLibraryPermissionsWithMessage:(NSString *)message
{
    if (![message isValid]) {
        message = @"Effezzient does not have access to your Photos. Please enable access from Settings.";
    }
    
    // check photo library authorization status
    PHAuthorizationStatus authStatus = [PHPhotoLibrary authorizationStatus];
    switch (authStatus)
    {
        case PHAuthorizationStatusAuthorized:
        {
            [self openPhotos];
        }
            break;
            
        case PHAuthorizationStatusNotDetermined:
        {
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status)
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if(status == PHAuthorizationStatusAuthorized)
                    {
                        [self openPhotos];
                    }
                    else
                    {
                        [self notifyUserOfPhotosAccessDenial:message];
                    }
                });
            }];
        }
            break;
            
        case PHAuthorizationStatusRestricted:
        case PHAuthorizationStatusDenied:
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self notifyUserOfPhotosAccessDenial:message];
            });
        }
            break;
            
        default:
            break;
    }
}

-(void)openPhotos
{
    [self openPhotos];
}

- (void)notifyUserOfPhotosAccessDenial : (NSString *)message
{
    // display a useful message asking the user to grant permissions from within Settings > Privacy > Camera
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"Permission Needed" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:@"Cancel"
                               style:UIAlertActionStyleCancel
                               handler:^(UIAlertAction * _Nonnull action)
                               {}];
    
    UIAlertAction *settingsAction = [UIAlertAction
                                     actionWithTitle:@"Settings"
                                     style:UIAlertActionStyleDefault
                                     handler:^(UIAlertAction * _Nonnull action)
                                     {
                                         NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                                         
                                         if([[UIApplication sharedApplication] canOpenURL:url])
                                             [[UIApplication sharedApplication] openURL:url];
                                         else
                                             [self.navigationController popViewControllerAnimated:YES];
                                     }];
    
    [alertController addAction:okAction];
    [alertController addAction:settingsAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
//
//-(void)redirectToDirectOrderForType:(NSString *)orderType
//{
//#if MERIL_VERSION
//    CoreDataLibrary *coreData = [[CoreDataLibrary alloc] init];
//    NSMutableArray *arrMenu = [NSMutableArray arrayWithArray:[coreData fetchVisitTypeDetail]];
//
//    // set direct order list
//    NSPredicate *predicateOrder = [NSPredicate predicateWithFormat:@"%K == '' AND %K == %d",MM_IsSytem, MM_ShowInCheckInMenu, 1]; // , MM_VisitTypeName, MM_Not_Listed
//    NSArray *result = [arrMenu filteredArrayUsingPredicate:predicateOrder];
//
//    // Filter distinct visit type names
//    NSMutableArray *arrVisitTypeIDs = [NSMutableArray new];
//    NSMutableArray *arrDirectOrderList = [NSMutableArray new];
//
//    for(NSDictionary *dic in result){
//        NSString *visitTypeId = [NSString stringWithFormat:@"%@", dic[@"visittypeid"]];
//        if([arrVisitTypeIDs containsObject:visitTypeId] == NO){
//            [arrVisitTypeIDs addObject:visitTypeId];
//            [arrDirectOrderList addObject:dic];
//        }
//    }
//
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
//
//    for (int i=0; i < [arrDirectOrderList count]; i++)
//    {
//        NSDictionary *subDict = [arrDirectOrderList objectAtIndex:i];
//        NSString *name = [subDict objectForKey:MM_VisitTypeName];
//        NSInteger subType = [[subDict objectForKey:MM_VisitTypeId] integerValue];
//
//        [alert addAction:[UIAlertAction actionWithTitle:name style:UIAlertActionStyleDefault handler:
//                          ^(UIAlertAction * _Nonnull action)
//                          {
//                              DistributorViewController *distVC = [[DistributorViewController alloc] initWithNibName:MM_DistributorView bundle:nil];
//                              distVC.isDirectOrder = YES;
//                              distVC.visitTypeId = subType;
//                              distVC.title = name;
//
//                              if ([name isEqualToString:MM_Not_Listed]) {
//                                  distVC.isApproved = NO;
//                                  distVC.isNotListed = YES;
//                              }
//                              else
//                              {
//                                  distVC.isApproved = YES;
//                                  distVC.isNotListed = NO;
//                              }
//
//                              distVC.strOrderType = orderType;
//                              [self.navigationController pushViewController:distVC animated:YES];
//                          }]];
//    }
//
//    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
//
//    [self presentViewController:alert animated:YES completion:nil];
//#else
//
//    UnplannedCheckInEntryVC *checkinvc = loadViewController(SB_CheckInandDAR, VC_UnplannedCheckInEntry);
//    checkinvc.isFromModule = MenuCode_OrderRpt;
//    checkinvc.isDirectOrder = YES;
//    checkinvc.strOrderType = orderType;
//    [self.navigationController pushViewController:checkinvc animated:YES];
//
//#endif
//}
//
//-(void)saveRandomCheckIn : (NSMutableDictionary *)checkInDic
//{
//    CoreDataLibrary *coreData = [[CoreDataLibrary alloc] init];
//    NSMutableArray *arrVisitTypes = [NSMutableArray arrayWithArray:[coreData fetchVisitTypeDetail]];
//    NSPredicate *predicateMenu = [NSPredicate predicateWithFormat:@"%K == %@", MM_VisitTypeName, MM_RandomCheckIn];
//    NSMutableArray *arrRandomCheckIn = [[arrVisitTypes filteredArrayUsingPredicate:predicateMenu] mutableCopy];
//
//    if ([arrRandomCheckIn count] == 0)
//    {
//        //        [AZNotification showNotificationWithTitle:@"Random Check-In Master Not Found. Please Contact Your Administrator!" controller:AppContext.window.rootViewController notificationType:AZNotificationTypeError];
//        return;
//    }
//
//    NSDictionary *dict = [NSDictionary new];
//    if ([arrRandomCheckIn count] == 1)
//        dict = [arrRandomCheckIn firstObject];
//
//    [checkInDic setObject:@"0" forKey:MM_DistanceInKM];
//    [checkInDic setObject:[ShareInfo sharedManagerInfo].personId forKey:MM_UserId];
//    [checkInDic setObject:@"Auto Checkin" forKey:MM_Remarks];
//    [checkInDic setObject:[dict valueForKey:MM_VisitTypeId] forKey:MM_CheckedinPlace];
//    [checkInDic setObject:[dict valueForKey:MM_VisitTypeDetailId] forKey:MM_CheckedPlaceIdDetail];
//    [checkInDic setObject:@"" forKey:MM_VisitTypeObjective];
//    [checkInDic setObject:[Global getStringFromDate:[NSDate date] formatter:@"yyyy-MM-dd HH:mm:ss"] forKey:MM_CheckinDatetime];
//    [checkInDic setValue:MM_DeviceTypeIPhone forKey:MM_DeviceType];
//
//    [checkInDic setValue:[ShareInfo sharedManagerInfo].userTimeZone forKey:MM_UserTimeZone];
//
//    NSMutableArray *list = [[NSMutableArray alloc] init];
//    [list addObject:checkInDic];
//
//    NSError *error;
//
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:list
//                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
//                                                         error:&error];
//
//    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    NSLog(@"Params : %@", jsonString);
//
//    if (![Global checkForConnection])
//    {
//        [coreData saveData:list forEntity:MM_DB_CheckInOut];
//    }
//    else
//    {
//        [[WebServiceConnector alloc] init: MM_API_SaveCheckin
//                           withParameters: @{
//                                             @"data" : jsonData
//                                             }
//                               withObject:self
//                             withSelector:@selector(didSaveCheckInSuccess:)
//                           forServiceType:@"JSON"
//                           showDisplayMsg:nil];
//    }
//}
//
//-(void)didSaveCheckInSuccess:(id)sender //(NSMutableDictionary *)response
//{
//    NSLog(@"%@", [sender responseDict]);
//
//    if ([[[sender responseDict] objectForKey:MM_StatusCode] integerValue] == 1)
//    {
//        // @"Check In Done Successfully."
//        NSLog(@"Random Check-In Done Successfully.");
//    }
//    else
//    {
//        NSString *errorMsg = [[[sender responseDict] valueForKey:kErrorData] valueForKey:kErrorMessage];
//        //        [AZNotification showNotificationWithTitle: errorMsg controller: self notificationType:AZNotificationTypeError];
//        NSLog(@"Random Check-In error description : %@", errorMsg);
//    }
//}
//
//-(void)getLeadActivityListForLead:(NSString *)leadID andLeadActivityID:(NSString *)leadActivityID
//{
//    if([Global checkForConnection])
//    {
//        NSDictionary *params = @{
//                                 kPersonID : [ShareInfo sharedManagerInfo].personId,
//                                 @"leadid" : leadID ? leadID : @"",
//                                 @"activityid" : leadActivityID ? leadActivityID : @""
//                                 };
//        [[WebServiceConnector alloc]init:URLGetLeadActivities
//                          withParameters:params
//                              withObject:self
//                            withSelector:@selector(getLeadActivityListResponse:)
//                          forServiceType:@"JSON"
//                          showDisplayMsg:@""];
//    }
//    else
//    {
//        [AZNotification showNotificationWithTitle: Msg_Internet_Unavailable controller: self notificationType:AZNotificationTypeError];
//    }
//}
//
//-(void)getLeadActivityListResponse:(id)sender
//{
//    [self getLeadActivityListResponse:sender];
//}

-(BOOL)isExtensionIsOfImage:(NSString *)extension
{
    NSArray *arrImageExtensions = @[@"jpeg", @"jpg", @"png", @"bmp"];
    if([arrImageExtensions containsObject:extension]){
        return YES;
    }
    return NO;
}

- (void)saveToAlbum:(UIImage *)image andFileURL:(NSURL *)videoURL {
    NSString *albumName = @"Effezzient Images";
    
//    [self requestPhotoLibraryPermissionsWithMessage:@"Please allow Photo Library access to save media on your phone."];
    
//    if (image == nil || videoURL == nil) {
//        return;
//    }
    
//    if (image != nil) {
        void (^saveImageBlock)(PHAssetCollection *assetCollection) = ^void(PHAssetCollection *assetCollection) {
            [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
                PHAssetChangeRequest *assetChangeRequest = [PHAssetChangeRequest creationRequestForAssetFromImage:image];
                PHAssetCollectionChangeRequest *assetCollectionChangeRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:assetCollection];
                [assetCollectionChangeRequest addAssets:@[[assetChangeRequest placeholderForCreatedAsset]]];
                
            } completionHandler:^(BOOL success, NSError *error) {
                if (!success) {
                    NSLog(@"Error creating asset: %@", error);
                }
            }];
        };
        
        PHFetchOptions *fetchOptions = [[PHFetchOptions alloc] init];
        fetchOptions.predicate = [NSPredicate predicateWithFormat:@"localizedTitle = %@", albumName];
        PHFetchResult *fetchResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAny options:fetchOptions];
        
        if (fetchResult.count > 0) {
            saveImageBlock(fetchResult.firstObject);
        } else {
            __block PHObjectPlaceholder *albumPlaceholder;
            [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
                PHAssetCollectionChangeRequest *changeRequest = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:albumName];
                albumPlaceholder = changeRequest.placeholderForCreatedAssetCollection;
                
            } completionHandler:^(BOOL success, NSError *error) {
                if (success) {
                    PHFetchResult *fetchResult = [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[albumPlaceholder.localIdentifier] options:nil];
                    if (fetchResult.count > 0) {
                        saveImageBlock(fetchResult.firstObject);
                    }
                } else {
                    NSLog(@"Error creating album: %@", error);
                }
            }];
        }
//    }
//    else if (videoURL != nil) {
//        void (^saveVideoBlock)(PHAssetCollection *assetCollection) = ^void(PHAssetCollection *assetCollection) {
//            [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
//                PHAssetChangeRequest *assetChangeRequest = [PHAssetChangeRequest creationRequestForAssetFromVideoAtFileURL:videoURL];
//                PHAssetCollectionChangeRequest *assetCollectionChangeRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:assetCollection];
//                [assetCollectionChangeRequest addAssets:@[[assetChangeRequest placeholderForCreatedAsset]]];
//
//            } completionHandler:^(BOOL success, NSError *error) {
//                if (!success) {
//                    NSLog(@"Error creating asset: %@", error);
//                }
//            }];
//        };
//
//        PHFetchOptions *fetchOptions = [[PHFetchOptions alloc] init];
//        fetchOptions.predicate = [NSPredicate predicateWithFormat:@"localizedTitle = %@", albumName];
//        PHFetchResult *fetchResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAny options:fetchOptions];
//
//        if (fetchResult.count > 0) {
//            saveVideoBlock(fetchResult.firstObject);
//        } else {
//            __block PHObjectPlaceholder *albumPlaceholder;
//            [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
//                PHAssetCollectionChangeRequest *changeRequest = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:albumName];
//                albumPlaceholder = changeRequest.placeholderForCreatedAssetCollection;
//
//            } completionHandler:^(BOOL success, NSError *error) {
//                if (success) {
//                    PHFetchResult *fetchResult = [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[albumPlaceholder.localIdentifier] options:nil];
//                    if (fetchResult.count > 0) {
//                        saveVideoBlock(fetchResult.firstObject);
//                    }
//                } else {
//                    NSLog(@"Error creating album: %@", error);
//                }
//            }];
//        }
//    }
}
//
//+ (NSString *)get_vCardFromCNContact:(CNContact *)cnContact{
//    NSString *BEGIN = @"BEGIN:VCARD";
//    NSString *VERSION = @"VERSION:3.0";
//    NSString *NAME = [NSString stringWithFormat:@"N:%@;%@;", cnContact.familyName, cnContact.givenName];
//    NSString *FN = [NSString stringWithFormat:@"FN:%@ %@ %@", cnContact.givenName, cnContact.middleName, cnContact.familyName];
//    NSMutableArray *arrTEL = [NSMutableArray new];
//    for(NSString *strContact in cnContact.phoneNumbers){
//        [arrTEL addObject:[NSString stringWithFormat:@"TEL;TYPE=HOME,VOICE:%@", strContact]];
//    }
//    NSString *END = @"END:VCARD";
//    return [NSString stringWithFormat:@"%@\n%@\n%@\n%@\n%@\n%@\n", BEGIN, VERSION, NAME, FN, [arrTEL componentsJoinedByString:@"\n"], END];
//}

+(void)displayToastAlertAtBottom:(NSString *)str{
    iToastSettings *theSettings = [iToastSettings getSharedSettings];
    [theSettings setDuration:2000];
    [theSettings setGravity:iToastGravityBottom];
    [[iToast makeText:str] show];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
