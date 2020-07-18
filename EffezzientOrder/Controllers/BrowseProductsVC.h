//
//  BrowseProductsVC.h
//  Meril
//
//  Created by Inspiro Infotech on 20/01/20.
//  Copyright © 2020 Inspiro Infotech. All rights reserved.
//

#import "BaseVC.h"
#import "M_ProductList.h"

NS_ASSUME_NONNULL_BEGIN

@protocol WishListItemsChangeDelegate <NSObject>

-(void)itemRemovedFromWishList:(M_ProductList *)product;

@end

@interface BrowseProductsVC : BaseVC

@property (nonatomic, weak) id<WishListItemsChangeDelegate> delegate;

@property (strong, nonatomic) IBOutlet UISearchBar *txtSearch;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightOfSearchBar;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet UIImageView *imgNoDataFound;
@property (strong, nonatomic) IBOutlet UILabel *lblScrollToTopProductCount;
@property (strong, nonatomic) IBOutlet UIView *vwScrollToTop;
@property (strong, nonatomic) IBOutlet UIView *vwFilterIndication;

@property (nonatomic) BOOL isOnWishlist;

- (IBAction)btnSortClicked:(id)sender;
- (IBAction)btnFilterClicked:(id)sender;

@end

NS_ASSUME_NONNULL_END
