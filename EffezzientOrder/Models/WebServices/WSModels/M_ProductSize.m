//
//	M_ProductSize.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "M_ProductSize.h"

NSString *const kM_ProductSizeIslimitedstock = @"islimitedstock";
NSString *const kM_ProductSizeSizeid = @"sizeid";
NSString *const kM_ProductSizeSizename = @"sizename";

@interface M_ProductSize ()
@end
@implementation M_ProductSize




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kM_ProductSizeIslimitedstock] isKindOfClass:[NSNull class]]){
		self.islimitedstock = [dictionary[kM_ProductSizeIslimitedstock] boolValue];
	}

	if(![dictionary[kM_ProductSizeSizeid] isKindOfClass:[NSNull class]]){
		self.sizeid = [dictionary[kM_ProductSizeSizeid] integerValue];
	}

	if(![dictionary[kM_ProductSizeSizename] isKindOfClass:[NSNull class]]){
		self.sizename = dictionary[kM_ProductSizeSizename];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	dictionary[kM_ProductSizeIslimitedstock] = @(self.islimitedstock);
	dictionary[kM_ProductSizeSizeid] = @(self.sizeid);
	if(self.sizename != nil){
		dictionary[kM_ProductSizeSizename] = self.sizename;
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
	[aCoder encodeObject:@(self.islimitedstock) forKey:kM_ProductSizeIslimitedstock];	[aCoder encodeObject:@(self.sizeid) forKey:kM_ProductSizeSizeid];	if(self.sizename != nil){
		[aCoder encodeObject:self.sizename forKey:kM_ProductSizeSizename];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.islimitedstock = [[aDecoder decodeObjectForKey:kM_ProductSizeIslimitedstock] boolValue];
	self.sizeid = [[aDecoder decodeObjectForKey:kM_ProductSizeSizeid] integerValue];
	self.sizename = [aDecoder decodeObjectForKey:kM_ProductSizeSizename];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	M_ProductSize *copy = [M_ProductSize new];

	copy.islimitedstock = self.islimitedstock;
	copy.sizeid = self.sizeid;
	copy.sizename = [self.sizename copy];

	return copy;
}
@end