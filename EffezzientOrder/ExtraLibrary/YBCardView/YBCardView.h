//
//  YBCardView.h
//  AwqatSalah
//
//  Created by Yahya on 22/12/17.
//  Copyright © 2017 Yahya. All rights reserved.
//

//https://github.com/aclissold/CardView/

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface YBCardView : UIView

@property (nonatomic) IBInspectable BOOL    useIBInspectables;

@property (nonatomic) IBInspectable CGFloat cornerRadius;
@property (nonatomic) IBInspectable CGFloat shadowOffsetWidth;
@property (nonatomic) IBInspectable CGFloat shadowOffsetHeight;
@property (nonatomic) IBInspectable UIColor *shadowColor;
@property (nonatomic) IBInspectable CGFloat shadowOpacity;

@end
