//
//	M_FilterValues.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "M_FilterValues.h"

NSString *const kM_FilterValuesFiltertype = @"filtertype";
NSString *const kM_FilterValuesIdField = @"id";
NSString *const kM_FilterValuesIsselected = @"isselected";
NSString *const kM_FilterValuesName = @"name";
NSString *const kM_FilterValuesTotal = @"total";
NSString *const kM_FilterValuesValue = @"value";

@interface M_FilterValues ()
@end
@implementation M_FilterValues




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kM_FilterValuesFiltertype] isKindOfClass:[NSNull class]]){
		self.filtertype = dictionary[kM_FilterValuesFiltertype];
	}	
	if(![dictionary[kM_FilterValuesIdField] isKindOfClass:[NSNull class]]){
		self.idField = [dictionary[kM_FilterValuesIdField] integerValue];
	}

	if(![dictionary[kM_FilterValuesIsselected] isKindOfClass:[NSNull class]]){
		self.isselected = [dictionary[kM_FilterValuesIsselected] boolValue];
	}

	if(![dictionary[kM_FilterValuesName] isKindOfClass:[NSNull class]]){
		self.name = dictionary[kM_FilterValuesName];
	}	
	if(![dictionary[kM_FilterValuesTotal] isKindOfClass:[NSNull class]]){
		self.total = [dictionary[kM_FilterValuesTotal] integerValue];
	}

	if(![dictionary[kM_FilterValuesValue] isKindOfClass:[NSNull class]]){
		self.value = dictionary[kM_FilterValuesValue];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.filtertype != nil){
		dictionary[kM_FilterValuesFiltertype] = self.filtertype;
	}
	dictionary[kM_FilterValuesIdField] = @(self.idField);
	dictionary[kM_FilterValuesIsselected] = @(self.isselected);
	if(self.name != nil){
		dictionary[kM_FilterValuesName] = self.name;
	}
	dictionary[kM_FilterValuesTotal] = @(self.total);
	if(self.value != nil){
		dictionary[kM_FilterValuesValue] = self.value;
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
	if(self.filtertype != nil){
		[aCoder encodeObject:self.filtertype forKey:kM_FilterValuesFiltertype];
	}
	[aCoder encodeObject:@(self.idField) forKey:kM_FilterValuesIdField];	[aCoder encodeObject:@(self.isselected) forKey:kM_FilterValuesIsselected];	if(self.name != nil){
		[aCoder encodeObject:self.name forKey:kM_FilterValuesName];
	}
	[aCoder encodeObject:@(self.total) forKey:kM_FilterValuesTotal];	if(self.value != nil){
		[aCoder encodeObject:self.value forKey:kM_FilterValuesValue];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.filtertype = [aDecoder decodeObjectForKey:kM_FilterValuesFiltertype];
	self.idField = [[aDecoder decodeObjectForKey:kM_FilterValuesIdField] integerValue];
	self.isselected = [[aDecoder decodeObjectForKey:kM_FilterValuesIsselected] boolValue];
	self.name = [aDecoder decodeObjectForKey:kM_FilterValuesName];
	self.total = [[aDecoder decodeObjectForKey:kM_FilterValuesTotal] integerValue];
	self.value = [aDecoder decodeObjectForKey:kM_FilterValuesValue];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	M_FilterValues *copy = [M_FilterValues new];

	copy.filtertype = [self.filtertype copy];
	copy.idField = self.idField;
	copy.isselected = self.isselected;
	copy.name = [self.name copy];
	copy.total = self.total;
	copy.value = [self.value copy];

	return copy;
}
@end