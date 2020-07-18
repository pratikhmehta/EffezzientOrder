//
//  Global.m
//  ImageVideoApp
//
//  Created by Manish Patel on 20/04/16.
//  Copyright © 2016 Manish Patel. All rights reserved.
//

#import "Global.h"
#import "iToast.h"

@implementation Global

+(CGRect)screenSize
{
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGSize sizeObj = CGSizeMake(MIN(screenSize.width, screenSize.height), MAX(screenSize.width, screenSize.height));
    return CGRectMake(0, 0, sizeObj.width, sizeObj.height);
}

+ (void)setupDomainUrl
{
#if (EFFEZIENT_VERSION || SETHJIBANO_VERSION)
    if (![[MM_ServerPath lowercaseString] containsString:@"arkray"]) {
        NSString *strUrl = [DefaultsValues getStringValueFromUserDefaults_ForKey:MM_DomainName];
        if (![strUrl isValid])// || [[strUrl lowercaseString] isEqualToString:@"iphone"])
        {
            [DefaultsValues setStringValueToUserDefaults:MM_DefaultDomain ForKey:MM_DomainName];
            [DefaultsValues setStringValueToUserDefaults:MM_DefaultImageFolder ForKey:MM_DomainImageFolder];
        }
    }
#endif
}

+(void)showAlert:(NSString*)title message:(NSString*)message
{
    if (IOS_NEWER_OR_EQUAL_TO_8) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
        //[viewController presentViewController:alert animated:YES completion:nil];
        [[self topViewController] presentViewController:alert animated:YES completion:nil];
    }
    /*else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }*/
}

+ (UIViewController*)topViewController
{
    return [self topViewControllerWithRootViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}

+ (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController
{
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController* tabBarController = (UITabBarController*)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController*)rootViewController;
        return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    } else {
        return rootViewController;
    }
}

+(void)adjustedgeLayout:(UIViewController *)view
{
    view.edgesForExtendedLayout = UIRectEdgeNone;
    view.navigationController.navigationBar.translucent = NO;
    view.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    view.view.backgroundColor = [UIColor whiteColor];//[UIColor colorWithRed:221.0f/255.0f green:221.0f/255.0f blue:221.0f/255.0f alpha:1];
    view.navigationController.navigationBar.barTintColor = navColor;
    view.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    view.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:18] ,NSFontAttributeName,[UIColor whiteColor],NSForegroundColorAttributeName,nil];//[UIFont fontWithName:@"HelveticaNeue-Bold" size:18]
    [self setFontforView:view.view andSubViews:YES];
}

+(void)setFontforView:(UIView*)view andSubViews:(BOOL)isSubViews
{
    if ([view isKindOfClass:[UILabel class]])
    {
        UILabel *lbl = (UILabel *)view;
        [lbl setFont:[self defaultFontWithSize:[[lbl font] pointSize]]];
    }
    else if ([view isKindOfClass:[UITextField class]])
    {
        UITextField *txt = (UITextField*)view;
        [self defaultSettingForTextField:txt];
        [txt setFont:[self defaultFontWithSize:[[txt font] pointSize]]];
    }
    else if ([view isKindOfClass:[UIButton class]])
    {
        UIButton *btn = (UIButton*)view;
        btn.titleLabel.font = [self defaultFontWithSize:[btn.titleLabel.font pointSize]];
    }
    
    if (isSubViews)
    {
        for (UIView *sview in view.subviews)
        {
            [self setFontforView:sview andSubViews:YES];
        }
    }
}

+(UIFont*)defaultFontWithSize:(CGFloat)size
{
    return [UIFont systemFontOfSize:size];//[UIFont fontWithName:@"STHeitiSC-Medium" size:size];
}

+(void)defaultSettingForTextField:(UITextField*)textField
{
//    textField.borderStyle = UITextBorderStyleNone;
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    textField.spellCheckingType = UITextSpellCheckingTypeNo;
}

