//
//  ZJBadgeButton.m
//  ZJCommonProject
//
//  Created by jyd on 16/1/27.
//  Copyright © 2016年 jyd. All rights reserved.
//

#import "ZJBadgeButton.h"

@implementation ZJBadgeButton

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        [self setBackgroundImage:[UIImage imageNamed:@"news"] forState:UIControlStateNormal];
        self.hidden = YES;
        self.userInteractionEnabled = NO;
        self.titleLabel.font = [UIFont systemFontOfSize:12];
    }
    
    return self;
}

-(void)setBadgeValue:(NSString *)badgeValue
{
#warning copy
    _badgeValue = [badgeValue copy];
    
    if (self.badgeValue)
    {
        self.hidden = NO;
        [self setTitle:badgeValue forState:UIControlStateNormal];
        //设置frame
        CGRect frame = self.frame;
        CGFloat badgeW = self.currentBackgroundImage.size.width;
        CGFloat badgeH = self.currentBackgroundImage.size.height;
        
        //如果按钮的长度大于1，则按照字符的长度计算按钮的宽度
        if (self.badgeValue.length > 1)
        {
            //计算文字大小，参数一定要符合相应的字体和大小
            CGSize badgeSize = [self.badgeValue sizeWithAttributes:@{NSFontAttributeName: self.titleLabel.font}];
            badgeW = badgeSize.width + 10;
        }
        
        frame.size.width  = badgeW;
        frame.size.height = badgeH;
        
        self.frame = frame;
    }
    else
    {
        self.hidden = YES;
    }
}

@end
