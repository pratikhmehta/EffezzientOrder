//
//	M_LandingItem.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "M_LandingItem.h"

NSString *const kM_LandingItemImageURL = @"ImageURL";
NSString *const kM_LandingItemItemHeight = @"ItemHeight";
NSString *const kM_LandingItemItemWidth = @"ItemWidth";
NSString *const kM_LandingItemPassParams = @"PassParams";

@interface M_LandingItem ()
@end
@implementation M_LandingItem




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kM_LandingItemImageURL] isKindOfClass:[NSNull class]]){
		self.imageURL = dictionary[kM_LandingItemImageURL];
	}	
	if(![dictionary[kM_LandingItemItemHeight] isKindOfClass:[NSNull class]]){
		self.itemHeight = [dictionary[kM_LandingItemItemHeight] integerValue];
	}

	if(![dictionary[kM_LandingItemItemWidth] isKindOfClass:[NSNull class]]){
		self.itemWidth = [dictionary[kM_LandingItemItemWidth] integerValue];
	}

	if(![dictionary[kM_LandingItemPassParams] isKindOfClass:[NSNull class]]){
		self.passParams = dictionary[kM_LandingItemPassParams];
	}

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.imageURL != nil){
		dictionary[kM_LandingItemImageURL] = self.imageURL;
	}
	dictionary[kM_LandingItemItemHeight] = @(self.itemHeight);
	dictionary[kM_LandingItemItemWidth] = @(self.itemWidth);
	if(self.passParams != nil){
		dictionary[kM_LandingItemPassParams] = self.passParams;
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
	if(self.imageURL != nil){
		[aCoder encodeObject:self.imageURL forKey:kM_LandingItemImageURL];
	}
	[aCoder encodeObject:@(self.itemHeight) forKey:kM_LandingItemItemHeight];	[aCoder encodeObject:@(self.itemWidth) forKey:kM_LandingItemItemWidth];	if(self.passParams != nil){
		[aCoder encodeObject:self.passParams forKey:kM_LandingItemPassParams];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.imageURL = [aDecoder decodeObjectForKey:kM_LandingItemImageURL];
	self.itemHeight = [[aDecoder decodeObjectForKey:kM_LandingItemItemHeight] integerValue];
	self.itemWidth = [[aDecoder decodeObjectForKey:kM_LandingItemItemWidth] integerValue];
	self.passParams = [aDecoder decodeObjectForKey:kM_LandingItemPassParams];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	M_LandingItem *copy = [M_LandingItem new];

	copy.imageURL = [self.imageURL copy];
	copy.itemHeight = self.itemHeight;
	copy.itemWidth = self.itemWidth;
	copy.passParams = [self.passParams copy];

	return copy;
}
@end
