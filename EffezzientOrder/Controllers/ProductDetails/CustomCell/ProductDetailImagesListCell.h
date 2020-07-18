//
//  ProductDetailImagesListCell.h
//  Meril
//
//  Created by Inspiro Infotech on 24/01/20.
//  Copyright © 2020 Inspiro Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProductDetailImagesListCell : UITableViewCell<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;

@property (nonatomic, retain) NSMutableArray *arrImages;

@property (nonatomic) id selectorObject;
@property (nonatomic) SEL onPressImage;

@end

NS_ASSUME_NONNULL_END
