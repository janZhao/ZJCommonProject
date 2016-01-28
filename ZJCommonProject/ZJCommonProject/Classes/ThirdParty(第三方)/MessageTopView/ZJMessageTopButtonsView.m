//
//  ZJMessageTopButtonsView.m
//  MessageTopButtonsView
//
//  Created by jyd on 15/6/14.
//  Copyright (c) 2015年 jyd. All rights reserved.
//

#import "ZJMessageTopButtonsView.h"

@implementation ZJMessageTopButtonsView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        if(!_giveLineView){
            
            _giveLineView = [[UIImageView alloc] init];
            //_giveLineView.image = [UIImage imageNamed:@"button_index_line"];
            _giveLineView.image = [UIImage imageWithColor:JYDColorFromRGB(0x2CAFD7) size:CGSizeMake(App_Main_Screen_Width, 2)];
            [self addSubview:_giveLineView];
        }
        
        if(!_createButtonArray){
            
            _createButtonArray = [NSMutableArray arrayWithCapacity:0];
        }
        
        self.backgroundColor = [UIColor colorWithRed:241.0/255 green:242.0/255 blue:242.0/255 alpha:1.0];
    }
    
    return self;
}

-(void)layoutSubviews
{
    JYDLog(@"layoutSubviews");
    
    if((_buttonArray.count > 0 && _createButtonArray.count == 0))
    {
        for (int i = 0; i < _buttonArray.count; i++)
        {
            _button = [UIButton buttonWithType:UIButtonTypeCustom];
            [_button setBackgroundImage:[UIImage imageNamed:@"message_top_button_bg"] forState:UIControlStateNormal];
            //[_button setBackgroundImage:[UIImage imageNamed:@"button_index_line"] forState:UIControlStateHighlighted];
            [_button setBackgroundImage:[UIImage imageWithColor:JYDColorFromRGB(0x2CAFD7) size:CGSizeMake(App_Main_Screen_Width, 2)] forState:UIControlStateHighlighted];
            [_button setTitle:[_buttonArray objectAtIndex:i] forState:UIControlStateNormal];
            _button.titleLabel.font = [UIFont systemFontOfSize:15];
            [_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            _button.tag = i;
            [_button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            
            int width = self.frame.size.width / _buttonArray.count;
            
            _button.frame = CGRectMake(width * i, 0, width, self.frame.size.height);
            [self addSubview:_button];
            //2.竖直分割线 add by 2015-03-21
            UIView *vLine = [[UIView alloc]init];
            [vLine setBackgroundColor:[UIColor lightGrayColor]];
            vLine.frame = CGRectMake(width*i-2, 15, 2, 20);
            [self addSubview:vLine];
            
            [_createButtonArray addObject:_button];
        }
        
        [self createButtonIndex:0];
    }
}

/**
 *  按钮点击事件
 */
-(void)buttonAction:(UIButton *)button
{
    buttonClickIndex = button.tag;
    [self createButtonIndex:button.tag];
    
    if(self.delegete && [self.delegete respondsToSelector:@selector(messageTopButtonsClick:)]){
        
        [self.delegete messageTopButtonsClick:button.tag];
    }
}

/**
 *  创建Button的索引 下划线===>点击Button的时候显示的下划线
 */
-(void)createButtonIndex:(NSInteger )buttonIndex
{
    if(_createButtonArray.count)
    {
        for (int i = 0; i < _createButtonArray.count; i++)
        {
            UIButton *button = [_createButtonArray objectAtIndex:i];
            if(i == buttonIndex)
            {
                [button setTitleColor:JYDColorFromRGB(0x2CAFD7) forState:UIControlStateNormal];
            }
            else
            {
                [button setTitleColor:JYDColorFromRGB(0x727272) forState:UIControlStateNormal];
            }
        }
        
        int width = self.frame.size.width / _buttonArray.count;
        _giveLineView.frame = CGRectMake(width * buttonIndex, self.frame.size.height - 2, width, 2);
        [self bringSubviewToFront:_giveLineView];
    }
}

/**
 *  刷新索引-下划线
 */
-(void)refreshButtonIndex{
    
    [self createButtonIndex:buttonClickIndex];
    
    if(self.delegete && [self.delegete respondsToSelector:@selector(messageTopButtonsClick:)]){
        
        [self.delegete messageTopButtonsClick:buttonClickIndex];
    }
}

@end
