//
//  CustomViewController.h
//  Youtube
//
//  Created by New on 2020/7/11.
//  Copyright © 2020 Godlowd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../BeforeClick/CustomSearchBar.h"
NS_ASSUME_NONNULL_BEGIN

@interface CustomViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) CustomSearchBar *bar;
@property(nonatomic, strong) UIView *subBarView;
@property(nonatomic, strong) UIButton *cancel;
@end

NS_ASSUME_NONNULL_END
