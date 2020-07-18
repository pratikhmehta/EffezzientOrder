//
//	M_ProductList.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "M_ProductList.h"

NSString *const kM_ProductListBrandid = @"brandid";
NSString *const kM_ProductListBrandname = @"brandname";
NSString *const kM_ProductListCanaddtocart = @"canaddtocart";
NSString *const kM_ProductListCataloguedetail = @"cataloguedetail";
NSString *const kM_ProductListCategoryid = @"categoryid";
NSString *const kM_ProductListCategoryname = @"categoryname";
NSString *const kM_ProductListCoverimage = @"coverimage";
NSString *const kM_ProductListDiscount = @"discount";
NSString *const kM_ProductListIscatalogue = @"iscatalogue";
NSString *const kM_ProductListIslimitedstock = @"islimitedstock";
NSString *const kM_ProductListIstrending = @"istrending";
NSString *const kM_ProductListIswishlisetd = @"iswishlisetd";
NSString *const kM_ProductListItemid = @"itemid";
NSString *const kM_ProductListItemname = @"itemname";
NSString *const kM_ProductListLongdescription = @"longdescription";
NSString *const kM_ProductListMrp = @"mrp";
NSString *const kM_ProductListOfferprice = @"offerprice";
NSString *const kM_ProductListProductrating = @"productrating";
NSString *const kM_ProductListShortdescription = @"shortdescription";
NSString *const kM_ProductListTotalAmount = @"totalAmount";
NSString *const kM_ProductListQuantity = @"quantity";

