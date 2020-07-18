//
//  ProductDetailSelectableSpecificationListCell.h
//  Meril
//
//  Created by Inspiro Infotech on 31/01/20.
//  Copyright © 2020 Inspiro Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProductDetailSelectableSpecificationListCell : UITableViewCell<UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, retain) NSMutableArray *arrSelectableSpecs;
@property (nonatomic, retain) NSMutableArray *arrPreSelectedSpecs;

@end

NS_ASSUME_NONNULL_END
