//
//  DatecellCollectionViewCell.h
//  Youtube
//
//  Created by New on 2020/7/6.
//  Copyright © 2020 Godlowd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DatecellCollectionViewCell : UICollectionViewCell
@property(nonatomic, strong) UILabel *title;
@property(nonatomic, strong) NSIndexPath *indexpath;
@property(nonatomic, strong) UIView *ingapview;
@property(nonatomic) Boolean inGap;
-(void)setUpPath : (NSIndexPath *)indexpath;
-(void)setUpLabelWithDate:(int) num;
-(void)setInView;
@end

NS_ASSUME_NONNULL_END
