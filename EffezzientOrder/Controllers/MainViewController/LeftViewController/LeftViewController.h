//
//  LeftViewController.h
//  LGSideMenuControllerDemo
//
//  Created by Grigory Lutkov on 18.02.15.
//  Copyright (c) 2015 Grigory Lutkov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftViewController : UITableViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) UIColor *tintColor;
@property (strong, nonatomic) UIView *headerView;

@end
