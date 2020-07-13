//
//  DateBottomView.m
//  Youtube
//
//  Created by New on 2020/7/11.
//  Copyright © 2020 Godlowd. All rights reserved.
//

#import "DateBottomView.h"
#import <Masonry.h>
@implementation DateBottomView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createNext];
        [self createSkip];
    }
    return self;
}
-(void)createNext{
    _next = [UIButton buttonWithType:UIButtonTypeCustom];
    [_next setTitle:@"Next" forState:UIControlStateNormal];
    [_next setTintColor:UIColor.whiteColor];
    [_next setBackgroundColor:UIColor.blackColor];
    _next.frame = CGRectMake(0, 0, 50, 30);
    _next.layer.cornerRadius = 10;
    [self addSubview:_next];
    [_next mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-20);
        make.top.equalTo(self.mas_top).with.offset(20);
        make.bottom.equalTo(self.mas_bottom).with.offset(-30);
        make.left.equalTo(self.mas_left).with.offset(300);
    }];
}

-(void)createSkip{
    _skip = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    _skip.text = @"Skip";
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc] initWithString:@"Skip"];
    NSRange contentRange = {0, [content length]};
    [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
    _skip.attributedText = content;
    _skip.font = [UIFont systemFontOfSize:20];
    _skip.textColor = UIColor.grayColor;
    [self addSubview:_skip];
    [_skip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(30);
        make.top.equalTo(self.mas_top).with.offset(5);
        make.bottom.equalTo(self.mas_bottom).with.offset(-20);
    }];
}
@end
