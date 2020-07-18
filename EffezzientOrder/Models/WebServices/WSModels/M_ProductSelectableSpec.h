#import <UIKit/UIKit.h>

@interface M_ProductSelectableSpec : NSObject

@property (nonatomic, strong) NSString * selectedvalue;
@property (nonatomic, strong) NSString * specname;
@property (nonatomic, strong) NSArray * specvalues;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end