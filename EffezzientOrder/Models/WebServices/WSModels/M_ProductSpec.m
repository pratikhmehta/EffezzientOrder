//
//	M_ProductSpec.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "M_ProductSpec.h"

NSString *const kM_ProductSpecSpecname = @"specname";
NSString *const kM_ProductSpecSpecvalue = @"specvalue";

@interface M_ProductSpec ()
@end
@implementation M_ProductSpec




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kM_ProductSpecSpecname] isKindOfClass:[NSNull class]]){
		self.specname = dictionary[kM_ProductSpecSpecname];
	}	
	if(![dictionary[kM_ProductSpecSpecvalue] isKindOfClass:[NSNull class]]){
		self.specvalue = dictionary[kM_ProductSpecSpecvalue];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.specname != nil){
		dictionary[kM_ProductSpecSpecname] = self.specname;
	}
	if(self.specvalue != nil){
		dictionary[kM_ProductSpecSpecvalue] = self.specvalue;
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
	if(self.specname != nil){
		[aCoder encodeObject:self.specname forKey:kM_ProductSpecSpecname];
	}
	if(self.specvalue != nil){
		[aCoder encodeObject:self.specvalue forKey:kM_ProductSpecSpecvalue];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.specname = [aDecoder decodeObjectForKey:kM_ProductSpecSpecname];
	self.specvalue = [aDecoder decodeObjectForKey:kM_ProductSpecSpecvalue];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	M_ProductSpec *copy = [M_ProductSpec new];

	copy.specname = [self.specname copy];
	copy.specvalue = [self.specvalue copy];

	return copy;
}
@end