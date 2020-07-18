#import <UIKit/UIKit.h>

@interface M_ProductSpec : NSObject

@property (nonatomic, strong) NSString * specname;
@property (nonatomic, strong) NSString * specvalue;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end