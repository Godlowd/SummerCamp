//
//  GuestTableViewCell.h
//  Youtube
//
//  Created by New on 2020/7/9.
//  Copyright © 2020 Godlowd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GuestTableViewCell : UITableViewCell
@property(nonatomic, strong) UILabel *people;
@property(nonatomic, strong) UILabel *des;
@property(nonatomic, strong) UILabel *num;
@property(nonatomic, strong) UIButton *add;
@property(nonatomic, strong) UIButton *minus;
-(void)setPeo:(NSString *)people andDes:(NSString *)des;
@end

NS_ASSUME_NONNULL_END
