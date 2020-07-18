//
//	M_ProductExchangePolicy.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "M_ProductExchangePolicy.h"

NSString *const kM_ProductExchangePolicyDescripition = @"description";
NSString *const kM_ProductExchangePolicyTitle = @"title";

@interface M_ProductExchangePolicy ()
@end
@implementation M_ProductExchangePolicy




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kM_ProductExchangePolicyDescripition] isKindOfClass:[NSNull class]]){
		self.exchangePolicyDescription = dictionary[kM_ProductExchangePolicyDescripition];
	}	
	if(![dictionary[kM_ProductExchangePolicyTitle] isKindOfClass:[NSNull class]]){
		self.title = dictionary[kM_ProductExchangePolicyTitle];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.exchangePolicyDescription != nil){
		dictionary[kM_ProductExchangePolicyDescripition] = self.exchangePolicyDescription;
	}
	if(self.title != nil){
		dictionary[kM_ProductExchangePolicyTitle] = self.title;
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
	if(self.exchangePolicyDescription != nil){
		[aCoder encodeObject:self.exchangePolicyDescription forKey:kM_ProductExchangePolicyDescripition];
	}
	if(self.title != nil){
		[aCoder encodeObject:self.title forKey:kM_ProductExchangePolicyTitle];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.exchangePolicyDescription = [aDecoder decodeObjectForKey:kM_ProductExchangePolicyDescripition];
	self.title = [aDecoder decodeObjectForKey:kM_ProductExchangePolicyTitle];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	M_ProductExchangePolicy *copy = [M_ProductExchangePolicy new];

	copy.exchangePolicyDescription = [self.exchangePolicyDescription copy];
	copy.title = [self.title copy];

	return copy;
}
@end
