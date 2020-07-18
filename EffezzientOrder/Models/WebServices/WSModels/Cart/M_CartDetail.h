#import <UIKit/UIKit.h>
#import "M_ProductList.h"
#import "M_ProductSpec.h"
#import "M_TaxDetail.h"

@interface M_CartDetail : NSObject

@property (nonatomic, assign) NSInteger cartDetailId;
@property (nonatomic, strong) NSString * dateAdded;
@property (nonatomic, assign) CGFloat discountAmount;
@property (nonatomic, assign) CGFloat discountPerc;
@property (nonatomic, assign) NSInteger itemId;
@property (nonatomic, assign) CGFloat itemTotalTaxPerc;
@property (nonatomic, assign) CGFloat itemTotalTaxValue;
@property (nonatomic, assign) CGFloat originalPrice;
@property (nonatomic, strong) M_ProductList * productDetails;
@property (nonatomic, strong) NSArray * productVariant;
@property (nonatomic, assign) NSInteger productVariantId;
@property (nonatomic, assign) CGFloat quantity;
@property (nonatomic, assign) CGFloat sellingPrice;
@property (nonatomic, strong) NSArray * taxDetails;
@property (nonatomic, assign) CGFloat totalAmount;
@property (nonatomic, assign) NSInteger userCartId;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
