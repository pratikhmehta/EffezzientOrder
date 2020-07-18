//
//  CustomTableViewCell.h
//  MerilInternational
//
//  Created by apple on 9/6/17.
//  Copyright © 2017 meril. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UILabel *lblTitle;

@property (strong, nonatomic) IBOutlet UIView *viewCellBg;
@property (strong, nonatomic) IBOutlet UITextField *txtQuantity;
@property (strong, nonatomic) IBOutlet UILabel *lblQuantity;


// Instant Order
@property (strong, nonatomic) IBOutlet UILabel *lblProductName;
@property (strong, nonatomic) IBOutlet UILabel *lblProductSpecifications;
@property (strong, nonatomic) IBOutlet UILabel *lblProductMRP;
@property (strong, nonatomic) IBOutlet UILabel *lblProductOfferPrice;
@property (strong, nonatomic) IBOutlet UILabel *lblProductAmount;

@property (strong, nonatomic) IBOutlet UIView *vwQuantity;

@property (strong, nonatomic) IBOutlet UILabel *lblReadOnlyQuantity;
@property (strong, nonatomic) IBOutlet UIButton *btnMinus;
@property (strong, nonatomic) IBOutlet UIButton *btnPlus;


@end

