//
//	M_CartCount.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "M_CartCount.h"

NSString *const kM_CartCountCartCount = @"CartCount";

@interface M_CartCount ()
@end
@implementation M_CartCount




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kM_CartCountCartCount] isKindOfClass:[NSNull class]]){
		self.cartCount = [dictionary[kM_CartCountCartCount] integerValue];
	}

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	dictionary[kM_CartCountCartCount] = @(self.cartCount);
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
	[aCoder encodeObject:@(self.cartCount) forKey:kM_CartCountCartCount];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.cartCount = [[aDecoder decodeObjectForKey:kM_CartCountCartCount] integerValue];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	M_CartCount *copy = [M_CartCount new];

	copy.cartCount = self.cartCount;

	return copy;
}
@end