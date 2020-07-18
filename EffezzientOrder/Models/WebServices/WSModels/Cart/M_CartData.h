#import <UIKit/UIKit.h>
#import "M_CartAmountDetail.h"
#import "M_CartDetail.h"

@interface M_CartData : NSObject

@property (nonatomic, strong) M_CartAmountDetail * cartAmountDetail;
@property (nonatomic, strong) NSArray * cartDetails;
@property (nonatomic, assign) NSInteger companyId;
@property (nonatomic, assign) NSInteger createdBy;
@property (nonatomic, strong) NSString * createdDate;
@property (nonatomic, assign) NSInteger dispatchTypeId;
@property (nonatomic, strong) NSObject * distributorId;
@property (nonatomic, strong) NSString * expectedDeliveryDate;
@property (nonatomic, assign) NSInteger modifiedBy;
@property (nonatomic, strong) NSString * modifiedDate;
@property (nonatomic, assign) NSInteger noOfProducts;
@property (nonatomic, assign) NSInteger orderAchievementID;
@property (nonatomic, assign) NSInteger personId;
@property (nonatomic, assign) CGFloat salesPersonDiscountAmt;
@property (nonatomic, assign) CGFloat salesPersonDiscountPerc;
@property (nonatomic, assign) NSInteger supplierId;
@property (nonatomic, assign) NSInteger userCartId;

@property (nonatomic, strong) NSString * freight;
@property (nonatomic, assign) BOOL freightApplicable;
@property (nonatomic, strong) NSString * orderAchievementName;
@property (nonatomic, strong) NSString * supplierName;
@property (nonatomic, strong) NSString * dispatchTypeName;
@property (nonatomic, assign) BOOL priceinclusivetax;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
