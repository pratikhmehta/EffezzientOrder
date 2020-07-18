//
//  CommonFilterDatePickerCell.m
//  Meril
//
//  Created by Inspiro Infotech on 14/03/20.
//  Copyright © 2020 Inspiro Infotech. All rights reserved.
//

#import "CommonFilterDatePickerCell.h"

@implementation CommonFilterDatePickerCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)setSelectedDate:(NSDate *)selectedDate{
    _selectedDate = selectedDate;
    _lblValue.text = [Global getStringFromDate:_selectedDate formatter:@"dd-MM-yyyy"];
}

@end