+(void)setTextFieldBottomBorder:(UITextField*)textField
{
    if ([textField viewWithTag:200]) {
        [[textField viewWithTag:200] removeFromSuperview];
    }
    CGRect frame = textField.bounds;
    NSLog(@"frame: %@",NSStringFromCGRect(frame));
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height-0.5, frame.size.width, 0.5)];
    lbl.translatesAutoresizingMaskIntoConstraints = NO;
    lbl.backgroundColor = viewBorderColor;
    lbl.tag = 200;
    [textField addSubview:lbl];
    
    [textField addConstraint:[NSLayoutConstraint constraintWithItem:lbl attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:textField attribute:NSLayoutAttributeLeading multiplier:1 constant:0]];
    [textField addConstraint:[NSLayoutConstraint constraintWithItem:lbl attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:textField attribute:NSLayoutAttributeTrailing multiplier:1 constant:0]];
    [textField addConstraint:[NSLayoutConstraint constraintWithItem:lbl attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:textField attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    [lbl addConstraint:[NSLayoutConstraint constraintWithItem:lbl attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:0.5]];
    
    [self defaultSettingForTextField:textField];
}

//+(NSMutableArray*)getMenuList
//{
    /*day in/out
     - tour plan
     - daily activity report
     - expense
     - customer
     - distributor*/
    
//    NSString *text = ([ShareInfo sharedManagerInfo].isDayIn) ? @"Day Out" : @"Day In";
//    NSMutableArray *menuList = [NSMutableArray arrayWithCapacity:0];
//
//#if MERILINTERNATIONAL_VERSION
//    menuList = [NSMutableArray arrayWithObjects:
//                                [NSDictionary dictionaryWithObjectsAndKeys:@"camera",MM_Icon,@"Attendance",MM_Title,MM_MenuDayINOut,MM_MenuId, nil],
//                                [NSDictionary dictionaryWithObjectsAndKeys:@"camera",MM_Icon,@"Tour Plan",MM_Title,MM_MenuTourPlan,MM_MenuId, nil],
//                                [NSDictionary dictionaryWithObjectsAndKeys:@"camera",MM_Icon,@"Daily Activity Report",MM_Title,MM_MenuDailyActivityReport,MM_MenuId, nil],
//                                [NSDictionary dictionaryWithObjectsAndKeys:@"camera",MM_Icon,@"Travel Expense",MM_Title,MM_MenuTravaelExpense,MM_MenuId, nil],
//                                [NSDictionary dictionaryWithObjectsAndKeys:@"camera",MM_Icon,@"Customer",MM_Title,MM_MenuCustomerID,MM_MenuId, nil],
//                                [NSDictionary dictionaryWithObjectsAndKeys:@"camera",MM_Icon,@"Distributor",MM_Title,MM_MenuDistributorID,MM_MenuId, nil],
//                                nil];
//#else
//    menuList = [NSMutableArray arrayWithObjects:
//                [NSDictionary dictionaryWithObjectsAndKeys:@"img_calendar", MM_Icon, @"Attendance", MM_Title, MM_MenuDayINOut, MM_MenuId, nil],
//                [NSDictionary dictionaryWithObjectsAndKeys:@"img_visit_blue", MM_Icon, @"Tour Plan", MM_Title, MM_MenuTourPlan, MM_MenuId, nil],
//                [NSDictionary dictionaryWithObjectsAndKeys:@"img_checkin", MM_Icon, @"Check In", MM_Title, MM_MenuCheckIn, MM_MenuId, nil],
//                [NSDictionary dictionaryWithObjectsAndKeys:@"img_activity_report", MM_Icon, @"Daily Activity Report", MM_Title, MM_MenuDailyActivityReport, MM_MenuId, nil],
//                [NSDictionary dictionaryWithObjectsAndKeys:@"img_order_invoice", MM_Icon, @"Order List", MM_Title, MM_MenuOrderList, MM_MenuId, nil],
//                [NSDictionary dictionaryWithObjectsAndKeys:@"img_expense", MM_Icon, @"Travel Expense", MM_Title, MM_MenuTravaelExpense, MM_MenuId, nil],
//                [NSDictionary dictionaryWithObjectsAndKeys:@"img_approval", MM_Icon, @"Approval", MM_Title, MM_MenuApproval, MM_MenuId, nil],
//                [NSDictionary dictionaryWithObjectsAndKeys:@"img_leave", MM_Icon, @"Leave", MM_Title, MM_MenuLeave, MM_MenuId, nil],
//                [NSDictionary dictionaryWithObjectsAndKeys:@"img_sync", MM_Icon, @"Sales Master Sync", MM_Title, MM_MenuSync, MM_MenuId, nil],
//                nil];
//#endif
//    return menuList;
//}

+(UIBarButtonItem*)getBackButton:(UIViewController*)controller
{
//    UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_back"] style:UIBarButtonItemStylePlain target:controller action:action];//[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:controller action:action];//
    
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    controller.navigationItem.backBarButtonItem = backBtn;
    return backBtn;
}

+(BOOL)checkForConnection
{
    Reachability* reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    NetworkStatus remoteHostStatus = [reachability currentReachabilityStatus];
    if(remoteHostStatus == NotReachable)
    {
        return NO;
    }
    else if (remoteHostStatus == ReachableViaWiFi)
    {
        NSLog(@"wifi connection");
    }
    //else if (remoteHostStatus == ReachableViaCarrierDataNetwork)
    else if (remoteHostStatus == ReachableViaWWAN)
    {
        NSLog(@"cell WWAN");
    }
    return YES;
}

+(NSDate*)getFirstDateofMonth:(NSDate*)today
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *components = [gregorian components:(NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth) fromDate:today];
    components.day = 1;
    
    NSDate *date = [gregorian dateFromComponents:components];
    NSLog(@"date: %@",date);
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
    
    return date;
}

