//
//  ShareInfo.m
//  Meril
//
//  Created by Manish Patel on 24/04/17.
//  Copyright © 2017 Manish Patel. All rights reserved.
//

#import "ShareInfo.h"

ShareInfo *sharedManagerInfo = nil;

@implementation ShareInfo

@synthesize personId;
@synthesize companyId;
@synthesize personName;
@synthesize userTimeZone;
@synthesize userTimeZoneID;
@synthesize userTimeZoneAlias;

+(ShareInfo *)sharedManagerInfo
{
    if(sharedManagerInfo == nil)
    {
        sharedManagerInfo = [[ShareInfo alloc] init];
        
        [sharedManagerInfo customInit];
        
    }
    return sharedManagerInfo;
}

-(void)customInit
{}

@end
