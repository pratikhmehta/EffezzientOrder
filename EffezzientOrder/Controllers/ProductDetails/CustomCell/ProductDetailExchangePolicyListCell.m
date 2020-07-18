//
//  ProductDetailExchangePolicyListCell.m
//  Meril
//
//  Created by Inspiro Infotech on 30/01/20.
//  Copyright © 2020 Inspiro Infotech. All rights reserved.
//

#import "ProductDetailExchangePolicyListCell.h"

@implementation ProductDetailExchangePolicyListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setExchangePolicy:(M_ProductExchangePolicy *)exchangePolicy{
    _lblExachangePolicy.text = [NSString stringWithFormat:@"%@ : %@", exchangePolicy.title, exchangePolicy.exchangePolicyDescription];
}

@end
