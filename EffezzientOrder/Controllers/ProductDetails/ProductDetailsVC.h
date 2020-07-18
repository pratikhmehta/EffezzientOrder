//
//  ProductDetailsVC.h
//  Meril
//
//  Created by Inspiro Infotech on 24/01/20.
//  Copyright © 2020 Inspiro Infotech. All rights reserved.
//

#import "BaseVC.h"
#import "FaveButton.h"

#import "M_ProductList.h"
#import "M_CartDetail.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProductDetailsVC : BaseVC

@property (nonatomic, retain) M_ProductList *selectedProduct;

@property (nonatomic, retain) M_CartDetail *selectedCartItem;

@property (strong, nonatomic) IBOutlet UITableView *tblView;

@property (strong, nonatomic) IBOutlet UIView *btnWishlistContainer;
@property (strong, nonatomic) IBOutlet UIView *btnAddToBagContainer;

@property (strong, nonatomic) IBOutlet FaveButton *btnWishlistHeart;
@property (strong, nonatomic) IBOutlet UILabel *lblBtnWishList;
- (IBAction)btnWishlistClicked:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *lblBtnAddUpdateCart;
- (IBAction)btnAddToCartClicked:(id)sender;

@property (nonatomic) BOOL cameFromWishList;

@end

NS_ASSUME_NONNULL_END
