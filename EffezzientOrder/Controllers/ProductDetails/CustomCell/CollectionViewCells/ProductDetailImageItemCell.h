//
//  ProductDetailImageItemCell.h
//  Meril
//
//  Created by Inspiro Infotech on 24/01/20.
//  Copyright © 2020 Inspiro Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProductDetailImageItemCell : UICollectionViewCell<UIScrollViewDelegate>

- (void)setup;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIImageView *itemImage;

@end

NS_ASSUME_NONNULL_END
