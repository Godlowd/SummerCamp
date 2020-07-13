//
//  FrontPageViewController.h
//  Youtube
//
//  Created by New on 2020/7/6.
//  Copyright © 2020 Godlowd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomSearchBar.h"
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface FrontPageViewController : UIViewController<UISearchBarDelegate,UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong) CustomSearchBar *firstSearchbar;
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) CustomSearchBar *bar;
@property(nonatomic, strong) UIView *subBarView;
@property(nonatomic, strong) UIButton *cancel;

@property(nonatomic, strong) UIView *subContentView;
@end

NS_ASSUME_NONNULL_END