+(NSDate*)addDaysToDate:(NSDate*)today noofDays:(NSInteger)days
{
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setDay:days];
    NSDate *endDate = [[NSCalendar currentCalendar] dateByAddingComponents:offsetComponents toDate:today options:0];
    return endDate;
}

+(NSInteger)getDayDifference:(NSDate*)fromDate toDate:(NSDate*)toDate
{
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:fromDate toDate:toDate options:0];
    NSInteger days = [comp day];
    return days;
}

+(NSString*)getStringFromDate:(NSDate*)date formatter:(NSString*)formatter
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.locale = [NSLocale localeWithLocaleIdentifier:NSLocale.currentLocale.localeIdentifier];
    format.timeZone = [NSTimeZone timeZoneWithName:NSTimeZone.localTimeZone.name];
    [format setDateFormat:formatter];
    return [format stringFromDate:date];
}

+(NSDate*)getDateFromString:(NSString*)string formatter:(NSString*)formatter
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:formatter];
    format.locale = [NSLocale localeWithLocaleIdentifier:NSLocale.currentLocale.localeIdentifier];
    format.timeZone = [NSTimeZone timeZoneWithName:NSTimeZone.localTimeZone.name];
    NSDate *date = [format dateFromString:string];
    return date;
}

//- (NSString *) stringWithFormat: (NSString *) format
//{
//    NSDateFormatter *formatter = [NSDateFormatter new];
//    formatter.dateFormat = format;
//    formatter.locale = [NSLocale localeWithLocaleIdentifier:NSLocale.currentLocale.localeIdentifier];
//    formatter.timeZone = [NSTimeZone timeZoneWithName:NSTimeZone.localTimeZone.name];
//    NSString *strDate = [formatter stringFromDate:self];
//    return strDate;
//}

+(BOOL)date:(NSDate*)date isBetweenDate:(NSDate*)beginDate andDate:(NSDate*)endDate {
    return (([date compare:beginDate] != NSOrderedAscending) && ([date compare:endDate] != NSOrderedDescending));
}

+(void)BorderedButton:(UIButton*)button borderColor:(UIColor*)color thickness:(CGFloat)height
{
//    button.backgroundColor = [UIColor clearColor];
//    [button setTitleColor:color forState:UIControlStateNormal];
    button.layer.borderColor = color.CGColor;
    button.layer.borderWidth = height;
    button.layer.cornerRadius = 3;
//    [button setTitleColor:color forState:UIControlStateNormal];
}

+(void)FilledButton:(UIButton*)button withCornerRadius:(CGFloat)radius
{
    button.backgroundColor = navColor;//sliderMenuColor;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    
    if (radius > 0) {
        button.layer.cornerRadius = radius;
    }
}

+(void)roundButton:(UIButton*)button withBackColor:(UIColor*)color
{
    button.layer.cornerRadius = button.frame.size.height/2;
    button.layer.shadowColor = [UIColor blackColor].CGColor;
    button.layer.shadowOpacity = 0.5;
    button.layer.shadowOffset = CGSizeMake(1, 2);
    [button setBackgroundColor:color];
    
}

+(void)disableButton:(UIButton*)button
{
    button.layer.cornerRadius = 5;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setBackgroundColor:disableColor];
}

