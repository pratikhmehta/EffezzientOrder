//
//  LandingListCell.h
//  Meril
//
//  Created by Inspiro Infotech on 10/01/20.
//  Copyright © 2020 Inspiro Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "M_LandingSection.h"
#import "M_LandingItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface LandingListCell : UITableViewCell<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, retain) M_LandingSection *landingSection;

@end

NS_ASSUME_NONNULL_END
