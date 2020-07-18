//
//  CartManager.h
//  Meril
//
//  Created by Inspiro Infotech on 12/02/20.
//  Copyright © 2020 Inspiro Infotech. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "M_CartCount.h"

NS_ASSUME_NONNULL_BEGIN

@protocol CartCountDelegate

@optional
-(void)onRefreshCartCount:(NSInteger)cartCount;
@end

@interface CartManager : NSObject

+ (instancetype)sharedObject;

-(void)refreshCartCount;

@property (nonatomic, retain) M_CartCount *cartCount;

//@property (nonatomic, retain) NSDictionary *selectedDistributorDetails;
@property (nonatomic) NSInteger distributorId;
@property (nonatomic) NSInteger customerId;
@property (nonatomic) NSInteger distributorCustomerId;

@property (nonatomic, retain) NSString *type; //SalesPerson - U | POB - O | Prescription - P
@property (nonatomic, retain) NSString *orderType; //Checkin - checkin | Direct - direct

@property (nonatomic,retain) id<CartCountDelegate> delegate;;

@end

NS_ASSUME_NONNULL_END
