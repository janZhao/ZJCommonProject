//
//  ZJBaseView.h
//  ZJCommonProject
//
//  Created by jyd on 16/1/27.
//  Copyright © 2016年 jyd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJBaseView : UIView

@property (nonatomic, readonly) CGRect mainFrame;

-(void)setup;

-(void)customLayoutSubviews;

@end
