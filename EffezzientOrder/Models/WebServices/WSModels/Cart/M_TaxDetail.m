//
//	M_TaxDetail.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "M_TaxDetail.h"

NSString *const kM_TaxDetailTaxName = @"TaxName";
NSString *const kM_TaxDetailTaxPerc = @"TaxPerc";
NSString *const kM_TaxDetailTaxValue = @"TaxValue";

@interface M_TaxDetail ()
@end
@implementation M_TaxDetail




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kM_TaxDetailTaxName] isKindOfClass:[NSNull class]]){
		self.taxName = dictionary[kM_TaxDetailTaxName];
	}	
	if(![dictionary[kM_TaxDetailTaxPerc] isKindOfClass:[NSNull class]]){
		self.taxPerc = [dictionary[kM_TaxDetailTaxPerc] floatValue];
	}

	if(![dictionary[kM_TaxDetailTaxValue] isKindOfClass:[NSNull class]]){
		self.taxValue = [dictionary[kM_TaxDetailTaxValue] floatValue];
	}

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.taxName != nil){
		dictionary[kM_TaxDetailTaxName] = self.taxName;
	}
	dictionary[kM_TaxDetailTaxPerc] = @(self.taxPerc);
	dictionary[kM_TaxDetailTaxValue] = @(self.taxValue);
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
	if(self.taxName != nil){
		[aCoder encodeObject:self.taxName forKey:kM_TaxDetailTaxName];
	}
	[aCoder encodeObject:@(self.taxPerc) forKey:kM_TaxDetailTaxPerc];	[aCoder encodeObject:@(self.taxValue) forKey:kM_TaxDetailTaxValue];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.taxName = [aDecoder decodeObjectForKey:kM_TaxDetailTaxName];
	self.taxPerc = [[aDecoder decodeObjectForKey:kM_TaxDetailTaxPerc] floatValue];
	self.taxValue = [[aDecoder decodeObjectForKey:kM_TaxDetailTaxValue] floatValue];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	M_TaxDetail *copy = [M_TaxDetail new];

	copy.taxName = [self.taxName copy];
	copy.taxPerc = self.taxPerc;
	copy.taxValue = self.taxValue;

	return copy;
}
@end