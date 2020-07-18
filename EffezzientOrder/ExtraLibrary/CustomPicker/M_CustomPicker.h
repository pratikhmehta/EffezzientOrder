//
//  M_CustomPicker.h
//  Effezient
//
//  Created by Yahya Bagia on 22/10/18.
//  Copyright © 2018 Inspiro Infotech. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface M_CustomPicker : NSObject

@property (nonatomic) NSInteger key;
@property (nonatomic) NSString *value;

@property (nonatomic) id customObject;

-(id)initWithKey:(NSInteger)key andValue:(NSString *)value;

-(id)initWithKey:(NSInteger)key Value:(NSString *)value andCustomObject:(id)customObject;

@end

NS_ASSUME_NONNULL_END
