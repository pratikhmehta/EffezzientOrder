#import <UIKit/UIKit.h>
#import "M_ProductScheme.h"
#import "M_ProductExchangePolicy.h"

@interface M_ProductDetails : NSObject

@property (nonatomic, strong) NSArray * availableschemes;
@property (nonatomic, strong) NSArray * exchangepolicy;
@property (nonatomic, assign) NSInteger maxqtyallowed;
@property (nonatomic, assign) BOOL priceinclusivetax;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
