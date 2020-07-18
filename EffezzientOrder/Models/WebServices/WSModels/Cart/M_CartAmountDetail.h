#import <UIKit/UIKit.h>

@interface M_CartAmountDetail : NSObject

@property (nonatomic, assign) CGFloat cartDiscountAmt;
@property (nonatomic, assign) CGFloat cartDiscountPerc;
@property (nonatomic, assign) CGFloat finalAmount;
@property (nonatomic, assign) CGFloat grossAmount;
@property (nonatomic, assign) CGFloat netAmount;
@property (nonatomic, assign) CGFloat roundOff;
@property (nonatomic, assign) CGFloat taxAmount;
@property (nonatomic, assign) CGFloat totalAmount;
@property (nonatomic, assign) CGFloat totlItemDiscount;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end