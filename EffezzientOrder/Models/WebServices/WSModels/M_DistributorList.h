#import <UIKit/UIKit.h>

@interface M_DistributorList : NSObject

@property (nonatomic, strong) NSString * address;
@property (nonatomic, assign) NSInteger distributorID;
@property (nonatomic, strong) NSString * distributorName;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end