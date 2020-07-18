//
//  FormattedStringVC.m
//  Meril
//
//  Created by Inspiro Infotech on 01/02/20.
//  Copyright © 2020 Inspiro Infotech. All rights reserved.
//

#import "FormattedStringVC.h"

@interface FormattedStringVC ()

@end

@implementation FormattedStringVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = _strTitle;
    [_txtView setAttributedText:_strAttributed];
    
}

@end
