//
//  ZJMessageTopButtonsView.h
//  MessageTopButtonsView
//
//  Created by jyd on 15/6/14.
//  Copyright (c) 2015年 jyd. All rights reserved.
//

@protocol ZJMessageTopButtonsViewDelegete <NSObject>

@optional
-(void)messageTopButtonsClick:(NSInteger ) buttonIndex;

@end

@interface ZJMessageTopButtonsView : UIView
{
    UIImageView         *_giveLineView;
    
    UIButton            *_button;
    
    NSArray             *_buttonArray;
    
    NSMutableArray      *_createButtonArray;
    
    NSInteger           buttonClickIndex;
}

@property(nonatomic,copy) NSArray           *buttonArray;

@property(nonatomic,copy) NSMutableArray    *createButtonArray;

/**
 *  创建Button的索引 下划线:点击Button的时候显示的下划线
 */
-(void)createButtonIndex:(NSInteger )buttonIndex;

/**
 *  刷新索引-下划线
 */
-(void)refreshButtonIndex;

@property (nonatomic, weak) id<ZJMessageTopButtonsViewDelegete> delegete;

@end
