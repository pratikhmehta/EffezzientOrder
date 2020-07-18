//
//  CommonFilterOptionCell.h
//  Meril
//
//  Created by Inspiro Infotech on 20/01/20.
//  Copyright © 2020 Inspiro Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommonFilterOptionCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imgCheckOrRadio;
@property (strong, nonatomic) IBOutlet UILabel *lblOption;
@property (strong, nonatomic) IBOutlet UILabel *lblTotal;

@end

NS_ASSUME_NONNULL_END
