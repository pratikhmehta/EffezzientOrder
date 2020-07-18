#import <UIKit/UIKit.h>

@interface M_CartCount : NSObject

@property (nonatomic, assign) NSInteger cartCount;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end