@interface M_ProductList ()
@end
@implementation M_ProductList




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kM_ProductListBrandid] isKindOfClass:[NSNull class]]){
		self.brandid = [dictionary[kM_ProductListBrandid] integerValue];
	}

	if(![dictionary[kM_ProductListBrandname] isKindOfClass:[NSNull class]]){
		self.brandname = dictionary[kM_ProductListBrandname];
	}	
	if(![dictionary[kM_ProductListCanaddtocart] isKindOfClass:[NSNull class]]){
		self.canaddtocart = [dictionary[kM_ProductListCanaddtocart] boolValue];
	}

	if(![dictionary[kM_ProductListCataloguedetail] isKindOfClass:[NSNull class]]){
		self.cataloguedetail = [[Cataloguedetail alloc] initWithDictionary:dictionary[kM_ProductListCataloguedetail]];
	}

	if(![dictionary[kM_ProductListCategoryid] isKindOfClass:[NSNull class]]){
		self.categoryid = [dictionary[kM_ProductListCategoryid] integerValue];
	}

	if(![dictionary[kM_ProductListCategoryname] isKindOfClass:[NSNull class]]){
		self.categoryname = dictionary[kM_ProductListCategoryname];
	}	
	if(![dictionary[kM_ProductListCoverimage] isKindOfClass:[NSNull class]]){
		self.coverimage = dictionary[kM_ProductListCoverimage];
	}	
	if(![dictionary[kM_ProductListDiscount] isKindOfClass:[NSNull class]]){
		self.discount = [dictionary[kM_ProductListDiscount] floatValue];
	}

	if(![dictionary[kM_ProductListIscatalogue] isKindOfClass:[NSNull class]]){
		self.iscatalogue = [dictionary[kM_ProductListIscatalogue] boolValue];
	}

	if(![dictionary[kM_ProductListIslimitedstock] isKindOfClass:[NSNull class]]){
		self.islimitedstock = [dictionary[kM_ProductListIslimitedstock] boolValue];
	}

	if(![dictionary[kM_ProductListIstrending] isKindOfClass:[NSNull class]]){
		self.istrending = [dictionary[kM_ProductListIstrending] boolValue];
	}

	if(![dictionary[kM_ProductListIswishlisetd] isKindOfClass:[NSNull class]]){
		self.iswishlisetd = [dictionary[kM_ProductListIswishlisetd] boolValue];
	}

	if(![dictionary[kM_ProductListItemid] isKindOfClass:[NSNull class]]){
		self.itemid = [dictionary[kM_ProductListItemid] integerValue];
	}

	if(![dictionary[kM_ProductListItemname] isKindOfClass:[NSNull class]]){
		self.itemname = dictionary[kM_ProductListItemname];
	}	
	if(![dictionary[kM_ProductListLongdescription] isKindOfClass:[NSNull class]]){
		self.longdescription = dictionary[kM_ProductListLongdescription];
	}	
	if(![dictionary[kM_ProductListMrp] isKindOfClass:[NSNull class]]){
		self.mrp = [dictionary[kM_ProductListMrp] floatValue];
	}

	if(![dictionary[kM_ProductListOfferprice] isKindOfClass:[NSNull class]]){
		self.offerprice = [dictionary[kM_ProductListOfferprice] floatValue];
	}

	if(![dictionary[kM_ProductListProductrating] isKindOfClass:[NSNull class]]){
		self.productrating = [dictionary[kM_ProductListProductrating] floatValue];
	}

	if(![dictionary[kM_ProductListShortdescription] isKindOfClass:[NSNull class]]){
		self.shortdescription = dictionary[kM_ProductListShortdescription];
	}	
    
    if(![dictionary[kM_ProductListTotalAmount] isKindOfClass:[NSNull class]]){
        self.totalAmount = [dictionary[kM_ProductListTotalAmount] floatValue];
    }

    if(![dictionary[kM_ProductListQuantity] isKindOfClass:[NSNull class]]){
        self.quantity = [dictionary[kM_ProductListQuantity] integerValue];
    }

    return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	dictionary[kM_ProductListBrandid] = @(self.brandid);
	if(self.brandname != nil){
		dictionary[kM_ProductListBrandname] = self.brandname;
	}
	dictionary[kM_ProductListCanaddtocart] = @(self.canaddtocart);
	if(self.cataloguedetail != nil){
		dictionary[kM_ProductListCataloguedetail] = [self.cataloguedetail toDictionary];
	}
	dictionary[kM_ProductListCategoryid] = @(self.categoryid);
	if(self.categoryname != nil){
		dictionary[kM_ProductListCategoryname] = self.categoryname;
	}
	if(self.coverimage != nil){
		dictionary[kM_ProductListCoverimage] = self.coverimage;
	}
	dictionary[kM_ProductListDiscount] = @(self.discount);
	dictionary[kM_ProductListIscatalogue] = @(self.iscatalogue);
	dictionary[kM_ProductListIslimitedstock] = @(self.islimitedstock);
	dictionary[kM_ProductListIstrending] = @(self.istrending);
	dictionary[kM_ProductListIswishlisetd] = @(self.iswishlisetd);
	dictionary[kM_ProductListItemid] = @(self.itemid);
	if(self.itemname != nil){
		dictionary[kM_ProductListItemname] = self.itemname;
	}
	if(self.longdescription != nil){
		dictionary[kM_ProductListLongdescription] = self.longdescription;
	}
	dictionary[kM_ProductListMrp] = @(self.mrp);
	dictionary[kM_ProductListOfferprice] = @(self.offerprice);
	dictionary[kM_ProductListProductrating] = @(self.productrating);
	if(self.shortdescription != nil){
		dictionary[kM_ProductListShortdescription] = self.shortdescription;
	}
    dictionary[kM_ProductListQuantity] = @(self.quantity);
    dictionary[kM_ProductListTotalAmount] = @(self.totalAmount);

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
	[aCoder encodeObject:@(self.brandid) forKey:kM_ProductListBrandid];	if(self.brandname != nil){
		[aCoder encodeObject:self.brandname forKey:kM_ProductListBrandname];
	}
	[aCoder encodeObject:@(self.canaddtocart) forKey:kM_ProductListCanaddtocart];	if(self.cataloguedetail != nil){
		[aCoder encodeObject:self.cataloguedetail forKey:kM_ProductListCataloguedetail];
	}
	[aCoder encodeObject:@(self.categoryid) forKey:kM_ProductListCategoryid];	if(self.categoryname != nil){
		[aCoder encodeObject:self.categoryname forKey:kM_ProductListCategoryname];
	}
	if(self.coverimage != nil){
		[aCoder encodeObject:self.coverimage forKey:kM_ProductListCoverimage];
	}
	[aCoder encodeObject:@(self.discount) forKey:kM_ProductListDiscount];	[aCoder encodeObject:@(self.iscatalogue) forKey:kM_ProductListIscatalogue];	[aCoder encodeObject:@(self.islimitedstock) forKey:kM_ProductListIslimitedstock];	[aCoder encodeObject:@(self.istrending) forKey:kM_ProductListIstrending];	[aCoder encodeObject:@(self.iswishlisetd) forKey:kM_ProductListIswishlisetd];	[aCoder encodeObject:@(self.itemid) forKey:kM_ProductListItemid];	if(self.itemname != nil){
		[aCoder encodeObject:self.itemname forKey:kM_ProductListItemname];
	}
	if(self.longdescription != nil){
		[aCoder encodeObject:self.longdescription forKey:kM_ProductListLongdescription];
	}
	[aCoder encodeObject:@(self.mrp) forKey:kM_ProductListMrp];	[aCoder encodeObject:@(self.offerprice) forKey:kM_ProductListOfferprice];	[aCoder encodeObject:@(self.productrating) forKey:kM_ProductListProductrating];	if(self.shortdescription != nil){
		[aCoder encodeObject:self.shortdescription forKey:kM_ProductListShortdescription];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.brandid = [[aDecoder decodeObjectForKey:kM_ProductListBrandid] integerValue];
	self.brandname = [aDecoder decodeObjectForKey:kM_ProductListBrandname];
	self.canaddtocart = [[aDecoder decodeObjectForKey:kM_ProductListCanaddtocart] boolValue];
	self.cataloguedetail = [aDecoder decodeObjectForKey:kM_ProductListCataloguedetail];
	self.categoryid = [[aDecoder decodeObjectForKey:kM_ProductListCategoryid] integerValue];
	self.categoryname = [aDecoder decodeObjectForKey:kM_ProductListCategoryname];
	self.coverimage = [aDecoder decodeObjectForKey:kM_ProductListCoverimage];
	self.discount = [[aDecoder decodeObjectForKey:kM_ProductListDiscount] floatValue];
	self.iscatalogue = [[aDecoder decodeObjectForKey:kM_ProductListIscatalogue] boolValue];
	self.islimitedstock = [[aDecoder decodeObjectForKey:kM_ProductListIslimitedstock] boolValue];
	self.istrending = [[aDecoder decodeObjectForKey:kM_ProductListIstrending] boolValue];
	self.iswishlisetd = [[aDecoder decodeObjectForKey:kM_ProductListIswishlisetd] boolValue];
	self.itemid = [[aDecoder decodeObjectForKey:kM_ProductListItemid] integerValue];
	self.itemname = [aDecoder decodeObjectForKey:kM_ProductListItemname];
	self.longdescription = [aDecoder decodeObjectForKey:kM_ProductListLongdescription];
	self.mrp = [[aDecoder decodeObjectForKey:kM_ProductListMrp] floatValue];
	self.offerprice = [[aDecoder decodeObjectForKey:kM_ProductListOfferprice] floatValue];
	self.productrating = [[aDecoder decodeObjectForKey:kM_ProductListProductrating] floatValue];
	self.shortdescription = [aDecoder decodeObjectForKey:kM_ProductListShortdescription];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	M_ProductList *copy = [M_ProductList new];

	copy.brandid = self.brandid;
	copy.brandname = [self.brandname copy];
	copy.canaddtocart = self.canaddtocart;
	copy.cataloguedetail = [self.cataloguedetail copy];
	copy.categoryid = self.categoryid;
	copy.categoryname = [self.categoryname copy];
	copy.coverimage = [self.coverimage copy];
	copy.discount = self.discount;
	copy.iscatalogue = self.iscatalogue;
	copy.islimitedstock = self.islimitedstock;
	copy.istrending = self.istrending;
	copy.iswishlisetd = self.iswishlisetd;
	copy.itemid = self.itemid;
	copy.itemname = [self.itemname copy];
	copy.longdescription = [self.longdescription copy];
	copy.mrp = self.mrp;
	copy.offerprice = self.offerprice;
	copy.productrating = self.productrating;
	copy.shortdescription = [self.shortdescription copy];

	return copy;
}
@end
