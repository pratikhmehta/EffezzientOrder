//
//	M_Filter.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "M_Filter.h"

NSString *const kM_FilterDisplayname = @"displayname";
NSString *const kM_FilterFiltercolumn = @"filtercolumn";
NSString *const kM_FilterSearchboxvisible = @"searchboxvisible";
NSString *const kM_FilterSelectedvalues = @"selectedvalues";
NSString *const kM_FilterSelectiontype = @"selectiontype";

@interface M_Filter ()
@end
@implementation M_Filter




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kM_FilterDisplayname] isKindOfClass:[NSNull class]]){
		self.displayname = dictionary[kM_FilterDisplayname];
	}	
	if(![dictionary[kM_FilterFiltercolumn] isKindOfClass:[NSNull class]]){
		self.filtercolumn = dictionary[kM_FilterFiltercolumn];
	}	
	if(![dictionary[kM_FilterSearchboxvisible] isKindOfClass:[NSNull class]]){
		self.searchboxvisible = [dictionary[kM_FilterSearchboxvisible] boolValue];
	}

	if(dictionary[kM_FilterSelectedvalues] != nil && [dictionary[kM_FilterSelectedvalues] isKindOfClass:[NSArray class]]){
		NSArray * selectedvaluesDictionaries = dictionary[kM_FilterSelectedvalues];
		NSMutableArray * selectedvaluesItems = [NSMutableArray array];
		for(NSDictionary * selectedvaluesDictionary in selectedvaluesDictionaries){
			M_FilterValues * selectedvaluesItem = [[M_FilterValues alloc] initWithDictionary:selectedvaluesDictionary];
			[selectedvaluesItems addObject:selectedvaluesItem];
		}
		self.selectedvalues = selectedvaluesItems;
	}
	if(![dictionary[kM_FilterSelectiontype] isKindOfClass:[NSNull class]]){
		self.selectiontype = dictionary[kM_FilterSelectiontype];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.displayname != nil){
		dictionary[kM_FilterDisplayname] = self.displayname;
	}
	if(self.filtercolumn != nil){
		dictionary[kM_FilterFiltercolumn] = self.filtercolumn;
	}
	dictionary[kM_FilterSearchboxvisible] = @(self.searchboxvisible);
	if(self.selectedvalues != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(M_FilterValues * selectedvaluesElement in self.selectedvalues){
			[dictionaryElements addObject:[selectedvaluesElement toDictionary]];
		}
		dictionary[kM_FilterSelectedvalues] = dictionaryElements;
	}
	if(self.selectiontype != nil){
		dictionary[kM_FilterSelectiontype] = self.selectiontype;
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
	if(self.displayname != nil){
		[aCoder encodeObject:self.displayname forKey:kM_FilterDisplayname];
	}
	if(self.filtercolumn != nil){
		[aCoder encodeObject:self.filtercolumn forKey:kM_FilterFiltercolumn];
	}
	[aCoder encodeObject:@(self.searchboxvisible) forKey:kM_FilterSearchboxvisible];	if(self.selectedvalues != nil){
		[aCoder encodeObject:self.selectedvalues forKey:kM_FilterSelectedvalues];
	}
	if(self.selectiontype != nil){
		[aCoder encodeObject:self.selectiontype forKey:kM_FilterSelectiontype];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.displayname = [aDecoder decodeObjectForKey:kM_FilterDisplayname];
	self.filtercolumn = [aDecoder decodeObjectForKey:kM_FilterFiltercolumn];
	self.searchboxvisible = [[aDecoder decodeObjectForKey:kM_FilterSearchboxvisible] boolValue];
	self.selectedvalues = [aDecoder decodeObjectForKey:kM_FilterSelectedvalues];
	self.selectiontype = [aDecoder decodeObjectForKey:kM_FilterSelectiontype];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	M_Filter *copy = [M_Filter new];

	copy.displayname = [self.displayname copy];
	copy.filtercolumn = [self.filtercolumn copy];
	copy.searchboxvisible = self.searchboxvisible;
	copy.selectedvalues = [self.selectedvalues copy];
	copy.selectiontype = [self.selectiontype copy];

	return copy;
}
@end
