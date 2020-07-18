//
//	M_CartData.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "M_CartData.h"

NSString *const kM_CartDataCartAmountDetail = @"CartAmountDetail";
NSString *const kM_CartDataCartDetails = @"CartDetails";
NSString *const kM_CartDataCompanyId = @"CompanyId";
NSString *const kM_CartDataCreatedBy = @"CreatedBy";
NSString *const kM_CartDataCreatedDate = @"CreatedDate";
NSString *const kM_CartDataDispatchTypeId = @"DispatchTypeId";
NSString *const kM_CartDataDistributorId = @"DistributorId";
NSString *const kM_CartDataExpectedDeliveryDate = @"ExpectedDeliveryDate";
NSString *const kM_CartDataModifiedBy = @"ModifiedBy";
NSString *const kM_CartDataModifiedDate = @"ModifiedDate";
NSString *const kM_CartDataNoOfProducts = @"NoOfProducts";
NSString *const kM_CartDataOrderAchievementID = @"OrderAchievementID";
NSString *const kM_CartDataPersonId = @"PersonId";
NSString *const kM_CartDataSalesPersonDiscountAmt = @"SalesPersonDiscountAmt";
NSString *const kM_CartDataSalesPersonDiscountPerc = @"SalesPersonDiscountPerc";
NSString *const kM_CartDataSupplierId = @"SupplierId";
NSString *const kM_CartDataUserCartId = @"UserCartId";

NSString *const kM_CartDataFreight = @"Freight";
NSString *const kM_CartDataFreightApplicable = @"FreightApplicable";
NSString *const kM_CartDataOrderAchievementName = @"OrderAchievementName";
NSString *const kM_CartDataSupplierName = @"SupplierName";
NSString *const kM_CartDataDispatchTypeName = @"DispatchTypeName";
NSString *const kM_CartDataPriceInclusiveTax = @"priceinclusivetax";

@interface M_CartData ()
@end
@implementation M_CartData

