//
//  ShareInfo.h
//  Meril
//
//  Created by Manish Patel on 24/04/17.
//  Copyright © 2017 Manish Patel. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^loadCompletion)(BOOL flag);

@interface ShareInfo : NSObject
{
    NSString *personId;
    NSString *companyId;
    NSString *personName;
    NSString *domainName;
    
    NSString *userTimeZone;
    NSString *userTimeZoneID;
    NSString *userTimeZoneAlias;
}

@property(nonatomic,retain) NSString *personId;
@property(nonatomic,retain) NSString *companyId;
@property(nonatomic,retain) NSString *personName;

@property(nonatomic,retain) NSString *userTimeZone;
@property(nonatomic,retain) NSString *userTimeZoneID;
@property(nonatomic,retain) NSString *userTimeZoneAlias;

@property(nonatomic,copy) loadCompletion completionBlock;

+(ShareInfo *)sharedManagerInfo;

@end
