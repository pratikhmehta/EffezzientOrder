//
//  ProductCategory.m
//
//  Created by apple  on 11/3/17
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "M_ProductCategory.h"


NSString *const kProductCategoryCategoryname = @"categoryname";
NSString *const kProductCategoryCategoryid = @"categoryid";


@interface M_ProductCategory ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation M_ProductCategory

@synthesize categoryname = _categoryname;
@synthesize categoryid = _categoryid;


+ (M_ProductCategory *)modelObjectWithDictionary:(NSDictionary *)dict
{
    M_ProductCategory *instance = [[M_ProductCategory alloc] initWithDictionary:dict];
    return instance;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.categoryname = [self objectOrNilForKey:kProductCategoryCategoryname fromDictionary:dict];
            self.categoryid = [self objectOrNilForKey:kProductCategoryCategoryid fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.categoryname forKey:kProductCategoryCategoryname];
    [mutableDict setValue:self.categoryid forKey:kProductCategoryCategoryid];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    if ([object isKindOfClass:[NSNumber class]])
    {
        object = [NSString stringWithFormat:@"%@", object];
    }
    return [object isEqual:[NSNull null]] ? @"" : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.categoryname = [aDecoder decodeObjectForKey:kProductCategoryCategoryname];
    self.categoryid = [aDecoder decodeObjectForKey:kProductCategoryCategoryid];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_categoryname forKey:kProductCategoryCategoryname];
    [aCoder encodeObject:_categoryid forKey:kProductCategoryCategoryid];
}


@end
