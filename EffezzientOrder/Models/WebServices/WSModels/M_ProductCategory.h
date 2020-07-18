//
//  ProductCategory.h
//
//  Created by apple  on 11/3/17
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface M_ProductCategory : NSObject <NSCoding>

@property (nonatomic, strong) NSString *categoryname;
@property (nonatomic, strong) NSString *categoryid;

+ (M_ProductCategory *)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
