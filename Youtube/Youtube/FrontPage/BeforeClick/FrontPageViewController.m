//
//  FrontPageViewController.m
//  Youtube
//
//  Created by New on 2020/7/6.
//  Copyright © 2020 Godlowd. All rights reserved.
//

#import "FrontPageViewController.h"
#import "CustomSearchBar.h"
#import "../AfterClick/CustomViewController.h"
#import "FindPageTableViewController.h"
#import <Masonry.h>
@implementation FrontPageViewController
NSString static *reusecell = @"reusecell";
-(void)viewDidLoad{
    [super viewDidLoad];
    //设置控件从导航栏下面开始延伸
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    self.navigationController.navigationBar.barTintColor = UIColor.whiteColor;
    self.view.backgroundColor = UIColor.whiteColor;
    [self firstBarInit];
    [self setSubContentView];
}

-(void)setUpFirstBarLocation{
    [_firstSearchbar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(20);
        make.right.equalTo(self.view.mas_right).with.offset(-20);
        make.top.equalTo(self.view.mas_top).with.offset(100);
    }];
}

- (BOOL)searchBarShouldBeginEditing:(CustomSearchBar *)searchBar{
    if (searchBar == _firstSearchbar) {
        [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            NSLog(@"%f",self.subContentView.frame.size.height);
            _subContentView.center = self.view.center;
        } completion:nil];
        
    }
    return NO;
}

-(void)firstBarInit{
    _firstSearchbar = [[CustomSearchBar alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
    [_firstSearchbar setShadow:(CGFloat) 30];
    [_firstSearchbar setSearchFieldBackgroundColor];
    [_firstSearchbar setPlaceholder:@"Location, landmark, or address"];
    [self.view addSubview:_firstSearchbar];
    [self setUpFirstBarLocation];
    self.firstSearchbar.delegate = self;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:reusecell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusecell];
    }
    if (indexPath.row == 0) {
        cell.textLabel.text = @"Nearby";
    }
    else{
       cell.textLabel.text = @"北京";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    FindPageTableViewController *controller = FindPageTableViewController.new;
    [self.navigationController pushViewController:controller animated:YES];
    
}
-(void)setSearchBar{
    _subBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 70)];
    _subBarView.backgroundColor = UIColor.whiteColor;
    _bar = [[CustomSearchBar alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
    [_bar setSearchFieldBackgroundColor];
    [_bar setPlaceholder:@""];
    [_bar setShadow:(CGFloat) 25];
    [_subBarView addSubview:_bar];
    [_bar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.subBarView.mas_left).with.offset(10);
        make.right.equalTo(self.subBarView.mas_right).with.offset(-80);
        make.top.equalTo(self.subBarView.mas_top).with.offset(10);
        make.bottom.equalTo(self.subBarView.mas_bottom).with.offset(-10);
    }];
    [_subContentView addSubview:_subBarView];
    
}


-(void)setcancel:(NSString *)word{
    _cancel =[[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 30)];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:word];
    NSRange strRange = {0,[str length]};
    [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
    [_cancel setAttributedTitle:str forState:UIControlStateNormal];//这个状态要加上
    [_subContentView addSubview:_cancel];
    [_cancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_bar.mas_right).with.offset(10);
        make.right.equalTo(_subBarView.mas_right).with.offset(-10);
        make.top.equalTo(_subBarView.mas_top).with.offset(10);
        make.bottom.equalTo(_subBarView.mas_bottom).with.offset(-10);
    }];
}

-(void)setSubContentView{
    _subContentView = [[UIView alloc] initWithFrame:CGRectMake(0,UIScreen.mainScreen.bounds.size.height+1 , UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height)];
    [self.view addSubview:_subContentView];
    //注册cell
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:reusecell];
    self.tableView = [[UITableView alloc] initWithFrame:UIScreen.mainScreen.bounds];
       //设置代理和dataSource
       self.tableView.dataSource = self;
       self.tableView.delegate = self;
       //添加子视图
       [_subContentView addSubview:self.tableView];
       [self setSearchBar];
       //设置tableview的内容偏移
       [self.tableView setContentInset:UIEdgeInsetsMake(_subBarView.bounds.size.height, 0, 0, 0)];
       [_tableView setScrollIndicatorInsets:UIEdgeInsetsMake(_subBarView.bounds.size.height, 0, 0, 0)];
       _tableView.tableFooterView = UIView.new;
       [self setcancel:@"Cancel"];
       [_cancel addTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
}
@end
