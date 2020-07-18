//
//	M_CartDetail.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "M_CartDetail.h"

NSString *const kM_CartDetailCartDetailId = @"CartDetailId";
NSString *const kM_CartDetailDateAdded = @"DateAdded";
NSString *const kM_CartDetailDiscountAmount = @"DiscountAmount";
NSString *const kM_CartDetailDiscountPerc = @"DiscountPerc";
NSString *const kM_CartDetailItemId = @"ItemId";
NSString *const kM_CartDetailItemTotalTaxPerc = @"ItemTotalTaxPerc";
NSString *const kM_CartDetailItemTotalTaxValue = @"ItemTotalTaxValue";
NSString *const kM_CartDetailOriginalPrice = @"OriginalPrice";
NSString *const kM_CartDetailProductDetails = @"ProductDetails";
NSString *const kM_CartDetailProductVariant = @"ProductVariant";
NSString *const kM_CartDetailProductVariantId = @"ProductVariantId";
NSString *const kM_CartDetailQuantity = @"Quantity";
NSString *const kM_CartDetailSellingPrice = @"SellingPrice";
NSString *const kM_CartDetailTaxDetails = @"TaxDetails";
NSString *const kM_CartDetailTotalAmount = @"TotalAmount";
NSString *const kM_CartDetailUserCartId = @"UserCartId";

