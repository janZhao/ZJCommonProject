//
//  ZJSettingCell.h
//  ZJCommonProject
//
//  Created by jyd on 16/4/1.
//  Copyright © 2016年 jyd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJSettingItem.h"

@interface ZJSettingCell : UITableViewCell

@property (nonatomic, strong) ZJSettingItem *item;

/** switch状态改变的block*/
@property (copy, nonatomic) void(^switchChangeBlock)(BOOL on);

+ (id)settingCellWithTableView:(UITableView *)tableView;

@end
