//
//  ZJBaseViewController.m
//  ZJCommonProject
//
//  Created by jyd on 16/1/27.
//  Copyright © 2016年 jyd. All rights reserved.
//

#import "ZJBaseViewController.h"
#import "ZJBaseView.h"
#import "MBProgressHUD.h"

#define kControllerSuffix @"Controller"

@interface  ZJBaseViewController()

@end

@implementation ZJBaseViewController

@synthesize mainView = _mainView;
@synthesize mainFrame = _mainFrame;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}

- (void)loadView
{
    [super loadView];
    
    if (!_mainView)
    {
        NSString *className = NSStringFromClass([self class]);
        
        className = [className stringByReplacingOccurrencesOfString:kControllerSuffix withString:@""];
        
        Class class = NSClassFromString(className);
        
        ZJBaseView *view = [(ZJBaseView *)[class alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
        //view.backgroundColor = [UIColor whiteColor];
        self.mainView = view;
        [self.view addSubview:_mainView];
    }
}

- (CGRect)mainFrame
{
    CGRect frame = self.view.bounds;
    /*
     * IOS 7
     * frame.origin.y = 20; 状态栏会留黑边
     *
     */
    
    return frame;
}

- (void)showMomentAlertWithMessage:(NSString *)message
{
    _progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
    _progressHUD.alpha = 0.5;
    [self.view addSubview:_progressHUD];
    
    // The sample image is based on the work by http://www.pixelpressicons.com, http://creativecommons.org/licenses/by/2.5/ca/
    // Make the customViews 37 by 37 pixels for best results (those are the bounds of the build-in progress indicators)
    _progressHUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark"]];
    
    // Set custom view mode
    _progressHUD.mode = MBProgressHUDModeCustomView;
    
    _progressHUD.delegate = self;
    _progressHUD.labelText = message;
    
    [_progressHUD show:YES];
    [_progressHUD hide:YES afterDelay:1];
}


// loadingView
- (void)showLoadingViewWithText:(NSString *)aStr
{
    if(_showLoadingViewCounter < 0)
    {
        _showLoadingViewCounter = 0;
    }
    
    _showLoadingViewCounter ++;
    
    if (_showLoadingViewCounter > 0)
    {
        if (!_loadingView) {
            _loadingView = [[MBProgressHUD alloc] initWithView:self.view];
            _loadingView.color = [UIColor blackColor];
            //[UIColor colorWithRed:0.23 green:0.50 blue:0.82 alpha:0.90];
        }
        
        [self.view addSubview:_loadingView];
        
        [self.view bringSubviewToFront:_loadingView];
        [_loadingView show:YES];
    }
    
    _loadingView.labelText = aStr;
}

- (void)showLoadingView
{
    [self showLoadingViewWithText:@"加载中..."];
}

- (void)showLoadingViewMessage:(NSString *)message
{
    [self showMomentAlertWithMessage:message];
}

- (void)hideLoadingView
{
    if (_showLoadingViewCounter > 0)
    {
        _showLoadingViewCounter --;
    }
    
    if (_showLoadingViewCounter <= 0)
    {
        [_loadingView hide:YES];
        [_loadingView removeFromSuperview];
    }
}


// loadingView
- (void)showLoadingViewWithText:(NSString *)aStr view:(ZJBaseView *)view
{
    if(_showLoadingViewCounter < 0)
    {
        _showLoadingViewCounter = 0;
    }
    _showLoadingViewCounter ++;
    
    if (_showLoadingViewCounter > 0)
    {
        if (!_loadingView)
        {
            _loadingView = [[MBProgressHUD alloc] initWithView:view];
            _loadingView.color = [UIColor blackColor];
            //[UIColor colorWithRed:0.23 green:0.50 blue:0.82 alpha:0.90];
        }
        
        [view addSubview:_loadingView];
        
        [view bringSubviewToFront:_loadingView];
        [_loadingView show:YES];
    }
    
    _loadingView.labelText = aStr;
}

- (void)showLoadingView:(ZJBaseView *)view
{
    [self showLoadingViewWithText:@"加载中..." view:view];
}

#pragma mark MBProgressHUDDelegate methods
- (void)hudWasHidden:(MBProgressHUD *)hud
{
    // Remove HUD from screen when the HUD was hidded
    [_progressHUD removeFromSuperview];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    _mainView.frame = [self mainFrame];
}

@end
