//
//	M_LandingSection.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "M_LandingSection.h"

NSString *const kM_LandingSectionItems = @"Items";
NSString *const kM_LandingSectionSectionHeight = @"SectionHeight";
NSString *const kM_LandingSectionSectionMarginBottom = @"SectionMarginBottom";
NSString *const kM_LandingSectionSectionMarginLeft = @"SectionMarginLeft";
NSString *const kM_LandingSectionSectionMarginRight = @"SectionMarginRight";
NSString *const kM_LandingSectionSectionMarginTop = @"SectionMarginTop";
NSString *const kM_LandingSectionSectionType = @"SectionType";
NSString *const kM_LandingSectionType = @"type";

@interface M_LandingSection ()
@end
@implementation M_LandingSection




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(dictionary[kM_LandingSectionItems] != nil && [dictionary[kM_LandingSectionItems] isKindOfClass:[NSArray class]]){
		NSArray * itemsDictionaries = dictionary[kM_LandingSectionItems];
		NSMutableArray * itemsItems = [NSMutableArray array];
		for(NSDictionary * itemsDictionary in itemsDictionaries){
			M_LandingItem * landingItem = [[M_LandingItem alloc] initWithDictionary:itemsDictionary];
			[itemsItems addObject:landingItem];
		}
		self.items = itemsItems;
	}
	if(![dictionary[kM_LandingSectionSectionHeight] isKindOfClass:[NSNull class]]){
		self.sectionHeight = [dictionary[kM_LandingSectionSectionHeight] floatValue];
	}

	if(![dictionary[kM_LandingSectionSectionMarginBottom] isKindOfClass:[NSNull class]]){
		self.sectionMarginBottom = [dictionary[kM_LandingSectionSectionMarginBottom] integerValue];
	}

	if(![dictionary[kM_LandingSectionSectionMarginLeft] isKindOfClass:[NSNull class]]){
		self.sectionMarginLeft = [dictionary[kM_LandingSectionSectionMarginLeft] integerValue];
	}

	if(![dictionary[kM_LandingSectionSectionMarginRight] isKindOfClass:[NSNull class]]){
		self.sectionMarginRight = [dictionary[kM_LandingSectionSectionMarginRight] integerValue];
	}

	if(![dictionary[kM_LandingSectionSectionMarginTop] isKindOfClass:[NSNull class]]){
		self.sectionMarginTop = [dictionary[kM_LandingSectionSectionMarginTop] integerValue];
	}

	if(![dictionary[kM_LandingSectionSectionType] isKindOfClass:[NSNull class]]){
		self.sectionType = dictionary[kM_LandingSectionSectionType];
	}	
	if(![dictionary[kM_LandingSectionType] isKindOfClass:[NSNull class]]){
		self.type = dictionary[kM_LandingSectionType];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.items != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(M_LandingItem * itemsElement in self.items){
			[dictionaryElements addObject:[itemsElement toDictionary]];
		}
		dictionary[kM_LandingSectionItems] = dictionaryElements;
	}
	dictionary[kM_LandingSectionSectionHeight] = @(self.sectionHeight);
	dictionary[kM_LandingSectionSectionMarginBottom] = @(self.sectionMarginBottom);
	dictionary[kM_LandingSectionSectionMarginLeft] = @(self.sectionMarginLeft);
	dictionary[kM_LandingSectionSectionMarginRight] = @(self.sectionMarginRight);
	dictionary[kM_LandingSectionSectionMarginTop] = @(self.sectionMarginTop);
	if(self.sectionType != nil){
		dictionary[kM_LandingSectionSectionType] = self.sectionType;
	}
	if(self.type != nil){
		dictionary[kM_LandingSectionType] = self.type;
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
	if(self.items != nil){
		[aCoder encodeObject:self.items forKey:kM_LandingSectionItems];
	}
	[aCoder encodeObject:@(self.sectionHeight) forKey:kM_LandingSectionSectionHeight];	[aCoder encodeObject:@(self.sectionMarginBottom) forKey:kM_LandingSectionSectionMarginBottom];	[aCoder encodeObject:@(self.sectionMarginLeft) forKey:kM_LandingSectionSectionMarginLeft];	[aCoder encodeObject:@(self.sectionMarginRight) forKey:kM_LandingSectionSectionMarginRight];	[aCoder encodeObject:@(self.sectionMarginTop) forKey:kM_LandingSectionSectionMarginTop];	if(self.sectionType != nil){
		[aCoder encodeObject:self.sectionType forKey:kM_LandingSectionSectionType];
	}
	if(self.type != nil){
		[aCoder encodeObject:self.type forKey:kM_LandingSectionType];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.items = [aDecoder decodeObjectForKey:kM_LandingSectionItems];
	self.sectionHeight = [[aDecoder decodeObjectForKey:kM_LandingSectionSectionHeight] floatValue];
	self.sectionMarginBottom = [[aDecoder decodeObjectForKey:kM_LandingSectionSectionMarginBottom] integerValue];
	self.sectionMarginLeft = [[aDecoder decodeObjectForKey:kM_LandingSectionSectionMarginLeft] integerValue];
	self.sectionMarginRight = [[aDecoder decodeObjectForKey:kM_LandingSectionSectionMarginRight] integerValue];
	self.sectionMarginTop = [[aDecoder decodeObjectForKey:kM_LandingSectionSectionMarginTop] integerValue];
	self.sectionType = [aDecoder decodeObjectForKey:kM_LandingSectionSectionType];
	self.type = [aDecoder decodeObjectForKey:kM_LandingSectionType];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	M_LandingSection *copy = [M_LandingSection new];

	copy.items = [self.items copy];
	copy.sectionHeight = self.sectionHeight;
	copy.sectionMarginBottom = self.sectionMarginBottom;
	copy.sectionMarginLeft = self.sectionMarginLeft;
	copy.sectionMarginRight = self.sectionMarginRight;
	copy.sectionMarginTop = self.sectionMarginTop;
	copy.sectionType = [self.sectionType copy];
	copy.type = [self.type copy];

	return copy;
}
@end
