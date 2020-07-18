#import <UIKit/UIKit.h>

@interface M_FilterValues : NSObject

@property (nonatomic, strong) NSString * filtertype;
@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, assign) BOOL isselected;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, assign) NSInteger total;
@property (nonatomic, strong) NSString * value;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end