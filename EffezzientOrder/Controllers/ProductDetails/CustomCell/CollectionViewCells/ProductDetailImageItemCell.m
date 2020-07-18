//
//  ProductDetailImageItemCell.m
//  Meril
//
//  Created by Inspiro Infotech on 24/01/20.
//  Copyright © 2020 Inspiro Infotech. All rights reserved.
//

#import "ProductDetailImageItemCell.h"

#define MAXIMUM_SCALE   3.0
#define MINIMUM_SCALE   1.0

@implementation ProductDetailImageItemCell

- (void)setup {
    
    _scrollView.maximumZoomScale = MAXIMUM_SCALE;
    _scrollView.minimumZoomScale = MINIMUM_SCALE;
    _scrollView.clipsToBounds = NO;
    
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(zoomImage:)];
    self.itemImage.gestureRecognizers = @[pinch];
    self.itemImage.userInteractionEnabled = YES;
    self.scrollView.delegate = self;
    
}

#pragma  mark  - Scrollview Delegate Method

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.itemImage;
}

#pragma mark - Custom Methods

- (void)zoomImage:(UIPinchGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateEnded || gesture.state == UIGestureRecognizerStateChanged) {
        NSLog(@"gesture.scale = %f", gesture.scale);
        
        CGFloat currentScale = self.frame.size.width / self.bounds.size.width;
        CGFloat newScale = currentScale * gesture.scale;
        
        if (newScale < MINIMUM_SCALE) {
            newScale = MINIMUM_SCALE;
        }
        if (newScale > MAXIMUM_SCALE) {
            newScale = MAXIMUM_SCALE;
        }
        
        CGAffineTransform transform = CGAffineTransformMakeScale(newScale, newScale);
        self.itemImage.transform = transform;
        self.scrollView.contentSize = self.itemImage.frame.size;
        
    }
    
}

@end
