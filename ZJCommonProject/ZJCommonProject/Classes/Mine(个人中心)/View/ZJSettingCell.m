//
//  ZJSettingCell.m
//  ZJCommonProject
//
//  Created by jyd on 16/4/1.
//  Copyright © 2016年 jyd. All rights reserved.
//

#import "ZJSettingCell.h"

@implementation ZJSettingCell
{
    UISwitch *_switch;
}

+ (id)settingCellWithTableView:(UITableView *)tableView
{
    // 0.用static修饰的局部变量，只会初始化一次
    static NSString *ID = @"Cell";
    
    // 1.拿到一个标识先去缓存池中查找对应的Cell
    ZJSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    // 2.如果缓存池中没有，才需要传入一个标识创建新的Cell
    if (cell == nil) {
        cell = [[ZJSettingCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)setItem:(ZJSettingItem *)item
{
    _item = item;
    
    // 设置数据
    self.imageView.image = [UIImage imageNamed:item.icon];
    self.textLabel.text  = item.title;
    self.detailTextLabel.text = item.detailTitle;
    
    if (item.type == ZFSettingItemTypeArrow)
    {
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        // 用默认的选中样式
        self.selectionStyle = UITableViewCellSelectionStyleBlue;
        
    }
    else if (item.type == ZFSettingItemTypeSwitch)
    {
        
        if (_switch == nil)
        {
            _switch = [[UISwitch alloc] init];
            [_switch addTarget:self action:@selector(switchStatusChanged:) forControlEvents:UIControlEventValueChanged];
        }
        
        // 右边显示开关
        self.accessoryView = _switch;
        // 禁止选中
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    } else
    {
        // 什么也没有，清空右边显示的view
        self.accessoryView = nil;
        // 用默认的选中样式
        self.selectionStyle = UITableViewCellSelectionStyleBlue;
        
    }

}

#pragma mark - SwitchValueChanged

- (void)switchStatusChanged:(UISwitch *)sender
{
    if (self.switchChangeBlock) {
        self.switchChangeBlock(sender.on);
    }
}

@end
