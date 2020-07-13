//
//  DateHeaderCollectionReusableView.m
//  Youtube
//
//  Created by New on 2020/7/6.
//  Copyright © 2020 Godlowd. All rights reserved.
//

#import "DateHeaderCollectionReusableView.h"
#import <Masonry.h>
@implementation DateHeaderCollectionReusableView
-(void)setMonth : (NSString *) month{
    _month = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
    _month.text = month;
    _month.font = [UIFont systemFontOfSize:25];
    [self addSubview:_month];
    
    [self.month mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.mas_left).offset(30);
    }];
    
    self.backgroundColor = UIColor.whiteColor;
}
@end