/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kM_CartDataCartAmountDetail] isKindOfClass:[NSNull class]]){
		self.cartAmountDetail = [[M_CartAmountDetail alloc] initWithDictionary:dictionary[kM_CartDataCartAmountDetail]];
	}

	if(dictionary[kM_CartDataCartDetails] != nil && [dictionary[kM_CartDataCartDetails] isKindOfClass:[NSArray class]]){
		NSArray * cartDetailsDictionaries = dictionary[kM_CartDataCartDetails];
		NSMutableArray * cartDetailsItems = [NSMutableArray array];
		for(NSDictionary * cartDetailsDictionary in cartDetailsDictionaries){
			M_CartDetail * cartDetailsItem = [[M_CartDetail alloc] initWithDictionary:cartDetailsDictionary];
			[cartDetailsItems addObject:cartDetailsItem];
		}
		self.cartDetails = cartDetailsItems;
	}
	if(![dictionary[kM_CartDataCompanyId] isKindOfClass:[NSNull class]]){
		self.companyId = [dictionary[kM_CartDataCompanyId] integerValue];
	}

	if(![dictionary[kM_CartDataCreatedBy] isKindOfClass:[NSNull class]]){
		self.createdBy = [dictionary[kM_CartDataCreatedBy] integerValue];
	}

	if(![dictionary[kM_CartDataCreatedDate] isKindOfClass:[NSNull class]]){
		self.createdDate = dictionary[kM_CartDataCreatedDate];
	}	
	if(![dictionary[kM_CartDataDispatchTypeId] isKindOfClass:[NSNull class]]){
		self.dispatchTypeId = [dictionary[kM_CartDataDispatchTypeId] integerValue];
	}

	if(![dictionary[kM_CartDataDistributorId] isKindOfClass:[NSNull class]]){
		self.distributorId = dictionary[kM_CartDataDistributorId];
	}	
	if(![dictionary[kM_CartDataExpectedDeliveryDate] isKindOfClass:[NSNull class]]){
		self.expectedDeliveryDate = dictionary[kM_CartDataExpectedDeliveryDate];
	}

	if(![dictionary[kM_CartDataModifiedBy] isKindOfClass:[NSNull class]]){
		self.modifiedBy = [dictionary[kM_CartDataModifiedBy] integerValue];
	}

	if(![dictionary[kM_CartDataModifiedDate] isKindOfClass:[NSNull class]]){
		self.modifiedDate = dictionary[kM_CartDataModifiedDate];
	}	
	if(![dictionary[kM_CartDataNoOfProducts] isKindOfClass:[NSNull class]]){
		self.noOfProducts = [dictionary[kM_CartDataNoOfProducts] integerValue];
	}

	if(![dictionary[kM_CartDataOrderAchievementID] isKindOfClass:[NSNull class]]){
		self.orderAchievementID = [dictionary[kM_CartDataOrderAchievementID] integerValue];
	}

	if(![dictionary[kM_CartDataPersonId] isKindOfClass:[NSNull class]]){
		self.personId = [dictionary[kM_CartDataPersonId] integerValue];
	}

	if(![dictionary[kM_CartDataSalesPersonDiscountAmt] isKindOfClass:[NSNull class]]){
		self.salesPersonDiscountAmt = [dictionary[kM_CartDataSalesPersonDiscountAmt] floatValue];
	}

	if(![dictionary[kM_CartDataSalesPersonDiscountPerc] isKindOfClass:[NSNull class]]){
		self.salesPersonDiscountPerc = [dictionary[kM_CartDataSalesPersonDiscountPerc] floatValue];
	}

	if(![dictionary[kM_CartDataSupplierId] isKindOfClass:[NSNull class]]){
		self.supplierId = [dictionary[kM_CartDataSupplierId] integerValue];
	}

	if(![dictionary[kM_CartDataUserCartId] isKindOfClass:[NSNull class]]){
		self.userCartId = [dictionary[kM_CartDataUserCartId] integerValue];
	}
    
    
    if(![dictionary[kM_CartDataFreight] isKindOfClass:[NSNull class]]){
        self.freight = dictionary[kM_CartDataFreight];
    }
    
    if(![dictionary[kM_CartDataFreightApplicable] isKindOfClass:[NSNull class]]){
        self.freightApplicable = [dictionary[kM_CartDataFreightApplicable] boolValue];
    }
    
    if(![dictionary[kM_CartDataOrderAchievementName] isKindOfClass:[NSNull class]]){
        self.orderAchievementName = dictionary[kM_CartDataOrderAchievementName];
    }
    
    if(![dictionary[kM_CartDataSupplierName] isKindOfClass:[NSNull class]]){
        self.supplierName = dictionary[kM_CartDataSupplierName];
    }
    
    if(![dictionary[kM_CartDataDispatchTypeName] isKindOfClass:[NSNull class]]){
        self.dispatchTypeName = dictionary[kM_CartDataDispatchTypeName];
    }
    
    if(![dictionary[kM_CartDataPriceInclusiveTax] isKindOfClass:[NSNull class]]){
        self.priceinclusivetax = [dictionary[kM_CartDataPriceInclusiveTax] boolValue];
    }

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.cartAmountDetail != nil){
		dictionary[kM_CartDataCartAmountDetail] = [self.cartAmountDetail toDictionary];
	}
	if(self.cartDetails != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(M_CartDetail * cartDetailsElement in self.cartDetails){
			[dictionaryElements addObject:[cartDetailsElement toDictionary]];
		}
		dictionary[kM_CartDataCartDetails] = dictionaryElements;
	}
	dictionary[kM_CartDataCompanyId] = @(self.companyId);
	dictionary[kM_CartDataCreatedBy] = @(self.createdBy);
	if(self.createdDate != nil){
		dictionary[kM_CartDataCreatedDate] = self.createdDate;
	}
	dictionary[kM_CartDataDispatchTypeId] = @(self.dispatchTypeId);
	if(self.distributorId != nil){
		dictionary[kM_CartDataDistributorId] = self.distributorId;
	}
	if(self.expectedDeliveryDate != nil){
		dictionary[kM_CartDataExpectedDeliveryDate] = self.expectedDeliveryDate;
	}
	dictionary[kM_CartDataModifiedBy] = @(self.modifiedBy);
	if(self.modifiedDate != nil){
		dictionary[kM_CartDataModifiedDate] = self.modifiedDate;
	}
	dictionary[kM_CartDataNoOfProducts] = @(self.noOfProducts);
	dictionary[kM_CartDataOrderAchievementID] = @(self.orderAchievementID);
	dictionary[kM_CartDataPersonId] = @(self.personId);
	dictionary[kM_CartDataSalesPersonDiscountAmt] = @(self.salesPersonDiscountAmt);
	dictionary[kM_CartDataSalesPersonDiscountPerc] = @(self.salesPersonDiscountPerc);
	dictionary[kM_CartDataSupplierId] = @(self.supplierId);
	dictionary[kM_CartDataUserCartId] = @(self.userCartId);
    
    if(self.freight != nil){
        dictionary[kM_CartDataFreight] = self.freight;
    }
    dictionary[kM_CartDataFreightApplicable] = @(self.freightApplicable);
    if(self.orderAchievementName != nil){
        dictionary[kM_CartDataOrderAchievementName] = self.orderAchievementName;
    }
    if(self.supplierName != nil){
        dictionary[kM_CartDataSupplierName] = self.supplierName;
    }
    if(self.dispatchTypeName != nil){
        dictionary[kM_CartDataDispatchTypeName ] = self.dispatchTypeName;
    }
    dictionary[kM_CartDataPriceInclusiveTax] = @(self.priceinclusivetax);
    
	return dictionary;

}

