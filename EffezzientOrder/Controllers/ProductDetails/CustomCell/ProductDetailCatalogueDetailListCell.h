//
//  ProductDetailCatalogueDetailListCell.h
//  Meril
//
//  Created by Inspiro Infotech on 28/01/20.
//  Copyright © 2020 Inspiro Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProductDetailCatalogueDetailListCell : UITableViewCell<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, retain) NSMutableArray *arrCatalogueItemsProducts;

@end

NS_ASSUME_NONNULL_END
