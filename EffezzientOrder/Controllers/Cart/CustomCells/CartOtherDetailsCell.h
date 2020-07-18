//
//  CartOtherDetailsCell.h
//  Meril
//
//  Created by Inspiro Infotech on 07/02/20.
//  Copyright © 2020 Inspiro Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CartOtherDetailsCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIView *vwSaveContainer;
@property (strong, nonatomic) IBOutlet UIButton *btnSave;

@property (strong, nonatomic) IBOutlet UIButton *btnDistributor;
@property (strong, nonatomic) IBOutlet UIButton *btnOrderAchievement;
@property (strong, nonatomic) IBOutlet UIButton *btnExpectedDelivery;
@property (strong, nonatomic) IBOutlet UIButton *btnDispatchMode;
@property (strong, nonatomic) IBOutlet UILabel *lblFreight;
@property (strong, nonatomic) IBOutlet UIButton *btnFreight;
@property (strong, nonatomic) IBOutlet UIView *viewDistributor;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *viewDistributorHeight;
@property (strong, nonatomic) IBOutlet UIView *viewOrderAchievement;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *viewOrderAchievementHeight;
@property (strong, nonatomic) IBOutlet UIView *viewExpectedDeliveryDate;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *viewExpectedDeliveryDateHeight;
@property (strong, nonatomic) IBOutlet UIView *viewDispatchMode;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *viewDispatchModeHeight;
@property (strong, nonatomic) IBOutlet UIView *viewFreight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *viewFreightHeight;

@end

NS_ASSUME_NONNULL_END
