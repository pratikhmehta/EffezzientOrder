//
//  ProductImagesSliderVC.h
//  Meril
//
//  Created by Inspiro Infotech on 30/01/20.
//  Copyright © 2020 Inspiro Infotech. All rights reserved.
//

//#import "BaseVC.h"

#import "M_ProductList.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProductImagesSliderVC : UIViewController

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;

@property (strong, nonatomic) IBOutlet UIView *btnPreviousContainer;
- (IBAction)btnPreviousClicked:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *btnNextContainer;
- (IBAction)btnNextClicked:(id)sender;

@property (nonatomic, retain) NSArray *arrImageURLs;
@property (nonatomic) NSInteger currentIndex;

@property (nonatomic, retain) M_ProductList *selectedProduct;

-(void)scrollToIndex:(NSInteger)index animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