/**
 * Implementation of NSCoding encoding method
 */
/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
	if(self.cartAmountDetail != nil){
		[aCoder encodeObject:self.cartAmountDetail forKey:kM_CartDataCartAmountDetail];
	}
	if(self.cartDetails != nil){
		[aCoder encodeObject:self.cartDetails forKey:kM_CartDataCartDetails];
	}
	[aCoder encodeObject:@(self.companyId) forKey:kM_CartDataCompanyId];	[aCoder encodeObject:@(self.createdBy) forKey:kM_CartDataCreatedBy];	if(self.createdDate != nil){
		[aCoder encodeObject:self.createdDate forKey:kM_CartDataCreatedDate];
	}
	[aCoder encodeObject:@(self.dispatchTypeId) forKey:kM_CartDataDispatchTypeId];	if(self.distributorId != nil){
		[aCoder encodeObject:self.distributorId forKey:kM_CartDataDistributorId];
	}
	if(self.expectedDeliveryDate != nil){
		[aCoder encodeObject:self.expectedDeliveryDate forKey:kM_CartDataExpectedDeliveryDate];
	}
	[aCoder encodeObject:@(self.modifiedBy) forKey:kM_CartDataModifiedBy];	if(self.modifiedDate != nil){
		[aCoder encodeObject:self.modifiedDate forKey:kM_CartDataModifiedDate];
	}
	[aCoder encodeObject:@(self.noOfProducts) forKey:kM_CartDataNoOfProducts];	[aCoder encodeObject:@(self.orderAchievementID) forKey:kM_CartDataOrderAchievementID];	[aCoder encodeObject:@(self.personId) forKey:kM_CartDataPersonId];	[aCoder encodeObject:@(self.salesPersonDiscountAmt) forKey:kM_CartDataSalesPersonDiscountAmt];	[aCoder encodeObject:@(self.salesPersonDiscountPerc) forKey:kM_CartDataSalesPersonDiscountPerc];	[aCoder encodeObject:@(self.supplierId) forKey:kM_CartDataSupplierId];	[aCoder encodeObject:@(self.userCartId) forKey:kM_CartDataUserCartId];
    
    if(self.freight != nil){
        [aCoder encodeObject:self.freight forKey:kM_CartDataFreight];
    }
    [aCoder encodeObject:@(self.freightApplicable) forKey:kM_CartDataFreightApplicable];
    if(self.orderAchievementName != nil){
        [aCoder encodeObject:self.orderAchievementName forKey:kM_CartDataOrderAchievementName];
    }
    if(self.supplierName != nil){
        [aCoder encodeObject:self.supplierName forKey:kM_CartDataSupplierName];
    }
    if(self.dispatchTypeName != nil){
        [aCoder encodeObject:self.dispatchTypeName forKey:kM_CartDataDispatchTypeName];
    }
    [aCoder encodeObject:@(self.priceinclusivetax) forKey:kM_CartDataPriceInclusiveTax];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.cartAmountDetail = [aDecoder decodeObjectForKey:kM_CartDataCartAmountDetail];
	self.cartDetails = [aDecoder decodeObjectForKey:kM_CartDataCartDetails];
	self.companyId = [[aDecoder decodeObjectForKey:kM_CartDataCompanyId] integerValue];
	self.createdBy = [[aDecoder decodeObjectForKey:kM_CartDataCreatedBy] integerValue];
	self.createdDate = [aDecoder decodeObjectForKey:kM_CartDataCreatedDate];
	self.dispatchTypeId = [[aDecoder decodeObjectForKey:kM_CartDataDispatchTypeId] integerValue];
	self.distributorId = [aDecoder decodeObjectForKey:kM_CartDataDistributorId];
	self.expectedDeliveryDate = [aDecoder decodeObjectForKey:kM_CartDataExpectedDeliveryDate];
	self.modifiedBy = [[aDecoder decodeObjectForKey:kM_CartDataModifiedBy] integerValue];
	self.modifiedDate = [aDecoder decodeObjectForKey:kM_CartDataModifiedDate];
	self.noOfProducts = [[aDecoder decodeObjectForKey:kM_CartDataNoOfProducts] integerValue];
	self.orderAchievementID = [[aDecoder decodeObjectForKey:kM_CartDataOrderAchievementID] integerValue];
	self.personId = [[aDecoder decodeObjectForKey:kM_CartDataPersonId] integerValue];
	self.salesPersonDiscountAmt = [[aDecoder decodeObjectForKey:kM_CartDataSalesPersonDiscountAmt] floatValue];
	self.salesPersonDiscountPerc = [[aDecoder decodeObjectForKey:kM_CartDataSalesPersonDiscountPerc] floatValue];
	self.supplierId = [[aDecoder decodeObjectForKey:kM_CartDataSupplierId] integerValue];
	self.userCartId = [[aDecoder decodeObjectForKey:kM_CartDataUserCartId] integerValue];
    
    self.freight = [aDecoder decodeObjectForKey:kM_CartDataFreight];
    self.freightApplicable = [[aDecoder decodeObjectForKey:kM_CartDataFreightApplicable] boolValue];
    self.orderAchievementName = [aDecoder decodeObjectForKey:kM_CartDataOrderAchievementName];
    self.supplierName = [aDecoder decodeObjectForKey:kM_CartDataSupplierName];
    self.dispatchTypeName = [aDecoder decodeObjectForKey:kM_CartDataDispatchTypeName];
    self.priceinclusivetax = [[aDecoder decodeObjectForKey:kM_CartDataPriceInclusiveTax] boolValue];
    
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	M_CartData *copy = [M_CartData new];

	copy.cartAmountDetail = [self.cartAmountDetail copy];
	copy.cartDetails = [self.cartDetails copy];
	copy.companyId = self.companyId;
	copy.createdBy = self.createdBy;
	copy.createdDate = [self.createdDate copy];
	copy.dispatchTypeId = self.dispatchTypeId;
	copy.distributorId = [self.distributorId copy];
	copy.expectedDeliveryDate = [self.expectedDeliveryDate copy];
	copy.modifiedBy = self.modifiedBy;
	copy.modifiedDate = [self.modifiedDate copy];
	copy.noOfProducts = self.noOfProducts;
	copy.orderAchievementID = self.orderAchievementID;
	copy.personId = self.personId;
	copy.salesPersonDiscountAmt = self.salesPersonDiscountAmt;
	copy.salesPersonDiscountPerc = self.salesPersonDiscountPerc;
	copy.supplierId = self.supplierId;
	copy.userCartId = self.userCartId;
    
    copy.freight = [self.freight copy];
    copy.freightApplicable = self.freightApplicable;
    copy.orderAchievementName = [self.orderAchievementName copy];
    copy.supplierName = [self.supplierName copy];
    copy.dispatchTypeName = [self.dispatchTypeName copy];
    copy.priceinclusivetax = self.priceinclusivetax;

	return copy;
}
@end
