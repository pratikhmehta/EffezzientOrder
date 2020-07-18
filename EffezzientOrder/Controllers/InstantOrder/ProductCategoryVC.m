//
//  ProductCategoryVC.m
//  Meril
//
//  Created by Inspiro Infotech on 26/06/20.
//  Copyright © 2020 Inspiro Infotech. All rights reserved.
//

#import "ProductCategoryVC.h"
#import "InstantOrderEntryVC.h"

#import "M_ProductCategory.h"
#import "M_FilterValues.h"

@interface ProductCategoryVC ()
{
    NSMutableArray *arrCategories;
}
@end

@implementation ProductCategoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Categories";
    
    arrCategories = [NSMutableArray new];
    [self getCategories];
}

-(void)getCategories {
    if([Global checkForConnection])
    {
        [[WebServiceConnector alloc]init: URLGetProductCategory
                          withParameters: @{
                                            kCompanyID : [ShareInfo sharedManagerInfo].companyId,
                                            kUserID : [ShareInfo sharedManagerInfo].personId,
                                            }
                              withObject:self
                            withSelector:@selector(getCategoriesResponse:)
                          forServiceType:@"JSON"
                          showDisplayMsg:WebServiceDialogMsg];
    }
    else
    {
        [AZNotification showNotificationWithTitle: Msg_Internet_Unavailable controller: self notificationType:AZNotificationTypeError];
    }
}

-(void)getCategoriesResponse:(id)sender {
    //NSLog(@"\n====================================================\n");
    NSLog(@"getCategoriesResponse: %@", [sender responseDict]);
    
    if ([sender responseCode] != 100)
    {
        [self showAlertWithMessage:[sender responseError]];
    }
    else
    {
        if([[[sender responseDict] valueForKey:kStatusCode] boolValue])
        {
            arrCategories = [[NSMutableArray alloc] initWithArray:[sender responseArray]];
        }
        else
        {
            NSString *errorMsg = [[[sender responseDict] valueForKey:kErrorData] valueForKey:kErrorMessage];
            [AZNotification showNotificationWithTitle:errorMsg controller:self notificationType:AZNotificationTypeError];
        }
    }
    
    [_tblCategories reloadData];
}


#pragma mark - Table View Delegates & Data Source -

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrCategories count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"idCategoryCell"];
    
    M_ProductCategory *category = [arrCategories objectAtIndex:indexPath.row];
    cell.lblTitle.text = category.categoryname;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    M_ProductCategory *category = [arrCategories objectAtIndex:indexPath.row];
    M_FilterValues *currentFilterValue = [[M_FilterValues alloc] init];
    currentFilterValue.filtertype = @"category";
    currentFilterValue.name = category.categoryname;
    currentFilterValue.idField = [category.categoryid integerValue];
    NSMutableArray *arrTemp = [[NSMutableArray alloc] initWithObjects:currentFilterValue, nil];
    
    InstantOrderEntryVC *vc = loadViewController(SB_Order, VC_InstantOrderEntry);
    vc.categoryID = category.categoryid;
    vc.arrSelectedFilter = arrTemp;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
