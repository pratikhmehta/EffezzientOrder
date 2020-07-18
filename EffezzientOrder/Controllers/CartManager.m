//
//  CartManager.m
//  Meril
//
//  Created by Inspiro Infotech on 12/02/20.
//  Copyright © 2020 Inspiro Infotech. All rights reserved.
//

#import "CartManager.h"

@implementation CartManager

+ (instancetype)sharedObject {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

-(void)refreshCartCount{
    if ([Global checkForConnection])
    {
        NSDictionary *params = @{
                                 @"companyid" : [ShareInfo sharedManagerInfo].companyId,
                                 @"personId" : [ShareInfo sharedManagerInfo].personId,
                                 @"DistributorId": @(_distributorId),
                                 @"CcustomerId": @(_customerId),
                                 @"DistributorCustomerId": @(_distributorCustomerId)
                                 };
        
        NSString *apiName = URLGetCartCount;
        [[WebServiceConnector alloc] init:apiName
                           withParameters:params
                               withObject:self
                             withSelector:@selector(getUpdateQuantityResponse:)
                           forServiceType:@"JSON"
                           showDisplayMsg:nil];
    }
}

-(void)getUpdateQuantityResponse:(id)sender{
    if([[[sender responseDict] valueForKey:kStatusCode] boolValue])
    {
        [self setCartCount:[[sender responseArray] firstObject]];
    }
    else
    {
        NSString *errorMsg = [[[sender responseDict] valueForKey: kErrorData] valueForKey:kErrorMessage];
        NSLog(@"%@", errorMsg);
    }
}

#pragma mark -

-(void)setCartCount:(M_CartCount *)cartCount{
    _cartCount = cartCount;
    if(_delegate){
        [_delegate onRefreshCartCount:_cartCount.cartCount];
    }
}

//-(void)setSelectedDistributorDetails:(NSDictionary *)selectedDistributorDetails{
//    _selectedDistributorDetails = selectedDistributorDetails;
//
//    NSDictionary *selectedCustomer = _selectedDistributorDetails[MM_Customer];
//    _distributorCustomerId = [selectedCustomer[MM_DistributorCustomerId] integerValue];
//    _customerId = [selectedCustomer[MM_CustomerId] integerValue];
//    _distributorId = [_selectedDistributorDetails[MM_DistributorId] integerValue];
//}

@end
