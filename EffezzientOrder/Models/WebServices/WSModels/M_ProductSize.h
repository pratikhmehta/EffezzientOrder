#import <UIKit/UIKit.h>

@interface M_ProductSize : NSObject

@property (nonatomic, assign) BOOL islimitedstock;
@property (nonatomic, assign) NSInteger sizeid;
@property (nonatomic, strong) NSString * sizename;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end