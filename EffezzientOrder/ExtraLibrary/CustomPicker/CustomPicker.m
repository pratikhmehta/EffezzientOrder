//
//  CustomPicker.m
//  Effezient
//
//  Created by Yahya Bagia on 20/10/18.
//  Copyright © 2018 Inspiro Infotech. All rights reserved.
//

#import "CustomPicker.h"

@interface CustomPicker ()<UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource>

@end

@implementation CustomPicker

- (id)initWithData:(NSMutableArray *)arrValues{
    self = [super init];
    if(self){
        _arrValues = arrValues;
        _arrFilteredValues = _arrValues;
        _arrSelectedValues = [NSMutableArray new];
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    }
    return self;
}

- (void)showWithTitle:(NSString *)title SelectionHandler:(void (^)(NSMutableArray *selectedValues))onSelection{
    _onSelection = onSelection;
    _strTitle = title;
    
    [[[[UIApplication sharedApplication] keyWindow] visibleViewController] presentViewController:self animated:true completion:^{
        if(_searchText.length > 0){
            [_txtSearch setText:_searchText];
            [self searchBar:_txtSearch textDidChange:_searchText];
            [_txtSearch becomeFirstResponder];
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    _lblTitle.text = _strTitle;
    [_tblView registerNib:[UINib nibWithNibName:NSStringFromClass([CustomPickerCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([CustomPickerCell class])];
    
    if(_themeColor == nil){
        _themeColor = THEME_BlueColor;
    }
    _lblTitle.textColor = _themeColor;
    [_btnDone setBackgroundColor:_themeColor];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [UIView animateWithDuration:0.3 animations:^{
        _shadowView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    }];
}

- (IBAction)btnDoneClicked:(id)sender {
    if(_onSelection){
        _onSelection(_arrSelectedValues);
        [self dismsmissPicker:sender];
    }
}

- (IBAction)dismsmissPicker:(id)sender{
    [UIView animateWithDuration:0.3 animations:^{
        _shadowView.backgroundColor = [UIColor clearColor];
    } completion:^(BOOL finished) {
        [self.presentingViewController dismissViewControllerAnimated:true completion:nil];
    }];
}

#pragma mark - UITableView

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CustomPickerCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CustomPickerCell class])];
    M_CustomPicker *model = _arrFilteredValues[indexPath.row];
    [cell setModel:model];
    if([_arrSelectedValues containsObject:model]){
        cell.imgCheck.image = [UIImage imageNamed:@"checked"];
//        if (self.disableSelectedValues) {
//            [cell setUserInteractionEnabled:NO];
//            [cell.contentView setAlpha:0.5];
//        }
//        else {
//            [cell setUserInteractionEnabled:YES];
//            [cell.contentView setAlpha:1.0];
//        }
    }else{
        cell.imgCheck.image = [UIImage imageNamed:@"unchecked"];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    M_CustomPicker *model = _arrFilteredValues[indexPath.row];
    if(_onlySingleSelection){
        
        if(_arrSelectedValues.count > 0){
            if(_arrSelectedValues[0] == model){
                _arrSelectedValues = [NSMutableArray new];
            }else{
                _arrSelectedValues = [NSMutableArray new];
                [_arrSelectedValues addObject:model];
            }
        }else{
            _arrSelectedValues = [NSMutableArray new];
            [_arrSelectedValues addObject:model];
        }
        
    }else{
        if([_arrSelectedValues containsObject:model]){
            [_arrSelectedValues removeObject:model];
        }else{
            [_arrSelectedValues addObject:model];
        }
    }
    [_tblView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arrFilteredValues.count;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

#pragma mark -

#pragma mark - UISearchBar Delegate

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    _arrFilteredValues = [NSMutableArray new];
    for(M_CustomPicker *model in _arrValues){
        if([[model.value lowercaseString] containsString:[searchText lowercaseString]]){
            [_arrFilteredValues addObject:model];
        }
    }
    if([searchText isEqualToString:@""]){
        _arrFilteredValues = [NSMutableArray arrayWithArray:_arrValues];
    }
    [_tblView reloadData];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self.view endEditing:YES];
}

#pragma mark -

@end
