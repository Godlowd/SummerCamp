//
//  FindPageTableViewCell.m
//  Youtube
//
//  Created by New on 2020/7/9.
//  Copyright © 2020 Godlowd. All rights reserved.
//

#import "FindPageTableViewCell.h"
#import <Masonry.h>
@implementation FindPageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setImg:(NSString *)imgName withMainLabel:(NSString *)mainLabel andDetailLabel:(NSString *)detailLabel{
    
    self.img = [UIImage imageNamed:imgName];
    self.img = [self scaleImg:self.img withSize:CGSizeMake(80, 100)];
    self.imgView = UIImageView.new;
    self.imgView.image = self.img;
    self.imgView.layer.cornerRadius = 25;
    self.imgView.layer.masksToBounds = true;
    [self addSubview:self.imgView];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(10);
        make.top.equalTo(self.mas_top).with.offset(10);
        make.bottom.equalTo(self.mas_bottom).with.offset(-10);
    }];
    
    self.mainLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
    self.mainLabel.text = mainLabel;
    [self.mainLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
//    self.mainLabel.font = [UIFont systemFontOfSize:20];
    [self addSubview:self.mainLabel];
    [self.mainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgView).with.offset(10);
        make.left.equalTo(self.imgView.mas_right).with.offset(25);
    }];
    
    self.detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 15)];
    self.detailLabel.text = detailLabel;
    self.detailLabel.textColor = UIColor.grayColor;
    self.detailLabel.font = [UIFont systemFontOfSize:20];
    [self addSubview:self.detailLabel];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mainLabel.mas_bottom).with.offset(15);
        //make.bottom.equalTo(self.mainLabel.mas_bottom).with.offset(-10);
        make.left.equalTo(self.imgView.mas_right).with.offset(25);
    }];
}
//缩放图片
-(UIImage *)scaleImg:(UIImage *)img withSize:(CGSize) wannaSize{
    UIImage *orignialImg = img;
    UIGraphicsBeginImageContextWithOptions(wannaSize, false, 0);
    [orignialImg drawInRect:CGRectMake(0, 0, wannaSize.width, wannaSize.height)];
    UIImage *newImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImg;
}
-(void)setFrame:(CGRect)frame{
    frame.origin.x += 10;
    frame.origin.y += 10;
    frame.size.height -= 20;
    frame.size.width -= 20;
    [super setFrame:frame];

}

//-(void)setSelected:(BOOL)selected{
//    if (selected == YES) {
//        self.backgroundColor = UIColor.yellowColor;
//    }
//}
@end
