//
//  CustomSearchBar.m
//  Youtube
//
//  Created by New on 2020/7/11.
//  Copyright © 2020 Godlowd. All rights reserved.
//

#import "CustomSearchBar.h"
#import <Masonry.h>
@implementation CustomSearchBar
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame: frame];
    self.barStyle = UIBarStyleDefault;
    self.backgroundColor = UIColor.whiteColor;
    self.barTintColor = [UIColor whiteColor];
    self.layer.masksToBounds = YES;
    //设置背景图是为了去掉上下黑线
    self.backgroundImage = [[UIImage alloc] init];
    return self;
}

-(void)setSearchFieldBackgroundColor{
    UITextField *searchField = [self valueForKey:@"searchField"];
    if (searchField) {
        [searchField setBackgroundColor:[UIColor whiteColor]];
    }
}

-(void)setPlaceholder:(NSString *)holder{
    _holder = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 10)];
    _holder.text = holder;
    _holder.textColor = UIColor.grayColor;
    _holder.font = [UIFont systemFontOfSize:16];
    [self addSubview:_holder];
    [_holder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
    }];
}
-(void)setShadow:(CGFloat) radius{
    self.layer.borderColor = [UIColor.grayColor CGColor];
    self.layer.cornerRadius = radius;
    self.layer.borderWidth = 1.0;
    self.clipsToBounds = NO;
    self.layer.shadowOpacity = 1;
    self.layer.shadowColor = [UIColor.lightGrayColor CGColor];
    self.layer.shadowOffset = CGSizeMake(0, 2);
}

-(void)setBorderColor:(UIColor *)color{
    self.layer.borderColor = color.CGColor;
}

@end
