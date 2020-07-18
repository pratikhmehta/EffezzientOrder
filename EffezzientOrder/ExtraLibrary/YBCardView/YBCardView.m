//
//  YBCardView.m
//  AwqatSalah
//
//  Created by Yahya on 22/12/17.
//  Copyright © 2017 Yahya. All rights reserved.
//

#import "YBCardView.h"

@implementation YBCardView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)layoutSubviews{
    if(_useIBInspectables == NO){
        _cornerRadius = 4;
        _shadowOffsetWidth = 0;
        _shadowOffsetHeight = 0;
        _shadowColor = [UIColor blackColor];
        _shadowOpacity = 0.5;
    }
    
    self.layer.cornerRadius = _cornerRadius;
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:_cornerRadius];
    
    self.layer.masksToBounds = NO;
    self.layer.shadowColor = _shadowColor.CGColor;
    self.layer.shadowOffset = CGSizeMake(_shadowOffsetWidth, _shadowOffsetHeight);
    self.layer.shadowOpacity = _shadowOpacity;
    self.layer.shadowPath = shadowPath.CGPath;
    
}

@end
