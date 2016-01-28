//
//  ZJBaseViewController.h
//  ZJCommonProject
//
//  Created by jyd on 16/1/27.
//  Copyright © 2016年 jyd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJBaseView.h"
#import "MBProgressHUD.h"

@interface ZJBaseViewController : UIViewController<MBProgressHUDDelegate, UIGestureRecognizerDelegate>
{
    ZJBaseView      *_mainView;
    NSInteger       _showLoadingViewCounter; // 显示加载窗体计算
    MBProgressHUD   *_progressHUD;
    MBProgressHUD   *_loadingView;
}


@property (nonatomic, retain) ZJBaseView *mainView;

@property (nonatomic, readonly) CGRect mainFrame;


/**
 *  弹出提示框 1秒后消失
 *
 *  @param message 文字
 */
- (void)showMomentAlertWithMessage:(NSString *)message;


/**
 *  弹出提示框
 */
- (void)showLoadingView;
- (void)showLoadingViewMessage:(NSString *)message;
- (void)showLoadingView:(ZJBaseView *)view;

/**
 *  默认为『加载中...』
 */
- (void)showLoadingViewWithText:(NSString *)text;

/**
 *  隐藏提示框
 */
- (void)hideLoadingView;

@end