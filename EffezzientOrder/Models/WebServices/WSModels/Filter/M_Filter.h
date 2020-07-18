#import <UIKit/UIKit.h>
#import "M_FilterValues.h"

@interface M_Filter : NSObject

@property (nonatomic, strong) NSString * displayname;
@property (nonatomic, strong) NSString * filtercolumn;
@property (nonatomic, assign) BOOL searchboxvisible;
@property (nonatomic, strong) NSArray * selectedvalues;
@property (nonatomic, strong) NSString * selectiontype;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
