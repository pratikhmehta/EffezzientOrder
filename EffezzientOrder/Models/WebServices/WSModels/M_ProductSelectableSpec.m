//
//	M_ProductSelectableSpec.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "M_ProductSelectableSpec.h"

NSString *const kM_ProductSelectableSpecSelectedvalue = @"defaultvalue";
NSString *const kM_ProductSelectableSpecSpecname = @"specname";
NSString *const kM_ProductSelectableSpecSpecvalues = @"specvalues";

@interface M_ProductSelectableSpec ()
@end
@implementation M_ProductSelectableSpec




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kM_ProductSelectableSpecSelectedvalue] isKindOfClass:[NSNull class]]){
		self.selectedvalue = dictionary[kM_ProductSelectableSpecSelectedvalue];
	}	
	if(![dictionary[kM_ProductSelectableSpecSpecname] isKindOfClass:[NSNull class]]){
		self.specname = dictionary[kM_ProductSelectableSpecSpecname];
	}	
	if(![dictionary[kM_ProductSelectableSpecSpecvalues] isKindOfClass:[NSNull class]]){
		self.specvalues = dictionary[kM_ProductSelectableSpecSpecvalues];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.selectedvalue != nil){
		dictionary[kM_ProductSelectableSpecSelectedvalue] = self.selectedvalue;
	}
	if(self.specname != nil){
		dictionary[kM_ProductSelectableSpecSpecname] = self.specname;
	}
	if(self.specvalues != nil){
		dictionary[kM_ProductSelectableSpecSpecvalues] = self.specvalues;
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
	if(self.selectedvalue != nil){
		[aCoder encodeObject:self.selectedvalue forKey:kM_ProductSelectableSpecSelectedvalue];
	}
	if(self.specname != nil){
		[aCoder encodeObject:self.specname forKey:kM_ProductSelectableSpecSpecname];
	}
	if(self.specvalues != nil){
		[aCoder encodeObject:self.specvalues forKey:kM_ProductSelectableSpecSpecvalues];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.selectedvalue = [aDecoder decodeObjectForKey:kM_ProductSelectableSpecSelectedvalue];
	self.specname = [aDecoder decodeObjectForKey:kM_ProductSelectableSpecSpecname];
	self.specvalues = [aDecoder decodeObjectForKey:kM_ProductSelectableSpecSpecvalues];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	M_ProductSelectableSpec *copy = [M_ProductSelectableSpec new];

	copy.selectedvalue = [self.selectedvalue copy];
	copy.specname = [self.specname copy];
	copy.specvalues = [self.specvalues copy];

	return copy;
}
@end
