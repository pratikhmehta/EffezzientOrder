//
//  M_FormConfiguration.m
//
//  Created by   on 19/06/19
//  Copyright (c) 2019 __MyCompanyName__. All rights reserved.
//

#import "M_FormConfiguration.h"


NSString *const kM_FormConfigurationMobileorder = @"mobileorder";
NSString *const kM_FormConfigurationBoxid = @"boxid";
NSString *const kM_FormConfigurationActualid = @"actualid";
NSString *const kM_FormConfigurationIsfilterable = @"isfilterable";
NSString *const kM_FormConfigurationIosBoxId = @"iosBoxId";
NSString *const kM_FormConfigurationIsenable = @"isenable";
NSString *const kM_FormConfigurationIssystem = @"issystem";
NSString *const kM_FormConfigurationIsrequired = @"isrequired";
NSString *const kM_FormConfigurationVisible = @"visible";
NSString *const kM_FormConfigurationIsinstantview = @"isinstantview";
NSString *const kM_FormConfigurationControlid = @"controlid";
NSString *const kM_FormConfigurationNewlabelname = @"newlabelname";


@interface M_FormConfiguration ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation M_FormConfiguration

@synthesize mobileorder = _mobileorder;
@synthesize boxid = _boxid;
@synthesize actualid = _actualid;
@synthesize isfilterable = _isfilterable;
@synthesize iosBoxId = _iosBoxId;
@synthesize isenable = _isenable;
@synthesize issystem = _issystem;
@synthesize isrequired = _isrequired;
@synthesize visible = _visible;
@synthesize isinstantview = _isinstantview;
@synthesize controlid = _controlid;
@synthesize newlabelname = _newlabelname;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
        self.mobileorder = [[self objectOrNilForKey:kM_FormConfigurationMobileorder fromDictionary:dict] doubleValue];
        self.boxid = [self objectOrNilForKey:kM_FormConfigurationBoxid fromDictionary:dict];
        self.actualid = [self objectOrNilForKey:kM_FormConfigurationActualid fromDictionary:dict];
        self.isfilterable = [[self objectOrNilForKey:kM_FormConfigurationIsfilterable fromDictionary:dict] boolValue];
        self.iosBoxId = [[self objectOrNilForKey:kM_FormConfigurationIosBoxId fromDictionary:dict] doubleValue];
        self.isenable = [[self objectOrNilForKey:kM_FormConfigurationIsenable fromDictionary:dict] boolValue];
        self.issystem = [[self objectOrNilForKey:kM_FormConfigurationIssystem fromDictionary:dict] boolValue];
        self.isrequired = [[self objectOrNilForKey:kM_FormConfigurationIsrequired fromDictionary:dict] boolValue];
        self.visible = [[self objectOrNilForKey:kM_FormConfigurationVisible fromDictionary:dict] boolValue];
        self.isinstantview = [[self objectOrNilForKey:kM_FormConfigurationIsinstantview fromDictionary:dict] boolValue];
        self.controlid = [self objectOrNilForKey:kM_FormConfigurationControlid fromDictionary:dict];
        self.newlabelname = [self objectOrNilForKey:kM_FormConfigurationNewlabelname fromDictionary:dict];
        
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.mobileorder] forKey:kM_FormConfigurationMobileorder];
    [mutableDict setValue:self.boxid forKey:kM_FormConfigurationBoxid];
    [mutableDict setValue:self.actualid forKey:kM_FormConfigurationActualid];
    [mutableDict setValue:[NSNumber numberWithBool:self.isfilterable] forKey:kM_FormConfigurationIsfilterable];
    [mutableDict setValue:[NSNumber numberWithDouble:self.iosBoxId] forKey:kM_FormConfigurationIosBoxId];
    [mutableDict setValue:[NSNumber numberWithBool:self.isenable] forKey:kM_FormConfigurationIsenable];
    [mutableDict setValue:[NSNumber numberWithBool:self.issystem] forKey:kM_FormConfigurationIssystem];
    [mutableDict setValue:[NSNumber numberWithBool:self.isrequired] forKey:kM_FormConfigurationIsrequired];
    [mutableDict setValue:[NSNumber numberWithBool:self.visible] forKey:kM_FormConfigurationVisible];
    [mutableDict setValue:[NSNumber numberWithBool:self.isinstantview] forKey:kM_FormConfigurationIsinstantview];
    [mutableDict setValue:self.controlid forKey:kM_FormConfigurationControlid];
    [mutableDict setValue:self.newlabelname forKey:kM_FormConfigurationNewlabelname];
    
    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict {
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    
    self.mobileorder = [aDecoder decodeDoubleForKey:kM_FormConfigurationMobileorder];
    self.boxid = [aDecoder decodeObjectForKey:kM_FormConfigurationBoxid];
    self.actualid = [aDecoder decodeObjectForKey:kM_FormConfigurationActualid];
    self.isfilterable = [aDecoder decodeBoolForKey:kM_FormConfigurationIsfilterable];
    self.iosBoxId = [aDecoder decodeDoubleForKey:kM_FormConfigurationIosBoxId];
    self.isenable = [aDecoder decodeBoolForKey:kM_FormConfigurationIsenable];
    self.issystem = [aDecoder decodeBoolForKey:kM_FormConfigurationIssystem];
    self.isrequired = [aDecoder decodeBoolForKey:kM_FormConfigurationIsrequired];
    self.visible = [aDecoder decodeBoolForKey:kM_FormConfigurationVisible];
    self.isinstantview = [aDecoder decodeBoolForKey:kM_FormConfigurationIsinstantview];
    self.controlid = [aDecoder decodeObjectForKey:kM_FormConfigurationControlid];
    self.newlabelname = [aDecoder decodeObjectForKey:kM_FormConfigurationNewlabelname];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeDouble:_mobileorder forKey:kM_FormConfigurationMobileorder];
    [aCoder encodeObject:_boxid forKey:kM_FormConfigurationBoxid];
    [aCoder encodeObject:_actualid forKey:kM_FormConfigurationActualid];
    [aCoder encodeBool:_isfilterable forKey:kM_FormConfigurationIsfilterable];
    [aCoder encodeDouble:_iosBoxId forKey:kM_FormConfigurationIosBoxId];
    [aCoder encodeBool:_isenable forKey:kM_FormConfigurationIsenable];
    [aCoder encodeBool:_issystem forKey:kM_FormConfigurationIssystem];
    [aCoder encodeBool:_isrequired forKey:kM_FormConfigurationIsrequired];
    [aCoder encodeBool:_visible forKey:kM_FormConfigurationVisible];
    [aCoder encodeBool:_isinstantview forKey:kM_FormConfigurationIsinstantview];
    [aCoder encodeObject:_controlid forKey:kM_FormConfigurationControlid];
    [aCoder encodeObject:_newlabelname forKey:kM_FormConfigurationNewlabelname];
}

- (id)copyWithZone:(NSZone *)zone {
    M_FormConfiguration *copy = [[M_FormConfiguration alloc] init];
    
    
    
    if (copy) {
        
        copy.mobileorder = self.mobileorder;
        copy.boxid = [self.boxid copyWithZone:zone];
        copy.actualid = [self.actualid copyWithZone:zone];
        copy.isfilterable = self.isfilterable;
        copy.iosBoxId = self.iosBoxId;
        copy.isenable = self.isenable;
        copy.issystem = self.issystem;
        copy.isrequired = self.isrequired;
        copy.visible = self.visible;
        copy.isinstantview = self.isinstantview;
        copy.controlid = [self.controlid copyWithZone:zone];
        copy.newlabelname = [self.newlabelname copyWithZone:zone];
    }
    
    return copy;
}


@end
