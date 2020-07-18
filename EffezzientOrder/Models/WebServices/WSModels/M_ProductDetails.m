//
//	M_ProductDetails.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "M_ProductDetails.h"

NSString *const kM_ProductDetailsAvailableschemes = @"availableschemes";
NSString *const kM_ProductDetailsExchangepolicy = @"exchangepolicy";
NSString *const kM_ProductDetailsMaxqtyallowed = @"maxqtyallowed";
NSString *const kM_ProductDetailsPriceinclusivetax = @"priceinclusivetax";

@interface M_ProductDetails ()
@end
@implementation M_ProductDetails




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(dictionary[kM_ProductDetailsAvailableschemes] != nil && [dictionary[kM_ProductDetailsAvailableschemes] isKindOfClass:[NSArray class]]){
		NSArray * availableschemesDictionaries = dictionary[kM_ProductDetailsAvailableschemes];
		NSMutableArray * availableschemesItems = [NSMutableArray array];
		for(NSDictionary * availableschemesDictionary in availableschemesDictionaries){
			M_ProductScheme * availableschemesItem = [[M_ProductScheme alloc] initWithDictionary:availableschemesDictionary];
			[availableschemesItems addObject:availableschemesItem];
		}
		self.availableschemes = availableschemesItems;
	}
	if(dictionary[kM_ProductDetailsExchangepolicy] != nil && [dictionary[kM_ProductDetailsExchangepolicy] isKindOfClass:[NSArray class]]){
		NSArray * exchangepolicyDictionaries = dictionary[kM_ProductDetailsExchangepolicy];
		NSMutableArray * exchangepolicyItems = [NSMutableArray array];
		for(NSDictionary * exchangepolicyDictionary in exchangepolicyDictionaries){
			M_ProductExchangePolicy * exchangepolicyItem = [[M_ProductExchangePolicy alloc] initWithDictionary:exchangepolicyDictionary];
			[exchangepolicyItems addObject:exchangepolicyItem];
		}
		self.exchangepolicy = exchangepolicyItems;
	}
	if(![dictionary[kM_ProductDetailsMaxqtyallowed] isKindOfClass:[NSNull class]]){
		self.maxqtyallowed = [dictionary[kM_ProductDetailsMaxqtyallowed] integerValue];
	}

	if(![dictionary[kM_ProductDetailsPriceinclusivetax] isKindOfClass:[NSNull class]]){
		self.priceinclusivetax = [dictionary[kM_ProductDetailsPriceinclusivetax] boolValue];
	}

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.availableschemes != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(M_ProductScheme * availableschemesElement in self.availableschemes){
			[dictionaryElements addObject:[availableschemesElement toDictionary]];
		}
		dictionary[kM_ProductDetailsAvailableschemes] = dictionaryElements;
	}
	if(self.exchangepolicy != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(M_ProductExchangePolicy * exchangepolicyElement in self.exchangepolicy){
			[dictionaryElements addObject:[exchangepolicyElement toDictionary]];
		}
		dictionary[kM_ProductDetailsExchangepolicy] = dictionaryElements;
	}
	dictionary[kM_ProductDetailsMaxqtyallowed] = @(self.maxqtyallowed);
	dictionary[kM_ProductDetailsPriceinclusivetax] = @(self.priceinclusivetax);
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
	if(self.availableschemes != nil){
		[aCoder encodeObject:self.availableschemes forKey:kM_ProductDetailsAvailableschemes];
	}
	if(self.exchangepolicy != nil){
		[aCoder encodeObject:self.exchangepolicy forKey:kM_ProductDetailsExchangepolicy];
	}
	[aCoder encodeObject:@(self.maxqtyallowed) forKey:kM_ProductDetailsMaxqtyallowed];	[aCoder encodeObject:@(self.priceinclusivetax) forKey:kM_ProductDetailsPriceinclusivetax];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.availableschemes = [aDecoder decodeObjectForKey:kM_ProductDetailsAvailableschemes];
	self.exchangepolicy = [aDecoder decodeObjectForKey:kM_ProductDetailsExchangepolicy];
	self.maxqtyallowed = [[aDecoder decodeObjectForKey:kM_ProductDetailsMaxqtyallowed] integerValue];
	self.priceinclusivetax = [[aDecoder decodeObjectForKey:kM_ProductDetailsPriceinclusivetax] boolValue];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	M_ProductDetails *copy = [M_ProductDetails new];

	copy.availableschemes = [self.availableschemes copy];
	copy.exchangepolicy = [self.exchangepolicy copy];
	copy.maxqtyallowed = self.maxqtyallowed;
	copy.priceinclusivetax = self.priceinclusivetax;

	return copy;
}
@end
