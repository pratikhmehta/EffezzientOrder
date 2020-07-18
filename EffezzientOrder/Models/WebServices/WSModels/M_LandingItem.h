#import <UIKit/UIKit.h>

@interface M_LandingItem : NSObject

@property (nonatomic, strong) NSString * imageURL;
@property (nonatomic, assign) NSInteger itemHeight;
@property (nonatomic, assign) NSInteger itemWidth;
@property (nonatomic, strong) NSDictionary * passParams;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
