#import <UIKit/UIKit.h>

@interface M_ProductExchangePolicy : NSObject

@property (nonatomic, strong) NSString * exchangePolicyDescription;
@property (nonatomic, strong) NSString * title;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
