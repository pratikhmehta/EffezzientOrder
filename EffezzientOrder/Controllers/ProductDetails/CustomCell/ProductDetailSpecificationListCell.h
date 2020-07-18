//
//  ProductDetailSpecificationListCell.h
//  Meril
//
//  Created by Inspiro Infotech on 24/01/20.
//  Copyright © 2020 Inspiro Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProductDetailSpecificationListCell : UITableViewCell<UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, retain) NSMutableArray *arrSpecs;

@end

NS_ASSUME_NONNULL_END
