//
//	M_DistributorList.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "M_DistributorList.h"

NSString *const kM_DistributorListAddress = @"Address";
NSString *const kM_DistributorListDistributorID = @"DistributorID";
NSString *const kM_DistributorListDistributorName = @"DistributorName";

@interface M_DistributorList ()
@end
@implementation M_DistributorList




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kM_DistributorListAddress] isKindOfClass:[NSNull class]]){
		self.address = dictionary[kM_DistributorListAddress];
	}	
	if(![dictionary[kM_DistributorListDistributorID] isKindOfClass:[NSNull class]]){
		self.distributorID = [dictionary[kM_DistributorListDistributorID] integerValue];
	}

	if(![dictionary[kM_DistributorListDistributorName] isKindOfClass:[NSNull class]]){
		self.distributorName = dictionary[kM_DistributorListDistributorName];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.address != nil){
		dictionary[kM_DistributorListAddress] = self.address;
	}
	dictionary[kM_DistributorListDistributorID] = @(self.distributorID);
	if(self.distributorName != nil){
		dictionary[kM_DistributorListDistributorName] = self.distributorName;
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
	if(self.address != nil){
		[aCoder encodeObject:self.address forKey:kM_DistributorListAddress];
	}
	[aCoder encodeObject:@(self.distributorID) forKey:kM_DistributorListDistributorID];	if(self.distributorName != nil){
		[aCoder encodeObject:self.distributorName forKey:kM_DistributorListDistributorName];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.address = [aDecoder decodeObjectForKey:kM_DistributorListAddress];
	self.distributorID = [[aDecoder decodeObjectForKey:kM_DistributorListDistributorID] integerValue];
	self.distributorName = [aDecoder decodeObjectForKey:kM_DistributorListDistributorName];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	M_DistributorList *copy = [M_DistributorList new];

	copy.address = [self.address copy];
	copy.distributorID = self.distributorID;
	copy.distributorName = [self.distributorName copy];

	return copy;
}
@end