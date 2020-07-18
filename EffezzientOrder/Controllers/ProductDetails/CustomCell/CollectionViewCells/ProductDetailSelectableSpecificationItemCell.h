//
//  ProductDetailSelectableSpecificationItemCell.h
//  Meril
//
//  Created by Inspiro Infotech on 31/01/20.
//  Copyright © 2020 Inspiro Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProductDetailSelectableSpecificationItemCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIView *containerView;
@property (strong, nonatomic) IBOutlet UILabel *lblSpecTitle;
@property (strong, nonatomic) IBOutlet UILabel *lblSpecValue;

@end

NS_ASSUME_NONNULL_END
