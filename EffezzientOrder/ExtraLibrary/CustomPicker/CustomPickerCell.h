//
//  CustomPickerCell.h
//  Effezient
//
//  Created by Yahya Bagia on 20/10/18.
//  Copyright © 2018 Inspiro Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "M_CustomPicker.h"

NS_ASSUME_NONNULL_BEGIN

@interface CustomPickerCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgCheck;
@property (weak, nonatomic) IBOutlet UILabel *lblItem;

@property (nonatomic, retain) M_CustomPicker *model;

@end

NS_ASSUME_NONNULL_END
