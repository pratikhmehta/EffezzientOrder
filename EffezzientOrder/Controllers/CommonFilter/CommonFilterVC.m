//
//  CommonFilterVC.m
//  Meril
//
//  Created by Inspiro Infotech on 20/01/20.
//  Copyright © 2020 Inspiro Infotech. All rights reserved.
//

#import "CommonFilterVC.h"

#import "CommonFilterTitleCell.h"
#import "CommonFilterOptionCell.h"
#import "CommonFilterDatePickerCell.h"

#import "M_Filter.h"
#import "M_FilterValues.h"

#import "LSLDatePickerDialog.h"

/*
 TextBox
 Datepicker
 RatingBar
 Numeric TextBox
 TextArea
 */

@interface CommonFilterVC ()<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@property (nonatomic) NSInteger currentPageNumber;
@property (nonatomic) NSInteger totalPage;

@property (nonatomic, retain) NSMutableArray *arrFilter;
@property (nonatomic, retain) NSMutableArray *arrFilterValues;

@property (nonatomic, retain) M_Filter *currentFilter;

@end

@implementation CommonFilterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Filters";
    
    _arrFilter = [NSMutableArray new];
    _arrFilterValues = [NSMutableArray new];;
    
    _currentPageNumber = 1;
    _heightOfSearchBar.constant = 0;
    
    [self getFilter];
}

#pragma mark - ShortHand Methods

-(BOOL)isFilterTypeRadio:(M_Filter *)filter{
    return [filter.selectiontype isEqualToString:@"RadioButton"] || [filter.selectiontype isEqualToString:@"Dropdown"] || [filter.selectiontype isEqualToString:@"SingleSelect"];
}

-(BOOL)isFilterTypeCheckbox:(M_Filter *)filter{
    return [filter.selectiontype isEqualToString:@"CheckBox"] || [filter.selectiontype isEqualToString:@"MultiSelect"];
}

-(BOOL)isFilterTypeDatePicker:(M_Filter *)filter{
    return [filter.selectiontype isEqualToString:@"Datepicker"];
}

-(void)manageSearchBoxVisibility{
    if(_currentFilter.searchboxvisible){
        _heightOfSearchBar.constant = 56;
    }else{
        _heightOfSearchBar.constant = 0;
    }
}

#pragma mark -

