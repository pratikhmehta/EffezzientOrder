//
//  M_FormConfiguration.h
//
//  Created by   on 19/06/19
//  Copyright (c) 2019 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface M_FormConfiguration : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double mobileorder;
@property (nonatomic, strong) NSString *boxid;
@property (nonatomic, strong) NSString *actualid;
@property (nonatomic, assign) BOOL isfilterable;
@property (nonatomic, assign) double iosBoxId;
@property (nonatomic, assign) BOOL isenable;
@property (nonatomic, assign) BOOL issystem;
@property (nonatomic, assign) BOOL isrequired;
@property (nonatomic, assign) BOOL visible;
@property (nonatomic, assign) BOOL isinstantview;
@property (nonatomic, strong) NSString *controlid;
@property (nonatomic, strong) NSString *newlabelname;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
