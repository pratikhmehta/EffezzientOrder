#import <UIKit/UIKit.h>
#import "M_LandingItem.h"

@interface M_LandingSection : NSObject

@property (nonatomic, strong) NSArray * items;
@property (nonatomic, assign) CGFloat sectionHeight;
@property (nonatomic, assign) NSInteger sectionMarginBottom;
@property (nonatomic, assign) NSInteger sectionMarginLeft;
@property (nonatomic, assign) NSInteger sectionMarginRight;
@property (nonatomic, assign) NSInteger sectionMarginTop;
@property (nonatomic, strong) NSString * sectionType;
@property (nonatomic, strong) NSString * type;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
