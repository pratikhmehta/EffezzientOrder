//
//	Cataloguedetail.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "Cataloguedetail.h"

NSString *const kCataloguedetailNoofdesigns = @"noofdesigns";
NSString *const kCataloguedetailSinglepcsavailable = @"singlepcsavailable";
NSString *const kCataloguedetailSinglepcsdiscount = @"singlepcsdiscount";
NSString *const kCataloguedetailSinglepcsprice = @"singlepcsprice";

@interface Cataloguedetail ()
@end
@implementation Cataloguedetail




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kCataloguedetailNoofdesigns] isKindOfClass:[NSNull class]]){
		self.noofdesigns = [dictionary[kCataloguedetailNoofdesigns] integerValue];
	}

	if(![dictionary[kCataloguedetailSinglepcsavailable] isKindOfClass:[NSNull class]]){
		self.singlepcsavailable = [dictionary[kCataloguedetailSinglepcsavailable] boolValue];
	}

	if(![dictionary[kCataloguedetailSinglepcsdiscount] isKindOfClass:[NSNull class]]){
		self.singlepcsdiscount = [dictionary[kCataloguedetailSinglepcsdiscount] floatValue];
	}

	if(![dictionary[kCataloguedetailSinglepcsprice] isKindOfClass:[NSNull class]]){
		self.singlepcsprice = dictionary[kCataloguedetailSinglepcsprice];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	dictionary[kCataloguedetailNoofdesigns] = @(self.noofdesigns);
	dictionary[kCataloguedetailSinglepcsavailable] = @(self.singlepcsavailable);
	dictionary[kCataloguedetailSinglepcsdiscount] = @(self.singlepcsdiscount);
	if(self.singlepcsprice != nil){
		dictionary[kCataloguedetailSinglepcsprice] = self.singlepcsprice;
	}
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
	[aCoder encodeObject:@(self.noofdesigns) forKey:kCataloguedetailNoofdesigns];	[aCoder encodeObject:@(self.singlepcsavailable) forKey:kCataloguedetailSinglepcsavailable];	[aCoder encodeObject:@(self.singlepcsdiscount) forKey:kCataloguedetailSinglepcsdiscount];	if(self.singlepcsprice != nil){
		[aCoder encodeObject:self.singlepcsprice forKey:kCataloguedetailSinglepcsprice];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.noofdesigns = [[aDecoder decodeObjectForKey:kCataloguedetailNoofdesigns] integerValue];
	self.singlepcsavailable = [[aDecoder decodeObjectForKey:kCataloguedetailSinglepcsavailable] boolValue];
	self.singlepcsdiscount = [[aDecoder decodeObjectForKey:kCataloguedetailSinglepcsdiscount] floatValue];
	self.singlepcsprice = [aDecoder decodeObjectForKey:kCataloguedetailSinglepcsprice];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	Cataloguedetail *copy = [Cataloguedetail new];

	copy.noofdesigns = self.noofdesigns;
	copy.singlepcsavailable = self.singlepcsavailable;
	copy.singlepcsdiscount = self.singlepcsdiscount;
	copy.singlepcsprice = [self.singlepcsprice copy];

	return copy;
}
@end