//
//  M_CustomPicker.m
//  Effezient
//
//  Created by Yahya Bagia on 22/10/18.
//  Copyright © 2018 Inspiro Infotech. All rights reserved.
//

#import "M_CustomPicker.h"

@implementation M_CustomPicker

-(id)initWithKey:(NSInteger)key andValue:(NSString *)value{
    self = [super init];
    if(self){
        _key = key;
        _value = value;
    }
    return self;
}

-(id)initWithKey:(NSInteger)key Value:(NSString *)value andCustomObject:(id)customObject{
    self = [super init];
    if(self){
        _key = key;
        _value = value;
        _customObject = customObject;
    }
    return self;
}

@end
