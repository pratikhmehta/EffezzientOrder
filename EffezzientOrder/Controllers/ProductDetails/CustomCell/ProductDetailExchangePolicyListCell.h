//
//  ProductDetailExchangePolicyListCell.h
//  Meril
//
//  Created by Inspiro Infotech on 30/01/20.
//  Copyright © 2020 Inspiro Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "M_ProductExchangePolicy.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProductDetailExchangePolicyListCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *lblExachangePolicy;

@property (nonatomic, retain) M_ProductExchangePolicy *exchangePolicy;

@end

NS_ASSUME_NONNULL_END
