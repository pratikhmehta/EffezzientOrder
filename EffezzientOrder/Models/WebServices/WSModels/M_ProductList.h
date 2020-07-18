#import <UIKit/UIKit.h>
#import "Cataloguedetail.h"

@interface M_ProductList : NSObject

@property (nonatomic, assign) NSInteger brandid;
@property (nonatomic, strong) NSString * brandname;
@property (nonatomic, assign) BOOL canaddtocart;
@property (nonatomic, strong) Cataloguedetail * cataloguedetail;
@property (nonatomic, assign) NSInteger categoryid;
@property (nonatomic, strong) NSString * categoryname;
@property (nonatomic, strong) NSString * coverimage;
@property (nonatomic, assign) CGFloat discount;
@property (nonatomic, assign) BOOL iscatalogue;
@property (nonatomic, assign) BOOL islimitedstock;
@property (nonatomic, assign) BOOL istrending;
@property (nonatomic, assign) BOOL iswishlisetd;
@property (nonatomic, assign) NSInteger itemid;
@property (nonatomic, strong) NSString * itemname;
@property (nonatomic, strong) NSString * longdescription;
@property (nonatomic, assign) CGFloat mrp;
@property (nonatomic, assign) CGFloat offerprice;
@property (nonatomic, assign) CGFloat productrating;
@property (nonatomic, strong) NSString * shortdescription;
@property (nonatomic, assign) CGFloat totalAmount;
@property (nonatomic, assign) NSInteger quantity;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
