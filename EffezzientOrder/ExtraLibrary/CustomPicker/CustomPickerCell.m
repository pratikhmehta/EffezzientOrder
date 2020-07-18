//
//  CustomPickerCell.m
//  Effezient
//
//  Created by Yahya Bagia on 20/10/18.
//  Copyright © 2018 Inspiro Infotech. All rights reserved.
//

#import "CustomPickerCell.h"

@implementation CustomPickerCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)setModel:(M_CustomPicker *)model{
    _lblItem.text = model.value;
    _lblItem.tag = model.key;
}

@end
