//
//  CustomSearchBar.h
//  Youtube
//
//  Created by New on 2020/7/11.
//  Copyright © 2020 Godlowd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomSearchBar : UISearchBar
@property(nonatomic, strong) UILabel *holder;

-(void)setPlaceholder:(NSString *)holder;
-(void)setShadow:(CGFloat) radius;
-(void)setSearchFieldBackgroundColor;

-(void)setBorderColor:(UIColor *)color;
@end

NS_ASSUME_NONNULL_END
