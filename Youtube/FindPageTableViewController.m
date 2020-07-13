//
//  FindPageTableViewController.m
//  Youtube
//
//  Created by New on 2020/7/9.
//  Copyright © 2020 Godlowd. All rights reserved.
//

#import "FindPageTableViewController.h"
#import "FindPageTableViewCell.h"
#import "DateCollectionViewController.h"
#import "FindPageHeaderView.h"
#import <Masonry.h>
@interface FindPageTableViewController ()

@end

@implementation FindPageTableViewController

NSString static *cellReuseIdentifier = @"tableviewcell";
NSString static *headerReuseIdentifier = @"tableviewheader";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.mainQuestionArray = @[@"Find a place to stay", @"Find a month stay", @"Find an experience"];
    self.subQuestionArray = @[@"Entire homes, room & more", @"Stays for 4+ weeks", @"Activities hosted by locals"];
    //注册cell的class
    [self.tableView registerClass:FindPageTableViewCell.class forCellReuseIdentifier:cellReuseIdentifier];
    //注册header的class
    [self.tableView registerClass:FindPageHeaderView.class forHeaderFooterViewReuseIdentifier:headerReuseIdentifier];
    //取消cell之间的分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - Table view data source

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FindPageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier forIndexPath:indexPath];
    [cell setImg:@"1.png" withMainLabel:self.mainQuestionArray[indexPath.row] andDetailLabel:self
     .subQuestionArray[indexPath.row]];
    
//    遮罩
    CAShapeLayer *mask = [CAShapeLayer layer];
    mask.frame = CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width-20, 102);
    UIBezierPath *maskbezierPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width-20, 102)cornerRadius:20];
    mask.path = maskbezierPath.CGPath;
    [cell.layer setMask:mask];
    //设置圆角与阴影
    cell.layer.borderColor = [UIColor.grayColor CGColor];
    cell.layer.cornerRadius = 25;
    cell.layer.borderWidth = 1.0;
    cell.clipsToBounds = NO;
    cell.layer.shadowOpacity = 1;
    cell.layer.shadowColor = [UIColor.lightGrayColor CGColor];
    cell.layer.shadowOffset = CGSizeMake(0, 2);
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewFlowLayout *layout = UICollectionViewFlowLayout.new;
    //设置section内的cell的间距
    layout.minimumInteritemSpacing = 0;
    //设置section内部的行间距
    layout.minimumLineSpacing = 5;
    //设置section之间的距离
    layout.sectionInset = UIEdgeInsetsMake(0, 30, 0, 30);
    //设置header的size
    layout.headerReferenceSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 80);
    DateCollectionViewController *controller = DateCollectionViewController.new;
    [self.navigationController pushViewController:controller animated:true];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    FindPageHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerReuseIdentifier];
    header.frame = CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 200);
    header.question = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 100)];
    header.question.text = @"What can we help you find?";
    header.question.font = [UIFont fontWithName:@"Helvetica-Bold" size:25];
    [header addSubview:header.question];
    [header.question mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(header.contentView.mas_top).with.offset(20);
        make.bottom.equalTo(header.contentView).with.offset(-20);
        make.left.equalTo(header.contentView).with.offset(20);
    }];
    header.contentView.backgroundColor = UIColor.whiteColor;
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 90;
}

@end
