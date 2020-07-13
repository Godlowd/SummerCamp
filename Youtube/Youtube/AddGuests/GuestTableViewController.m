//
//  GuestTableViewController.m
//  Youtube
//
//  Created by New on 2020/7/9.
//  Copyright © 2020 Godlowd. All rights reserved.
//

#import "GuestTableViewController.h"
#import "GuestTableViewCell.h"
#import "GuestHeaderView.h"
#import "GuestFooterView.h"
#import <Masonry.h>
@interface GuestTableViewController ()

@end

@implementation GuestTableViewController
NSString static *cellReuseIdetifier = @"tableviewcell";
NSString static *headerReuseIdetifier = @"tableviewheader";
NSString static *footerReuseIdetifier = @"tableviewfooter";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpToolBarButton];
    //设置背景为白色
    [self.navigationController.toolbar setBarTintColor:UIColor.whiteColor];
    //注册cell
    [self.tableView registerClass:GuestTableViewCell.class forCellReuseIdentifier:cellReuseIdetifier];
    //注册header
    [self.tableView registerClass:GuestHeaderView.class forHeaderFooterViewReuseIdentifier:headerReuseIdetifier];
    self.tableView.tableFooterView = UIView.new;
    self.people =@[@"Adults", @"Children", @"Infants"];
    self.des = @[@"Ages 13 or above", @"Ages 2-12", @"Under 2"];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)setUpToolBarButton{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 200)];
    view.backgroundColor = UIColor.yellowColor;
    [self.tableView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top).with.offset(100);
    }];

}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 90;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GuestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseIdetifier];
    [cell setPeo:self.people[indexPath.row] andDes:self.des[indexPath.row]];

    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    GuestHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerReuseIdetifier];
    header.frame = CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 200);
    header.title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 100)];
    header.title.text = @"Add guests";
    header.title.font = [UIFont fontWithName:@"Helvetica-Bold" size:25];
    [header addSubview:header.title];
    [header.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(header.contentView.mas_top).with.offset(20);
        make.bottom.equalTo(header.contentView).with.offset(-20);
        make.left.equalTo(header.contentView).with.offset(25);
    }];
    header.contentView.backgroundColor = UIColor.whiteColor;
    return header;
}

@end
