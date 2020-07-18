#import <UIKit/UIKit.h>

@interface M_DispatchType : NSObject

@property (nonatomic, assign) NSInteger dispatchTypeId;
@property (nonatomic, strong) NSString * dispatchTypeName;
@property (nonatomic, assign) BOOL freightApplicable;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end