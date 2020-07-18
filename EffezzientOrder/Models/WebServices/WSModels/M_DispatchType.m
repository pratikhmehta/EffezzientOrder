//
//	M_DispatchType.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "M_DispatchType.h"

NSString *const kM_DispatchTypeDispatchTypeId = @"DispatchTypeId";
NSString *const kM_DispatchTypeDispatchTypeName = @"DispatchTypeName";
NSString *const kM_DispatchTypeFreightApplicable = @"FreightApplicable";

@interface M_DispatchType ()
@end
@implementation M_DispatchType




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kM_DispatchTypeDispatchTypeId] isKindOfClass:[NSNull class]]){
		self.dispatchTypeId = [dictionary[kM_DispatchTypeDispatchTypeId] integerValue];
	}

	if(![dictionary[kM_DispatchTypeDispatchTypeName] isKindOfClass:[NSNull class]]){
		self.dispatchTypeName = dictionary[kM_DispatchTypeDispatchTypeName];
	}	
	if(![dictionary[kM_DispatchTypeFreightApplicable] isKindOfClass:[NSNull class]]){
		self.freightApplicable = [dictionary[kM_DispatchTypeFreightApplicable] boolValue];
	}

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	dictionary[kM_DispatchTypeDispatchTypeId] = @(self.dispatchTypeId);
	if(self.dispatchTypeName != nil){
		dictionary[kM_DispatchTypeDispatchTypeName] = self.dispatchTypeName;
	}
	dictionary[kM_DispatchTypeFreightApplicable] = @(self.freightApplicable);
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
	[aCoder encodeObject:@(self.dispatchTypeId) forKey:kM_DispatchTypeDispatchTypeId];	if(self.dispatchTypeName != nil){
		[aCoder encodeObject:self.dispatchTypeName forKey:kM_DispatchTypeDispatchTypeName];
	}
	[aCoder encodeObject:@(self.freightApplicable) forKey:kM_DispatchTypeFreightApplicable];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.dispatchTypeId = [[aDecoder decodeObjectForKey:kM_DispatchTypeDispatchTypeId] integerValue];
	self.dispatchTypeName = [aDecoder decodeObjectForKey:kM_DispatchTypeDispatchTypeName];
	self.freightApplicable = [[aDecoder decodeObjectForKey:kM_DispatchTypeFreightApplicable] boolValue];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	M_DispatchType *copy = [M_DispatchType new];

	copy.dispatchTypeId = self.dispatchTypeId;
	copy.dispatchTypeName = [self.dispatchTypeName copy];
	copy.freightApplicable = self.freightApplicable;

	return copy;
}
@end