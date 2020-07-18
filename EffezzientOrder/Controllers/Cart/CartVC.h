//
//  CartVC.h
//  Meril
//
//  Created by Inspiro Infotech on 07/02/20.
//  Copyright © 2020 Inspiro Infotech. All rights reserved.
//

#import "BaseVC.h"
#import "YBCardView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CartVC : BaseVC

@property (strong, nonatomic) IBOutlet UITableView *tblView;
@property (strong, nonatomic) IBOutlet YBCardView *bottomButtonsContainer;
@property (strong, nonatomic) IBOutlet UILabel *lblOrderTotal;
@property (strong, nonatomic) IBOutlet UILabel *lblBtnPlaceOrConfirmOrder;
@property (strong, nonatomic) IBOutlet UIImageView *imgCartEmpty;
@property (strong, nonatomic) IBOutlet UIView *emptyCartButtonsContainer;
- (IBAction)btnGoToHomeClicked:(id)sender;
- (IBAction)btnContinueShopping:(id)sender;


- (IBAction)btnViewDetailsClicked:(id)sender;
- (IBAction)btnPlaceOrderClicked:(id)sender;

@property (nonatomic) BOOL isReadOnly;

@end

NS_ASSUME_NONNULL_END
