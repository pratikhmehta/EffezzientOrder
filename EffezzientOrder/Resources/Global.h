//
//  Global.h
//  ImageVideoApp
//
//  Created by Manish Patel on 20/04/16.
//  Copyright © 2016 Manish Patel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface Global : NSObject

+ (void)setupDomainUrl;

+(CGRect)screenSize;
+(void)showAlert:(NSString*)title message:(NSString*)message;
+ (UIViewController*)topViewController;
+ (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController;
+(void)adjustedgeLayout:(UIViewController *)view;

+(void)setTextFieldBottomBorder:(UITextField*)textField;
//+(NSMutableArray*)getMenuList;
//+(UIBarButtonItem*)getBackButton:(SEL)action target:(UIViewController*)controller;
+(UIBarButtonItem*)getBackButton:(UIViewController*)controller;
+(BOOL)checkForConnection;
+(NSDate*)getFirstDateofMonth:(NSDate*)today;
+(NSDate*)addDaysToDate:(NSDate*)today noofDays:(NSInteger)days;
+(NSInteger)getDayDifference:(NSDate*)fromDate toDate:(NSDate*)toDate;

+(NSString*)getStringFromDate:(NSDate*)date formatter:(NSString*)formatter;
+(NSDate*)getDateFromString:(NSString*)string formatter:(NSString*)formatter;
//- (NSString *) stringWithFormat: (NSString *) format;


+ (BOOL) date:(NSDate*)date isBetweenDate:(NSDate*)beginDate andDate:(NSDate*)endDate;
+(void)BorderedButton:(UIButton*)button borderColor:(UIColor*)color thickness:(CGFloat)height;
+(void)FilledButton:(UIButton*)button withCornerRadius:(CGFloat)radius;
+(void)roundButton:(UIButton*)button withBackColor:(UIColor*)color;
+(void)disableButton:(UIButton*)button;

+(void)addBorder:(UIRectEdge)edge forView:(UIView*)view withColor:(UIColor*)color thickness:(CGFloat)height withFrame:(CGRect)frame;
+(void)buttonWithRightView:(UIButton*)btn rightImage:(NSString*)name isRightAlign:(BOOL)flag;
+(void)TextFieldRightImage:(UITextField*)txt withImageName:(NSString*)name;
+(UIColor *)colorFromHexString:(NSString *)hexString;

+(void)setFontforView:(UIView*)view andSubViews:(BOOL)isSubViews;
+(UIFont*)defaultFontWithSize:(CGFloat)size;
+(void)defaultLabelFontSize:(UIView*)view fontSize:(CGFloat)size;
+(NSString*)getDocumentImageName:(NSString*)extension;

+(void)displaytoastAlert:(NSString *)str;

+ (NSString *)createUUID;
+(CGFloat)heightOfTextForString:(NSString *)aString andFont:(UIFont *)aFont maxSize:(CGSize)aSize;
+(void) delayCallback: (void(^)(void))callback forTotalSeconds: (double)delayInSeconds;
+(void)resetDefaults;
+(void)doLogout;

+(void)displayToastAlertAtBottom:(NSString *)str;

@end
