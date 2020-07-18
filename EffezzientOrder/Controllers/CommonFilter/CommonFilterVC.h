//
//  CommonFilterVC.h
//  Meril
//
//  Created by Inspiro Infotech on 20/01/20.
//  Copyright © 2020 Inspiro Infotech. All rights reserved.
//

#import "BaseVC.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^OnFilter)(NSMutableArray *selectedModuleFilters);
typedef void (^OnClear)(void);

@interface CommonFilterVC : BaseVC

@property (strong, nonatomic) IBOutlet UITableView *tblFilterTitle;
@property (strong, nonatomic) IBOutlet UITableView *tblFilterOptions;

- (IBAction)btnClearClicked:(id)sender;
- (IBAction)btnApplyClicked:(id)sender;

@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightOfSearchBar;

@property (nonatomic, retain) NSString *moduleName;

@property (copy, nonatomic) OnFilter onFilter;
@property (copy, nonatomic) OnClear onClear;

@property (nonatomic, retain) NSMutableArray *arrSelectedFilterValues;

@end

NS_ASSUME_NONNULL_END
