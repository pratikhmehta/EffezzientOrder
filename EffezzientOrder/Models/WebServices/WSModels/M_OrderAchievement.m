//
//  OrderAchievement.m
//
//  Created by Uday Desai on 26/11/18
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import "M_OrderAchievement.h"


NSString *const kOrderAchievementOrderachievement = @"orderachievement";
NSString *const kOrderAchievementOrderachievementid = @"orderachievementid";


@interface M_OrderAchievement ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation M_OrderAchievement

@synthesize orderachievement = _orderachievement;
@synthesize orderachievementid = _orderachievementid;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.orderachievement = [self objectOrNilForKey:kOrderAchievementOrderachievement fromDictionary:dict];
            self.orderachievementid = [self objectOrNilForKey:kOrderAchievementOrderachievementid fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.orderachievement forKey:kOrderAchievementOrderachievement];
    [mutableDict setValue:self.orderachievementid forKey:kOrderAchievementOrderachievementid];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict {
    id object = [dict objectForKey:aKey];
    if ([object isKindOfClass:[NSNumber class]])
    {
        object = [NSString stringWithFormat:@"%@", object];
    }
    return [object isEqual:[NSNull null]] ? @"" : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];

    self.orderachievement = [aDecoder decodeObjectForKey:kOrderAchievementOrderachievement];
    self.orderachievementid = [aDecoder decodeObjectForKey:kOrderAchievementOrderachievementid];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_orderachievement forKey:kOrderAchievementOrderachievement];
    [aCoder encodeObject:_orderachievementid forKey:kOrderAchievementOrderachievementid];
}

- (id)copyWithZone:(NSZone *)zone {
    M_OrderAchievement *copy = [[M_OrderAchievement alloc] init];
    
    
    
    if (copy) {

        copy.orderachievement = [self.orderachievement copyWithZone:zone];
        copy.orderachievementid = [self.orderachievementid copyWithZone:zone];
    }
    
    return copy;
}


@end
