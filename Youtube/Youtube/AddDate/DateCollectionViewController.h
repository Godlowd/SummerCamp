//
//  DateCollectionViewController.h
//  Youtube
//
//  Created by New on 2020/7/6.
//  Copyright © 2020 Godlowd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DateBottomView.h"
NS_ASSUME_NONNULL_BEGIN

@interface DateCollectionViewController : UIViewController<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
//用来存储已经选择的cell的数组
@property(nonatomic, strong) NSMutableArray *selectPathArray;
//用来存放两个已选择cell中间的数组
@property(nonatomic, strong) NSMutableArray *inGapArray;
//子视图中的UICollectionView
@property(nonatomic, strong) UICollectionView *subCollectionView;
//母视图
@property(nonatomic, strong) UIView *parentView;
//
@property(nonatomic, strong) DateBottomView *bottomView;
@property(nonatomic, strong) NSMutableArray *forbiddenselectPathArray;
//导航栏右上方clear按钮
@property(nonatomic, strong) UIBarButtonItem *clear;

-(NSInteger)getCurrentYearOrMonthOrDay:(NSString *) param;
@end

NS_ASSUME_NONNULL_END