@interface M_CartDetail ()
@end
@implementation M_CartDetail




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kM_CartDetailCartDetailId] isKindOfClass:[NSNull class]]){
		self.cartDetailId = [dictionary[kM_CartDetailCartDetailId] integerValue];
	}

	if(![dictionary[kM_CartDetailDateAdded] isKindOfClass:[NSNull class]]){
		self.dateAdded = dictionary[kM_CartDetailDateAdded];
	}	
	if(![dictionary[kM_CartDetailDiscountAmount] isKindOfClass:[NSNull class]]){
		self.discountAmount = [dictionary[kM_CartDetailDiscountAmount] floatValue];
	}

	if(![dictionary[kM_CartDetailDiscountPerc] isKindOfClass:[NSNull class]]){
		self.discountPerc = [dictionary[kM_CartDetailDiscountPerc] floatValue];
	}	
	if(![dictionary[kM_CartDetailItemId] isKindOfClass:[NSNull class]]){
		self.itemId = [dictionary[kM_CartDetailItemId] integerValue];
	}

	if(![dictionary[kM_CartDetailItemTotalTaxPerc] isKindOfClass:[NSNull class]]){
		self.itemTotalTaxPerc = [dictionary[kM_CartDetailItemTotalTaxPerc] floatValue];
	}

	if(![dictionary[kM_CartDetailItemTotalTaxValue] isKindOfClass:[NSNull class]]){
		self.itemTotalTaxValue = [dictionary[kM_CartDetailItemTotalTaxValue] floatValue];
	}

	if(![dictionary[kM_CartDetailOriginalPrice] isKindOfClass:[NSNull class]]){
		self.originalPrice = [dictionary[kM_CartDetailOriginalPrice] floatValue];
	}

	if(![dictionary[kM_CartDetailProductDetails] isKindOfClass:[NSNull class]]){
		self.productDetails = [[M_ProductList alloc] initWithDictionary:dictionary[kM_CartDetailProductDetails]];
	}

	if(dictionary[kM_CartDetailProductVariant] != nil && [dictionary[kM_CartDetailProductVariant] isKindOfClass:[NSArray class]]){
		NSArray * productVariantDictionaries = dictionary[kM_CartDetailProductVariant];
		NSMutableArray * productVariantItems = [NSMutableArray array];
		for(NSDictionary * productVariantDictionary in productVariantDictionaries){
			M_ProductSpec * productVariantItem = [[M_ProductSpec alloc] initWithDictionary:productVariantDictionary];
			[productVariantItems addObject:productVariantItem];
		}
		self.productVariant = productVariantItems;
	}
	if(![dictionary[kM_CartDetailProductVariantId] isKindOfClass:[NSNull class]]){
		self.productVariantId = [dictionary[kM_CartDetailProductVariantId] integerValue];
	}

	if(![dictionary[kM_CartDetailQuantity] isKindOfClass:[NSNull class]]){
		self.quantity = [dictionary[kM_CartDetailQuantity] floatValue];
	}

	if(![dictionary[kM_CartDetailSellingPrice] isKindOfClass:[NSNull class]]){
		self.sellingPrice = [dictionary[kM_CartDetailSellingPrice] floatValue];
	}

	if(dictionary[kM_CartDetailTaxDetails] != nil && [dictionary[kM_CartDetailTaxDetails] isKindOfClass:[NSArray class]]){
		NSArray * taxDetailsDictionaries = dictionary[kM_CartDetailTaxDetails];
		NSMutableArray * taxDetailsItems = [NSMutableArray array];
		for(NSDictionary * taxDetailsDictionary in taxDetailsDictionaries){
			M_TaxDetail * taxDetailsItem = [[M_TaxDetail alloc] initWithDictionary:taxDetailsDictionary];
			[taxDetailsItems addObject:taxDetailsItem];
		}
		self.taxDetails = taxDetailsItems;
	}
	if(![dictionary[kM_CartDetailTotalAmount] isKindOfClass:[NSNull class]]){
		self.totalAmount = [dictionary[kM_CartDetailTotalAmount] floatValue];
	}

	if(![dictionary[kM_CartDetailUserCartId] isKindOfClass:[NSNull class]]){
		self.userCartId = [dictionary[kM_CartDetailUserCartId] integerValue];
	}

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	dictionary[kM_CartDetailCartDetailId] = @(self.cartDetailId);
	if(self.dateAdded != nil){
		dictionary[kM_CartDetailDateAdded] = self.dateAdded;
	}
	dictionary[kM_CartDetailDiscountAmount] = @(self.discountAmount);
    dictionary[kM_CartDetailDiscountPerc] = @(self.discountPerc);
	dictionary[kM_CartDetailItemId] = @(self.itemId);
	dictionary[kM_CartDetailItemTotalTaxPerc] = @(self.itemTotalTaxPerc);
	dictionary[kM_CartDetailItemTotalTaxValue] = @(self.itemTotalTaxValue);
	dictionary[kM_CartDetailOriginalPrice] = @(self.originalPrice);
	if(self.productDetails != nil){
		dictionary[kM_CartDetailProductDetails] = [self.productDetails toDictionary];
	}
	if(self.productVariant != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(M_ProductSpec * productVariantElement in self.productVariant){
			[dictionaryElements addObject:[productVariantElement toDictionary]];
		}
		dictionary[kM_CartDetailProductVariant] = dictionaryElements;
	}
	dictionary[kM_CartDetailProductVariantId] = @(self.productVariantId);
	dictionary[kM_CartDetailQuantity] = @(self.quantity);
	dictionary[kM_CartDetailSellingPrice] = @(self.sellingPrice);
	if(self.taxDetails != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(M_TaxDetail * taxDetailsElement in self.taxDetails){
			[dictionaryElements addObject:[taxDetailsElement toDictionary]];
		}
		dictionary[kM_CartDetailTaxDetails] = dictionaryElements;
	}
	dictionary[kM_CartDetailTotalAmount] = @(self.totalAmount);
	dictionary[kM_CartDetailUserCartId] = @(self.userCartId);
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
	[aCoder encodeObject:@(self.cartDetailId) forKey:kM_CartDetailCartDetailId];	if(self.dateAdded != nil){
		[aCoder encodeObject:self.dateAdded forKey:kM_CartDetailDateAdded];
	}
	[aCoder encodeObject:@(self.discountAmount) forKey:kM_CartDetailDiscountAmount];
    [aCoder encodeObject:@(self.discountPerc) forKey:kM_CartDetailDiscountPerc];
	
	[aCoder encodeObject:@(self.itemId) forKey:kM_CartDetailItemId];	[aCoder encodeObject:@(self.itemTotalTaxPerc) forKey:kM_CartDetailItemTotalTaxPerc];	[aCoder encodeObject:@(self.itemTotalTaxValue) forKey:kM_CartDetailItemTotalTaxValue];	[aCoder encodeObject:@(self.originalPrice) forKey:kM_CartDetailOriginalPrice];	if(self.productDetails != nil){
		[aCoder encodeObject:self.productDetails forKey:kM_CartDetailProductDetails];
	}
	if(self.productVariant != nil){
		[aCoder encodeObject:self.productVariant forKey:kM_CartDetailProductVariant];
	}
	[aCoder encodeObject:@(self.productVariantId) forKey:kM_CartDetailProductVariantId];	[aCoder encodeObject:@(self.quantity) forKey:kM_CartDetailQuantity];	[aCoder encodeObject:@(self.sellingPrice) forKey:kM_CartDetailSellingPrice];	if(self.taxDetails != nil){
		[aCoder encodeObject:self.taxDetails forKey:kM_CartDetailTaxDetails];
	}
	[aCoder encodeObject:@(self.totalAmount) forKey:kM_CartDetailTotalAmount];	[aCoder encodeObject:@(self.userCartId) forKey:kM_CartDetailUserCartId];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.cartDetailId = [[aDecoder decodeObjectForKey:kM_CartDetailCartDetailId] integerValue];
	self.dateAdded = [aDecoder decodeObjectForKey:kM_CartDetailDateAdded];
	self.discountAmount = [[aDecoder decodeObjectForKey:kM_CartDetailDiscountAmount] floatValue];
	self.discountPerc = [[aDecoder decodeObjectForKey:kM_CartDetailDiscountPerc] floatValue];
	self.itemId = [[aDecoder decodeObjectForKey:kM_CartDetailItemId] integerValue];
	self.itemTotalTaxPerc = [[aDecoder decodeObjectForKey:kM_CartDetailItemTotalTaxPerc] floatValue];
	self.itemTotalTaxValue = [[aDecoder decodeObjectForKey:kM_CartDetailItemTotalTaxValue] floatValue];
	self.originalPrice = [[aDecoder decodeObjectForKey:kM_CartDetailOriginalPrice] floatValue];
	self.productDetails = [aDecoder decodeObjectForKey:kM_CartDetailProductDetails];
	self.productVariant = [aDecoder decodeObjectForKey:kM_CartDetailProductVariant];
	self.productVariantId = [[aDecoder decodeObjectForKey:kM_CartDetailProductVariantId] integerValue];
	self.quantity = [[aDecoder decodeObjectForKey:kM_CartDetailQuantity] floatValue];
	self.sellingPrice = [[aDecoder decodeObjectForKey:kM_CartDetailSellingPrice] floatValue];
	self.taxDetails = [aDecoder decodeObjectForKey:kM_CartDetailTaxDetails];
	self.totalAmount = [[aDecoder decodeObjectForKey:kM_CartDetailTotalAmount] floatValue];
	self.userCartId = [[aDecoder decodeObjectForKey:kM_CartDetailUserCartId] integerValue];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	M_CartDetail *copy = [M_CartDetail new];

	copy.cartDetailId = self.cartDetailId;
	copy.dateAdded = [self.dateAdded copy];
	copy.discountAmount = self.discountAmount;
	copy.discountPerc = self.discountPerc;
	copy.itemId = self.itemId;
	copy.itemTotalTaxPerc = self.itemTotalTaxPerc;
	copy.itemTotalTaxValue = self.itemTotalTaxValue;
	copy.originalPrice = self.originalPrice;
	copy.productDetails = [self.productDetails copy];
	copy.productVariant = [self.productVariant copy];
	copy.productVariantId = self.productVariantId;
	copy.quantity = self.quantity;
	copy.sellingPrice = self.sellingPrice;
	copy.taxDetails = [self.taxDetails copy];
	copy.totalAmount = self.totalAmount;
	copy.userCartId = self.userCartId;

	return copy;
}
@end