#pragma mark - TableView

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == _tblFilterTitle){
        CommonFilterTitleCell *cell = [_tblFilterTitle dequeueReusableCellWithIdentifier:NSStringFromClass([CommonFilterTitleCell class]) forIndexPath:indexPath];
        
        M_Filter *filter = _arrFilter[indexPath.row];
        cell.lblTitle.text = filter.displayname;
        [cell.lblTitle setFont:[UIFont systemFontOfSize:16 weight:UIFontWeightRegular]];
        
        cell.vwIndicator.layer.masksToBounds = YES;
        cell.vwIndicator.layer.cornerRadius = cell.vwIndicator.frame.size.width/2;
//        [cell.vwIndicator setHidden:YES];
        
        [cell.vwIndicator setHidden:filter.selectedvalues.count==0];
//        NSArray *arrBools = [_arrFilterValues valueForKey:@"isSelected"];
//        if(arrBools.count > 0){
//            BOOL containsYes = [arrBools containsObject:@YES];
//            [cell.vwIndicator setHidden:!containsYes];
//        }
        
        [cell setBackgroundColor:[UIColor clearColor]];
        if([filter.filtercolumn isEqualToString: _currentFilter.filtercolumn]){
            [cell setBackgroundColor:[UIColor whiteColor]];
            [cell.lblTitle setFont:[UIFont systemFontOfSize:16 weight:UIFontWeightSemibold]];
        }
        
        return cell;
    }
    else if(tableView == _tblFilterOptions){
        
        if(indexPath.row == _arrFilterValues.count - 1){
            if(_totalPage > _currentPageNumber){
                _currentPageNumber++;
                [self getFilterValues];
            }
        }
        
        M_FilterValues *filterValue = _arrFilterValues[indexPath.row];
        
        if([self isFilterTypeRadio:_currentFilter] || [self isFilterTypeCheckbox:_currentFilter]){
            CommonFilterOptionCell *cell = [_tblFilterOptions dequeueReusableCellWithIdentifier:NSStringFromClass([CommonFilterOptionCell class]) forIndexPath:indexPath];
            cell.lblOption.text = filterValue.name;
            cell.lblTotal.text = [NSString stringWithFormat:@"%ld", (long)filterValue.total];
            
            [cell.lblOption setFont:[UIFont systemFontOfSize:16 weight:UIFontWeightRegular]];
            
            if(filterValue.isselected){
                [cell.lblOption setFont:[UIFont systemFontOfSize:16 weight:UIFontWeightSemibold]];
            }
            
            if([self isFilterTypeRadio:_currentFilter]){
                cell.imgCheckOrRadio.image = [[UIImage imageNamed:@"radio_unchecked"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
                if(filterValue.isselected){
                    cell.imgCheckOrRadio.image = [[UIImage imageNamed:@"radio_checked"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
                }
            }
            else if([self isFilterTypeCheckbox:_currentFilter]){
                cell.imgCheckOrRadio.image = [[UIImage imageNamed:@"unchecked"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
                if(filterValue.isselected){
                    cell.imgCheckOrRadio.image = [[UIImage imageNamed:@"checked"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
                }
            }
            
            return cell;
        }
        else if([self isFilterTypeDatePicker:_currentFilter]){
            CommonFilterDatePickerCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CommonFilterDatePickerCell class]) forIndexPath:indexPath];
            
            cell.lblTitle.text = filterValue.name;
            
            NSDate *dt = [Global getDateFromString:filterValue.value formatter:@"dd-MM-yyyy"];
            [cell setSelectedDate:dt];
            
            return cell;
        }
    }
    return nil;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView == _tblFilterTitle){
        return _arrFilter.count;
    }
    else if(tableView == _tblFilterOptions){
        return _arrFilterValues.count;
    }
    return 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == _tblFilterTitle){
        _currentFilter = _arrFilter[indexPath.row];
        _currentPageNumber = 1;
        _arrFilterValues = [NSMutableArray new];
        [_tblFilterOptions reloadData];
        [self getFilterValues];
        [self manageSearchBoxVisibility];
    }
    else if(tableView == _tblFilterOptions){
        M_FilterValues *currentFilterValue = _arrFilterValues[indexPath.row];
        
        BOOL isAlreadySelected = NO;
        for(M_FilterValues *filterValue in _arrSelectedFilterValues){
            if(
               [currentFilterValue.filtertype isEqualToString:filterValue.filtertype] &&
               [currentFilterValue.name isEqualToString:filterValue.name] &&
               currentFilterValue.idField ==filterValue.idField
               ){
                isAlreadySelected = YES;
                break;
            }
        }
        
        if([self isFilterTypeCheckbox:_currentFilter]){
            if(isAlreadySelected){
                currentFilterValue.isselected = NO;
                NSInteger removeIndex = -1;
                for(M_FilterValues *filterValue in _arrSelectedFilterValues){
                    if([filterValue.filtertype isEqualToString:currentFilterValue.filtertype] &&
                       filterValue.idField == currentFilterValue.idField){
                        removeIndex = [_arrSelectedFilterValues indexOfObject:filterValue];
                    }
                }
                if(removeIndex >= 0){
                    [_arrSelectedFilterValues removeObjectAtIndex:removeIndex];
                }
            }else{
                currentFilterValue.isselected = YES;
                [_arrSelectedFilterValues addObject:currentFilterValue];
            }
            
            [self getFilter];
        }
        else if([self isFilterTypeRadio:_currentFilter]){
            if(isAlreadySelected == NO){
                for(M_FilterValues *filterValue in _arrFilterValues){
                    filterValue.isselected = NO;
                }
                currentFilterValue.isselected = YES;
                
                NSInteger removeIndex = -1;
                for(M_FilterValues *fv in _arrSelectedFilterValues){
                    if([fv.filtertype isEqualToString:currentFilterValue.filtertype]){
                        removeIndex = [_arrSelectedFilterValues indexOfObject:fv];
                    }
                }
                
                if(removeIndex >= 0){
                    [_arrSelectedFilterValues removeObjectAtIndex:removeIndex];
                }
                
                [_arrSelectedFilterValues addObject:currentFilterValue];
            }
            
            [self getFilter];
        }
        else if([self isFilterTypeDatePicker:_currentFilter]){
            NSDate *dt = [Global getDateFromString:currentFilterValue.value formatter:@"dd-MM-yyyy"];
            LSLDatePickerDialog *dpDialog = [[LSLDatePickerDialog alloc] init];
            [dpDialog showWithTitle:currentFilterValue.name doneButtonTitle:@"Done" cancelButtonTitle:@"Cancel"
                        defaultDate:dt ? dt : [NSDate date] minimumDate:nil maximumDate:nil datePickerMode:UIDatePickerModeDate
                           callback:^(NSDate * _Nullable date){
//                               if(date){
                                   currentFilterValue.value = [Global getStringFromDate:date formatter:@"dd-MM-yyyy"];
                                    [self getFilter];
//                               }
                           }
             ];
        }
    }
}

#pragma mark -

#pragma mark - Service Call Handling

-(void)getFilter
{
    if ([Global checkForConnection])
    {
        NSArray *arrSelectedFilterValues = [_arrSelectedFilterValues valueForKey:@"toDictionary"];
        if(arrSelectedFilterValues.count == 0){
            arrSelectedFilterValues = @[];
        }
        NSDictionary *params = @{
                                 @"SubmoduleName": @"All",
                                 @"ModuleName": _moduleName,
                                 @"userid": [ShareInfo sharedManagerInfo].personId,
                                 @"CompanyID": [ShareInfo sharedManagerInfo].companyId,
                                 @"selectedValues":arrSelectedFilterValues
                                 };
        
        [[WebServiceConnector alloc] init:URLGetModuleFilter
                           withParameters:params
                               withObject:self
                             withSelector:@selector(getFilterResponse:)
                           forServiceType:@"JSON"
                           showDisplayMsg:WebServiceDialogMsg];
    }
    else
    {
        [AZNotification showNotificationWithTitle: Msg_Internet_Unavailable controller: self notificationType:AZNotificationTypeError];
    }
}

-(void)getFilterResponse : (id)sender
{
    if ([sender responseCode] != 100)
    {
        [self showAlertWithMessage:[sender responseError]];
    }
    else
    {
        if([[[sender responseDict] valueForKey:kStatusCode] boolValue])
        {
            _arrFilter = [NSMutableArray arrayWithArray:[sender responseArray]];
            
            BOOL currentFilterWasNil = NO;
            
            if(_currentFilter == nil){
                _currentFilter = [_arrFilter firstObject];
                currentFilterWasNil = YES;
            }
            
            _arrSelectedFilterValues = [NSMutableArray new];
            for(M_Filter *filter in _arrFilter){
                if([filter.filtercolumn isEqualToString: _currentFilter.filtercolumn]){
                    _currentFilter = filter;
                }
                [_arrSelectedFilterValues addObjectsFromArray:filter.selectedvalues];
//                filter.selectiontype = @"Datepicker";
            }
            
            for (M_FilterValues *selectedValue in _arrSelectedFilterValues) {
                selectedValue.isselected = YES;
            }
            
            if(currentFilterWasNil){
                [self getFilterValues];
            }
            
            [self manageSearchBoxVisibility];
        }
        else
        {
            NSString *errorMsg = [[[sender responseDict] valueForKey: kErrorData] valueForKey:kErrorMessage];
            [AZNotification showNotificationWithTitle:errorMsg controller: self notificationType:AZNotificationTypeError];
        }
    }
    [_tblFilterTitle reloadData];
    [_tblFilterOptions reloadData];
}

-(void)getFilterValues
{
    if ([Global checkForConnection])
    {
        NSArray *arrSelectedFilterValues = [_arrSelectedFilterValues valueForKey:@"toDictionary"];
        if(arrSelectedFilterValues.count == 0){
            arrSelectedFilterValues = @[];
        }
        NSDictionary *params = @{
                                 @"SubmoduleName": @"All",
                                 @"ModuleName": _moduleName,
                                 @"userid": [ShareInfo sharedManagerInfo].personId,
                                 @"CompanyID": [ShareInfo sharedManagerInfo].companyId,
                                 @"search": _searchBar.text,
                                 @"selectedValues": arrSelectedFilterValues,
                                 @"filtertype": _currentFilter.filtercolumn,
                                 @"pagenumber": @(_currentPageNumber)
                                 };
        
        [[WebServiceConnector alloc] init:URLGetModuleFilterValues
                           withParameters:params
                               withObject:self
                             withSelector:@selector(getFilterValuesResponse:)
                           forServiceType:@"JSON"
                           showDisplayMsg:WebServiceDialogMsg];
    }
    else
    {
        [AZNotification showNotificationWithTitle: Msg_Internet_Unavailable controller: self notificationType:AZNotificationTypeError];
    }
}

-(void)getFilterValuesResponse : (id)sender
{
    if ([sender responseCode] != 100)
    {
        [self showAlertWithMessage:[sender responseError]];
    }
    else
    {
        if([[[sender responseDict] valueForKey:kStatusCode] boolValue])
        {
            _totalPage = [[[sender responseDict] objectForKey:@"pagecount"] integerValue];
            [_arrFilterValues addObjectsFromArray:[sender responseArray]];
        }
        else
        {
            NSString *errorMsg = [[[sender responseDict] valueForKey: kErrorData] valueForKey:kErrorMessage];
            [AZNotification showNotificationWithTitle:errorMsg controller: self notificationType:AZNotificationTypeError];
        }
    }
    [_tblFilterTitle reloadData];
    [_tblFilterOptions reloadData];
}

#pragma mark -

- (IBAction)btnClearClicked:(id)sender {
    _onClear();
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnApplyClicked:(id)sender {
    if(_arrSelectedFilterValues.count > 0){
        _onFilter(_arrSelectedFilterValues);
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [AZNotification showNotificationWithTitle:@"You haven't selected any filter. Select at least 1 to continue." controller: self notificationType:AZNotificationTypeError];
    }
}

#pragma mark - SearchBar Delegate

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    [self reloadFilterValues];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    _searchBar.text = @"";
    [searchBar resignFirstResponder];
    [self reloadFilterValues];
}

-(void)reloadFilterValues{
    _arrFilterValues = [NSMutableArray new];
    _currentPageNumber = 1;
    _totalPage = 0;
    [self getFilterValues];
}

#pragma mark -

@end
