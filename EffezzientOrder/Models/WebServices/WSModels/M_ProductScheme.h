#import <UIKit/UIKit.h>

@interface M_ProductScheme : NSObject

@property (nonatomic, strong) NSString * productSchemeDescription;
@property (nonatomic, strong) NSString * scheme;
@property (nonatomic, strong) NSString * schemedetail;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
