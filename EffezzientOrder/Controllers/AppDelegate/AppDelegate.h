//
//  AppDelegate.h
//  Meril
//
//  Created by Manish Patel on 19/04/17.
//  Copyright © 2017 Manish Patel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic) BOOL isNotification;
@property (nonatomic, retain) NSString *type;
@property (nonatomic, retain) NSString *taskId;
@property (nonatomic, retain) NSString *notificationType;

@property (nonatomic, retain) NSIndexPath *leftMenuFirstVisibleIndexPath;
@property (nonatomic, retain) NSIndexPath *leftMenuSelectedIndexPath;

@end
