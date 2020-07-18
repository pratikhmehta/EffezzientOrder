//
//	M_ProductScheme.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "M_ProductScheme.h"

NSString *const kM_ProductSchemeDescripition = @"description";
NSString *const kM_ProductSchemeScheme = @"scheme";
NSString *const kM_ProductSchemeSchemedetail = @"schemedetail";

@interface M_ProductScheme ()
@end
@implementation M_ProductScheme




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kM_ProductSchemeDescripition] isKindOfClass:[NSNull class]]){
		self.productSchemeDescription = dictionary[kM_ProductSchemeDescripition];
	}	
	if(![dictionary[kM_ProductSchemeScheme] isKindOfClass:[NSNull class]]){
		self.scheme = dictionary[kM_ProductSchemeScheme];
	}	
	if(![dictionary[kM_ProductSchemeSchemedetail] isKindOfClass:[NSNull class]]){
		self.schemedetail = dictionary[kM_ProductSchemeSchemedetail];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.productSchemeDescription != nil){
		dictionary[kM_ProductSchemeDescripition] = self.productSchemeDescription;
	}
	if(self.scheme != nil){
		dictionary[kM_ProductSchemeScheme] = self.scheme;
	}
	if(self.schemedetail != nil){
		dictionary[kM_ProductSchemeSchemedetail] = self.schemedetail;
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
	if(self.productSchemeDescription != nil){
		[aCoder encodeObject:self.productSchemeDescription forKey:kM_ProductSchemeDescripition];
	}
	if(self.scheme != nil){
		[aCoder encodeObject:self.scheme forKey:kM_ProductSchemeScheme];
	}
	if(self.schemedetail != nil){
		[aCoder encodeObject:self.schemedetail forKey:kM_ProductSchemeSchemedetail];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.productSchemeDescription = [aDecoder decodeObjectForKey:kM_ProductSchemeDescripition];
	self.scheme = [aDecoder decodeObjectForKey:kM_ProductSchemeScheme];
	self.schemedetail = [aDecoder decodeObjectForKey:kM_ProductSchemeSchemedetail];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	M_ProductScheme *copy = [M_ProductScheme new];

	copy.productSchemeDescription = [self.productSchemeDescription copy];
	copy.scheme = [self.scheme copy];
	copy.schemedetail = [self.schemedetail copy];

	return copy;
}
@end
