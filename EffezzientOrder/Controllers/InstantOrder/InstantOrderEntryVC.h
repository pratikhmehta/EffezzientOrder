//
//  InstantOrderEntryVC.h
//  Meril
//
//  Created by Inspiro Infotech on 26/06/20.
//  Copyright © 2020 Inspiro Infotech. All rights reserved.
//

#import "BaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface InstantOrderEntryVC : BaseVC

@property (nonatomic, strong) NSString *categoryID;
@property (strong, nonatomic) IBOutlet UISearchBar *txtSearch;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightOfSearchBar;

@property (strong, nonatomic) IBOutlet UIView *viewTotalOrderAmount;
@property (strong, nonatomic) IBOutlet UILabel *lblTotalOrderAmount;
@property (strong, nonatomic) IBOutlet UILabel *lblTotalOrderQuantity;

@property (strong, nonatomic) IBOutlet UITableView *tblProducts;
@property (strong, nonatomic) IBOutlet UIButton *btnAddToCart;
@property (nonatomic, strong) NSMutableArray *arrSelectedFilter;

- (IBAction)btnAddToCartClicked:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
