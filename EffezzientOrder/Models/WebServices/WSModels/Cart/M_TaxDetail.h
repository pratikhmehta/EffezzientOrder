#import <UIKit/UIKit.h>

@interface M_TaxDetail : NSObject

@property (nonatomic, strong) NSString * taxName;
@property (nonatomic, assign) CGFloat taxPerc;
@property (nonatomic, assign) CGFloat taxValue;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end