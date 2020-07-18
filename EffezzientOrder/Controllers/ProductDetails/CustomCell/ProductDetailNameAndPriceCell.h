//
//  ProductDetailNameAndPriceCell.h
//  Meril
//
//  Created by Inspiro Infotech on 24/01/20.
//  Copyright © 2020 Inspiro Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "M_ProductList.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProductDetailNameAndPriceCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *lblBrandProductCategory;

@property (strong, nonatomic) IBOutlet UILabel *lblMRP;

@property (strong, nonatomic) IBOutlet UILabel *lblFullPrice;
@property (strong, nonatomic) IBOutlet UILabel *lblFullDiscount;

@property (strong, nonatomic) IBOutlet UILabel *lblSinglePrice;
@property (strong, nonatomic) IBOutlet UILabel *lblSingleDiscount;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightOfSinglePriceDetailsContainer;

@property (nonatomic, retain) M_ProductList *selectedProduct;

@end

NS_ASSUME_NONNULL_END
