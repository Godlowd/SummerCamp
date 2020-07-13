//
//  GuestTableViewCell.m
//  Youtube
//
//  Created by New on 2020/7/9.
//  Copyright © 2020 Godlowd. All rights reserved.
//

#import "GuestTableViewCell.h"
#import <Masonry.h>
@implementation GuestTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
    // Configure the view for the selected state
}

-(void)setPeo:(NSString *)people andDes:(NSString *)des{
    self.people = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 20)];
    self.people.text = people;
    self.people.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    [self addSubview:self.people];
    [self.people mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(25);
        make.top.equalTo(self.mas_top).with.offset(15);
        make.right.equalTo(self.mas_right).with.offset(-25);
    }];
    
    self.des = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 20)];
    self.des.text = des;
    self.des.textColor = UIColor.grayColor;
    self.des.font = [UIFont systemFontOfSize:16];
    [self addSubview:self.des];
    [self.des mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(25);
        make.bottom.equalTo(self.mas_bottom).with.offset(-15);
        make.top.equalTo(self.people.mas_bottom).with.offset(10);
        make.right.equalTo(self.mas_right).with.offset(-25);
    }];
    
    self.add = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.add setTitle:@"＋" forState:UIControlStateNormal];
    self.add.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.add.titleLabel.font = [UIFont systemFontOfSize:25];
    [self.add setTitleColor:UIColor.grayColor forState:UIControlStateNormal];
    self.add.frame = CGRectMake(UIScreen.mainScreen.bounds.size.width-60, 0, 40, 40);
    self.add.layer.masksToBounds = YES;
    self.add.layer.cornerRadius = 20;
    self.add.layer.borderWidth = 1;
    self.add.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    CGPoint newcenter = CGPointMake(UIScreen.mainScreen.bounds.size.width-40, 40);
    self.add.center = newcenter;
    [self.add addTarget:self action:@selector(btnAdd) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.add];
    
    self.num = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    self.num.text = @"0";
    self.num.font = [UIFont systemFontOfSize:20];
    [self addSubview:self.num];
    [self.num mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.add.mas_left).with.offset(-20);
        make.top.equalTo(self.mas_top).with.offset(20);
        make.bottom.equalTo(self.mas_bottom).with.offset(-20);
    }];
    
    self.minus = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.minus setTitle:@"－" forState:UIControlStateNormal];
    self.minus.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.minus.titleLabel.font = [UIFont systemFontOfSize:25];
    [self.minus setTitleColor:UIColor.lightGrayColor forState:UIControlStateNormal];
    self.minus.frame = CGRectMake(UIScreen.mainScreen.bounds.size.width-140, 0, 40, 40);
    self.minus.layer.masksToBounds = YES;
    self.minus.layer.cornerRadius = 20;
    self.minus.layer.borderWidth = 1;
    self.minus.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    newcenter = CGPointMake(UIScreen.mainScreen.bounds.size.width-130, 40);
    self.minus.center = newcenter;
    [self.minus addTarget:self action:@selector(btnMinus) forControlEvents:UIControlEventTouchUpInside];
    self.minus.userInteractionEnabled = false;
    self.minus.alpha = 0.2;
    [self addSubview:self.minus];
//    [self.minus mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.num.mas_left).with.offset(-20);
//    }];

}


-(void)btnAdd{
    int number = [self.num.text intValue];
    (int)number++;
    self.num.text = [NSString stringWithFormat: @"%d", number];
    if(self.num.text > 0)
    {
        self.minus.userInteractionEnabled = true;
        self.minus.alpha = 1;
    }
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.add.transform = CGAffineTransformMakeScale(0.8, 0.8);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            self.add.transform = CGAffineTransformIdentity;
        }];
    }];
    
//    if ([self.num.text intValue] <= 0) {
//        self.minus.userInteractionEnabled = false;
//        self.minus.alpha = 0.1;
//    }
//    else{

//    }
}
-(void)btnMinus{
    int number = [self.num.text intValue];
    number --;
    self.num.text = [NSString stringWithFormat: @"%d", number];
    if ([self.num.text intValue] <= 0) {
        self.minus.userInteractionEnabled = false;
        self.minus.alpha = 0.2;
    }
    else{
        self.minus.userInteractionEnabled = true;
        self.minus.alpha = 1;
    }
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.minus.transform = CGAffineTransformMakeScale(0.8, 0.8);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            self.minus.transform = CGAffineTransformIdentity;
        }];
    }];
}
@end
