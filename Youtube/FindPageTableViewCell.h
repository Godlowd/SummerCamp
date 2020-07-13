//
//  FindPageTableViewCell.h
//  Youtube
//
//  Created by New on 2020/7/9.
//  Copyright © 2020 Godlowd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FindPageTableViewCell : UITableViewCell
@property(nonatomic, strong) UIImage *img;
@property(nonatomic, strong) UIImageView *imgView;
@property(nonatomic, strong) UILabel *mainLabel;
@property(nonatomic, strong) UILabel *detailLabel;
@property(nonatomic, strong) UIView *content;


-(void)setImg:(NSString *)imgName withMainLabel:(NSString *)mainLabel andDetailLabel:(NSString *)detailLabel;
@end

NS_ASSUME_NONNULL_END
