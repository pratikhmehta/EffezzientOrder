//
//  BaseVC.h
//  CPSServices
//
//  Created by apple on 8/31/17.
//  Copyright © 2017 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

@interface BaseVC : UIViewController

-(UIButton *) setNavigationLeftButtonWithImage : (NSString *) imageName;

-(void)addCustomLineToView : (NSArray *)views color : (UIColor *)color;

-(void)showAlertWithMessage : (NSString *)message;

-(NSString *)getDocumentDirectoryForAppMedia;
-(UIImage *)imageByScalingAndCroppingImage : (UIImage *)image forSize:(CGSize)targetSize;

-(NSString *)getFormattedAmount:(NSString *)amount;
-(void)openScheme:(NSString *)scheme;
-(void)sendSMSWithText:(NSString *)body andRecipients : (NSString *)recipient;

//- (void)requestCameraPermissions;
//-(void)checkAppVersion;

-(void)getAppConfig;
-(void)updateSyncConfig;
-(void)checkAppVersionWithCancelOption : (BOOL)allowLater andMessage : (NSString *)message;
-(void)logoutUserWithMessage:(NSString *)message acceptButton:(NSString *)yesOption cancelButton:(NSString *)cancelOption;

-(void)dismissKeyboard;
-(void)btnBack : (id)sender;
-(void)btnMenu : (id)sender;

+ (NSString *)getModel;

-(NSMutableArray *)setupCellControls : (NSMutableArray *)arrControls forCell:(UITableViewCell *)cell;
// CustomTableViewCell *

-(NSMutableArray *)getPriviledgedModules;

- (void)requestCameraPermissions;
- (void)requestPhotoLibraryPermissionsWithMessage:(NSString *)message;

//-(NSString *)roundDecimalValue : (NSDecimalNumber *)value withScale : (NSUInteger)scale andFormatterRoundingMode : (NSNumberFormatterRoundingMode)mode;
//-(NSString *)calculateUnitPriceAfterDiscountOnOriginalPrice : (NSDecimalNumber *)priceCart ofPercentage : (NSDecimalNumber *)percentage;
//-(NSString *)calculateDiscountAfterChangeInUnitPrice : (NSDecimalNumber *)changedPrice andOriginalPrice : (NSDecimalNumber *)orgUnitPrice;
//-(NSString *)calculateTotalProductPriceWithNoofPieces : (NSString *)noOfPieces quantity : (NSString *)qtyCart changedPrice : (NSDecimalNumber *)priceCart;

+ (NSDate *) localizedDateFromString:(NSString *)string withFormat:(NSString *)format;
+ (NSString *) stringFromDate:(NSDate *)date withFormat:(NSString *)format;

- (BOOL)hasTopNotch;
//-(void)redirectToDirectOrderForType:(NSString *)orderType;
//-(void)saveRandomCheckIn : (NSMutableDictionary *)checkInDic;

-(BOOL)isExtensionIsOfImage:(NSString *)extension;

//-(void)getLeadActivityListForLead:(NSString *)leadID andLeadActivityID:(NSString *)leadActivityID;
- (void)saveToAlbum:(UIImage *)image andFileURL:(NSURL *)videoURL;
//+ (NSString *)get_vCardFromCNContact:(CNContact *)cnContact;

@end
