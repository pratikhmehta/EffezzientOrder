//
//	M_CartAmountDetail.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "M_CartAmountDetail.h"

NSString *const kM_CartAmountDetailCartDiscountAmt = @"CartDiscountAmt";
NSString *const kM_CartAmountDetailCartDiscountPerc = @"CartDiscountPerc";
NSString *const kM_CartAmountDetailFinalAmount = @"FinalAmount";
NSString *const kM_CartAmountDetailGrossAmount = @"GrossAmount";
NSString *const kM_CartAmountDetailNetAmount = @"NetAmount";
NSString *const kM_CartAmountDetailRoundOff = @"RoundOff";
NSString *const kM_CartAmountDetailTaxAmount = @"TaxAmount";
NSString *const kM_CartAmountDetailTotalAmount = @"TotalAmount";
NSString *const kM_CartAmountDetailTotlItemDiscount = @"TotlItemDiscount";

@interface M_CartAmountDetail ()
@end
@implementation M_CartAmountDetail




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kM_CartAmountDetailCartDiscountAmt] isKindOfClass:[NSNull class]]){
		self.cartDiscountAmt = [dictionary[kM_CartAmountDetailCartDiscountAmt] floatValue];
	}

	if(![dictionary[kM_CartAmountDetailCartDiscountPerc] isKindOfClass:[NSNull class]]){
		self.cartDiscountPerc = [dictionary[kM_CartAmountDetailCartDiscountPerc] floatValue];
	}

	if(![dictionary[kM_CartAmountDetailFinalAmount] isKindOfClass:[NSNull class]]){
		self.finalAmount = [dictionary[kM_CartAmountDetailFinalAmount] floatValue];
	}

	if(![dictionary[kM_CartAmountDetailGrossAmount] isKindOfClass:[NSNull class]]){
		self.grossAmount = [dictionary[kM_CartAmountDetailGrossAmount] floatValue];
	}

	if(![dictionary[kM_CartAmountDetailNetAmount] isKindOfClass:[NSNull class]]){
		self.netAmount = [dictionary[kM_CartAmountDetailNetAmount] floatValue];
	}

	if(![dictionary[kM_CartAmountDetailRoundOff] isKindOfClass:[NSNull class]]){
		self.roundOff = [dictionary[kM_CartAmountDetailRoundOff] floatValue];
	}

	if(![dictionary[kM_CartAmountDetailTaxAmount] isKindOfClass:[NSNull class]]){
		self.taxAmount = [dictionary[kM_CartAmountDetailTaxAmount] floatValue];
	}

	if(![dictionary[kM_CartAmountDetailTotalAmount] isKindOfClass:[NSNull class]]){
		self.totalAmount = [dictionary[kM_CartAmountDetailTotalAmount] floatValue];
	}

	if(![dictionary[kM_CartAmountDetailTotlItemDiscount] isKindOfClass:[NSNull class]]){
		self.totlItemDiscount = [dictionary[kM_CartAmountDetailTotlItemDiscount] floatValue];
	}

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	dictionary[kM_CartAmountDetailCartDiscountAmt] = @(self.cartDiscountAmt);
	dictionary[kM_CartAmountDetailCartDiscountPerc] = @(self.cartDiscountPerc);
	dictionary[kM_CartAmountDetailFinalAmount] = @(self.finalAmount);
	dictionary[kM_CartAmountDetailGrossAmount] = @(self.grossAmount);
	dictionary[kM_CartAmountDetailNetAmount] = @(self.netAmount);
	dictionary[kM_CartAmountDetailRoundOff] = @(self.roundOff);
	dictionary[kM_CartAmountDetailTaxAmount] = @(self.taxAmount);
	dictionary[kM_CartAmountDetailTotalAmount] = @(self.totalAmount);
	dictionary[kM_CartAmountDetailTotlItemDiscount] = @(self.totlItemDiscount);
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
	[aCoder encodeObject:@(self.cartDiscountAmt) forKey:kM_CartAmountDetailCartDiscountAmt];	[aCoder encodeObject:@(self.cartDiscountPerc) forKey:kM_CartAmountDetailCartDiscountPerc];	[aCoder encodeObject:@(self.finalAmount) forKey:kM_CartAmountDetailFinalAmount];	[aCoder encodeObject:@(self.grossAmount) forKey:kM_CartAmountDetailGrossAmount];	[aCoder encodeObject:@(self.netAmount) forKey:kM_CartAmountDetailNetAmount];	[aCoder encodeObject:@(self.roundOff) forKey:kM_CartAmountDetailRoundOff];	[aCoder encodeObject:@(self.taxAmount) forKey:kM_CartAmountDetailTaxAmount];	[aCoder encodeObject:@(self.totalAmount) forKey:kM_CartAmountDetailTotalAmount];	[aCoder encodeObject:@(self.totlItemDiscount) forKey:kM_CartAmountDetailTotlItemDiscount];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.cartDiscountAmt = [[aDecoder decodeObjectForKey:kM_CartAmountDetailCartDiscountAmt] floatValue];
	self.cartDiscountPerc = [[aDecoder decodeObjectForKey:kM_CartAmountDetailCartDiscountPerc] floatValue];
	self.finalAmount = [[aDecoder decodeObjectForKey:kM_CartAmountDetailFinalAmount] floatValue];
	self.grossAmount = [[aDecoder decodeObjectForKey:kM_CartAmountDetailGrossAmount] floatValue];
	self.netAmount = [[aDecoder decodeObjectForKey:kM_CartAmountDetailNetAmount] floatValue];
	self.roundOff = [[aDecoder decodeObjectForKey:kM_CartAmountDetailRoundOff] floatValue];
	self.taxAmount = [[aDecoder decodeObjectForKey:kM_CartAmountDetailTaxAmount] floatValue];
	self.totalAmount = [[aDecoder decodeObjectForKey:kM_CartAmountDetailTotalAmount] floatValue];
	self.totlItemDiscount = [[aDecoder decodeObjectForKey:kM_CartAmountDetailTotlItemDiscount] floatValue];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	M_CartAmountDetail *copy = [M_CartAmountDetail new];

	copy.cartDiscountAmt = self.cartDiscountAmt;
	copy.cartDiscountPerc = self.cartDiscountPerc;
	copy.finalAmount = self.finalAmount;
	copy.grossAmount = self.grossAmount;
	copy.netAmount = self.netAmount;
	copy.roundOff = self.roundOff;
	copy.taxAmount = self.taxAmount;
	copy.totalAmount = self.totalAmount;
	copy.totlItemDiscount = self.totlItemDiscount;

	return copy;
}
@end