+(void)addBorder:(UIRectEdge)edge forView:(UIView*)view withColor:(UIColor*)color thickness:(CGFloat)height withFrame:(CGRect)frame
{
    CALayer *border = [CALayer layer];
    
    CGFloat x = (frame.origin.x == 20) ? 20 : 0;
    
    switch (edge) {
        case UIRectEdgeTop:
            border.frame = CGRectMake(x, 0.5, CGRectGetWidth(frame), height);
            break;
        case UIRectEdgeBottom:
            border.frame = CGRectMake(x, CGRectGetHeight(frame) - height, CGRectGetWidth(frame), height);
            break;
        case UIRectEdgeLeft:
            border.frame = CGRectMake(0, 0, height, CGRectGetHeight(frame));
            break;
        case UIRectEdgeRight:
            border.frame = CGRectMake(CGRectGetWidth(frame) - height, 0, height, CGRectGetHeight(frame));
            break;
        default:
            break;
    }
    
    border.backgroundColor = color.CGColor;
    
    [view.layer addSublayer:border];
}

+(void)buttonWithRightView:(UIButton*)btn rightImage:(NSString*)name isRightAlign:(BOOL)flag
{
    if (![name isEqualToString:@""]) {

        [btn setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
        
        if (IOS_NEWER_OR_EQUAL_TO_9) {
            btn.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
            btn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
        }
        else
        {
            btn.imageEdgeInsets = UIEdgeInsetsMake(0, btn.bounds.size.width - 15, 0, 0);
//        if (flag) {
            btn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 17);
//        }
//        else {
//            btn.titleEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
//        }
//        btn.titleEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
//            btn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 17);
        }
    }
    else
        [btn setImage:nil forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    btn.titleLabel.textAlignment = NSTextAlignmentLeft;
}

+(void)TextFieldRightImage:(UITextField*)txt withImageName:(NSString*)name
{
    UIImageView *rightImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:name]];
    rightImageView.contentMode = UIViewContentModeCenter;
    rightImageView.frame = CGRectMake(0, 0, 20, 20);
    txt.rightViewMode = UITextFieldViewModeAlways;
    txt.rightView = rightImageView;//lbl;//
}


+ (UIColor *)colorFromHexString:(NSString *)hexString {
    if(hexString.length == 0){
        return nil;
    }
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    if ([[hexString substringToIndex:1] isEqualToString:@"#"]) {
        [scanner setScanLocation:1]; // bypass '#' character
    }
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

+(void)defaultLabelFontSize:(UIView*)view fontSize:(CGFloat)size
{
    if ([view isKindOfClass:[UILabel class]])
    {
        UILabel *lbl = (UILabel *)view;
        [lbl setFont:[self defaultFontWithSize:size]];
    }
    else if ([view isKindOfClass:[UITextField class]])
    {
        UITextField *txt = (UITextField*)view;
        [self defaultSettingForTextField:txt];
        [txt setFont:[self defaultFontWithSize:size]];
    }
    else if ([view isKindOfClass:[UITextView class]])
    {
        UITextView *txt = (UITextView*)view;
        [txt setFont:[self defaultFontWithSize:size]];
    }
    else if ([view isKindOfClass:[UIButton class]])
    {
        UIButton *btn = (UIButton*)view;
        btn.titleLabel.font = [self defaultFontWithSize:size];
    }
    
    for (UIView *sview in view.subviews)
    {
        [self defaultLabelFontSize:sview fontSize:size];
    }
    
}

+(void)displaytoastAlert:(NSString *)str
{
    
    iToastSettings *theSettings = [iToastSettings getSharedSettings];
    [theSettings setDuration:2000];
    [[iToast makeText:str] show];
}


+(CGFloat)heightOfTextForString:(NSString *)aString andFont:(UIFont *)aFont maxSize:(CGSize)aSize
{
    CGSize sizeOfText = [aString boundingRectWithSize: aSize
                                              options: (NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                           attributes: [NSDictionary dictionaryWithObject:aFont
                                                                                   forKey:NSFontAttributeName]
                                              context: nil].size;
    //NSLog(@"sizeOfText:%f",sizeOfText.width);
    return ceilf(sizeOfText.height);
}

+ (void) delayCallback: (void(^)(void))callback forTotalSeconds: (double)delayInSeconds{
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        if(callback){
            callback();
        }
    });
}

+(void)displayToastAlertAtBottom:(NSString *)str{
    iToastSettings *theSettings = [iToastSettings getSharedSettings];
    [theSettings setDuration:2000];
    [theSettings setGravity:iToastGravityBottom];
    [[iToast makeText:str] show];
}

@end
