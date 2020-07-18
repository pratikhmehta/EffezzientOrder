//
//  LandingScreenVC.m
//  Meril
//
//  Created by Inspiro Infotech on 10/01/20.
//  Copyright © 2020 Inspiro Infotech. All rights reserved.
//

#import "LandingScreenVC.h"

#import "LandingListCell.h"

#import "M_LandingSection.h"

@interface LandingScreenVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) NSArray *arrData;

@end

@implementation LandingScreenVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Landing" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    _arrData = dic[@"data"];
    
    WebServiceDataAdaptor *adaptor = [[WebServiceDataAdaptor alloc] init];
    _arrData = [adaptor processJSONData:dic
                          forClass:LandingSectionClass
                         forEntity:nil
                       withJSONKey:kSuccessData];
    
}

#pragma mark - TableView

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LandingListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LandingListCell class]) forIndexPath:indexPath];
    M_LandingSection *landingSection = _arrData[indexPath.section];
    [cell setLandingSection:landingSection];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    M_LandingSection *landingSection = _arrData[indexPath.section];
    return landingSection.sectionHeight;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _arrData.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    M_LandingSection *landingSection = _arrData[section];
    CGFloat topMargin = landingSection.sectionMarginTop;
    if(topMargin == 0){
        topMargin = 0.02;
    }
    return topMargin;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    M_LandingSection *landingSection = _arrData[section];
    CGFloat bottomMargin = landingSection.sectionMarginBottom;
    if(bottomMargin == 0){
        bottomMargin = 0.02;
    }
    return bottomMargin;
}

#pragma mark -

@end
