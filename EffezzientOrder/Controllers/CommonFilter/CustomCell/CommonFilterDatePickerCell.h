//
//  CommonFilterDatePickerCell.h
//  Meril
//
//  Created by Inspiro Infotech on 14/03/20.
//  Copyright © 2020 Inspiro Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommonFilterDatePickerCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
@property (strong, nonatomic) IBOutlet UILabel *lblValue;

@property (nonatomic, retain) NSDate *selectedDate;

@end

NS_ASSUME_NONNULL_END
