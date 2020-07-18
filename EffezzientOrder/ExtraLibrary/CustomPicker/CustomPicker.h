//
//  CustomPicker.h
//  Effezient
//
//  Created by Yahya Bagia on 20/10/18.
//  Copyright © 2018 Inspiro Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "M_CustomPicker.h"
#import "CustomPickerCell.h"
#import "UIWindow+Extensions.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^OnSelection)(NSMutableArray *selectedValues);

@interface CustomPicker : UIViewController

@property (weak, nonatomic) IBOutlet UIView *shadowView;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UISearchBar *txtSearch;
@property (weak, nonatomic) IBOutlet UITableView *tblView;
@property (weak, nonatomic) IBOutlet UIButton *btnDone;

@property (nonatomic) BOOL disableSelectedValues;

- (IBAction)btnDoneClicked:(id)sender;
- (IBAction)dismsmissPicker:(id)sender;

@property (nonatomic, retain) NSMutableArray *arrValues;
@property (nonatomic, retain) NSMutableArray *arrFilteredValues;
@property (nonatomic, retain) NSMutableArray *arrSelectedValues;
@property (copy, nonatomic) OnSelection onSelection;
@property (nonatomic, retain) NSString *strTitle;
@property (nonatomic, retain) UIColor *themeColor;

- (id)initWithData:(NSMutableArray *)arrValues;
- (void)showWithTitle:(NSString *)title SelectionHandler:(void (^)(NSMutableArray *selectedValues))onSelection;
@property (nonatomic) BOOL onlySingleSelection;

@property (nonatomic, retain) NSString *searchText;

@end

NS_ASSUME_NONNULL_END
