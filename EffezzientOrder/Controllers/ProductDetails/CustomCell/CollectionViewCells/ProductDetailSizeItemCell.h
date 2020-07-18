//
//  ProductDetailSizeItemCell.h
//  Meril
//
//  Created by Inspiro Infotech on 24/01/20.
//  Copyright © 2020 Inspiro Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProductDetailSizeItemCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIView *vwSizeLabelContainer;
@property (strong, nonatomic) IBOutlet UILabel *lblSizeName;
@property (strong, nonatomic) IBOutlet UIView *vwLimitedContainer;

@end

NS_ASSUME_NONNULL_END
