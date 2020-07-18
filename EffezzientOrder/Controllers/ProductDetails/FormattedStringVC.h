//
//  FormattedStringVC.h
//  Meril
//
//  Created by Inspiro Infotech on 01/02/20.
//  Copyright © 2020 Inspiro Infotech. All rights reserved.
//

#import "BaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface FormattedStringVC : BaseVC

@property (strong, nonatomic) IBOutlet UITextView *txtView;

@property (nonatomic, retain) NSString *strTitle;
@property (nonatomic, retain) NSAttributedString *strAttributed;

@end

NS_ASSUME_NONNULL_END
