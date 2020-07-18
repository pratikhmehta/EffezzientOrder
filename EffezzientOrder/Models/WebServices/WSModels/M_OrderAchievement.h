//
//  OrderAchievement.h
//
//  Created by Uday Desai on 26/11/18
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface M_OrderAchievement : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *orderachievement;
@property (nonatomic, strong) NSString *orderachievementid;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
