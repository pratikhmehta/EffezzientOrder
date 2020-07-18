//
//  CustomTableViewCell.m
//  MerilInternational
//
//  Created by apple on 9/6/17.
//  Copyright © 2017 meril. All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.txtQuantity.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
