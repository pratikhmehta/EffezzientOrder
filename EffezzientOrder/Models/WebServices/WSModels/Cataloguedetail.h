#import <UIKit/UIKit.h>

@interface Cataloguedetail : NSObject

@property (nonatomic, assign) NSInteger noofdesigns;
@property (nonatomic, assign) BOOL singlepcsavailable;
@property (nonatomic, assign) CGFloat singlepcsdiscount;
@property (nonatomic, strong) NSString * singlepcsprice;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end