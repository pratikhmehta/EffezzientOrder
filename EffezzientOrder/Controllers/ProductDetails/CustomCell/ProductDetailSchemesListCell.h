//
//  ProductDetailSchemesListCell.h
//  Meril
//
//  Created by Inspiro Infotech on 30/01/20.
//  Copyright © 2020 Inspiro Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "M_ProductScheme.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProductDetailSchemesListCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *lblScheme;

@property (nonatomic, retain) M_ProductScheme *scheme;

@end

NS_ASSUME_NONNULL_END
