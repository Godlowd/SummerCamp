//
//  DatecellCollectionViewCell.m
//  Youtube
//
//  Created by New on 2020/7/6.
//  Copyright © 2020 Godlowd. All rights reserved.
//

#import "DatecellCollectionViewCell.h"
#import <Masonry.h>
@implementation DatecellCollectionViewCell
-(void)setUpLabelWithDate:(int)num{
    _title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    _title.text = [@(num) stringValue];
    _title.font = [UIFont systemFontOfSize:15];
    [self addSubview:_title];
    //_title.center = self.center;
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
    }];
}
-(void)setUpPath:(NSIndexPath *)indexpath{
    self.indexpath = indexpath;
}
-(void)setInView{
    self.title.textColor = UIColor.blackColor;
    self.backgroundColor = UIColor.grayColor;
}
-(void)setSelected:(BOOL)selected{
    if (selected == true) {
        self.backgroundColor = UIColor.blackColor;
        self.title.textColor = UIColor.whiteColor;
        int cellWidth, cellHeight;
        cellWidth = cellHeight = 50;
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.frame = CGRectMake(0, 0, cellWidth, cellHeight);
        UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, cellWidth, cellHeight) cornerRadius:40];//对方法对最后一个参数cornerRadius还是不甚了解。不知道单位是什么，弧度制还是角度制抑或是其他？
        maskLayer.path = bezierPath.CGPath;
        [self.layer setMask:maskLayer];
    }
    else if(self.inGap == true){
        [self setInView];
    }
    else {
        [self.layer setMask:nil];
        self.title.textColor = UIColor.blackColor;
        self.backgroundColor = UIColor.whiteColor;
    }
}

@end
