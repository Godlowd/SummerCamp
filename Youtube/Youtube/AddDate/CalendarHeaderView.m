//
//  CalendarHeaderView.m
//  Youtube
//
//  Created by New on 2020/7/6.
//  Copyright © 2020 Godlowd. All rights reserved.
//

#import "CalendarHeaderView.h"
#define LABWIDTH self.frame.size.width / 7
@implementation CalendarHeaderView
-(void)ceartHeaderView
{
    _weekarray = [NSArray arrayWithObjects:@"S",@"M",@"T",@"W",@"T",@"F",@"S", nil];
    NSLog(@"%@",_weekarray);
    for (int index = 0; index < 7; index++) {
        UILabel * Lab = [[UILabel alloc]initWithFrame:CGRectMake(index * LABWIDTH, 0, LABWIDTH, self.frame.size.height)];
        Lab.backgroundColor =  [[UIColor lightGrayColor]colorWithAlphaComponent:0.2];
        Lab.text = _weekarray[index];
        Lab.textAlignment = NSTextAlignmentCenter;
        Lab.textColor = [UIColor darkGrayColor];
//        if (index == 0 || index == 6) {
//            Lab.textColor = [UIColor colorWithRed:246/255.0 green:90/255.0 blue:5/255.0 alpha:1 ];
//        }
        [self addSubview:Lab];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
