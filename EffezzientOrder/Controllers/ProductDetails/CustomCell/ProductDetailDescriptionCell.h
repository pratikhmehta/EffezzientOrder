//
//  ProductDetailDescriptionCell.h
//  Meril
//
//  Created by Inspiro Infotech on 24/01/20.
//  Copyright © 2020 Inspiro Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "M_ProductList.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProductDetailDescriptionCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *lblDescription;

@property (nonatomic, retain) M_ProductList *selectedProduct;

@end

NS_ASSUME_NONNULL_END
