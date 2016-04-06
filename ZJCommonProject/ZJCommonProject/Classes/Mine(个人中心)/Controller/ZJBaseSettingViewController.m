//
//  ZFBaseSettingViewController.m
//  ZJCommonProject
//
//  Created by jyd on 16/4/1.
//  Copyright © 2016年 jyd. All rights reserved.
//

#import "ZJBaseSettingViewController.h"
#import "ZJSettingGroup.h"
#import "ZJSettingItem.h"
#import "ZJSettingCell.h"

@interface ZJBaseSettingViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation ZJBaseSettingViewController

- (void)loadView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame style:UITableViewStyleGrouped];
    tableView.delegate   = self;
    tableView.dataSource = self;
    tableView.rowHeight  = 60;
    [tableView setSeparatorInset:UIEdgeInsetsZero];//分割线不偏离
    
    self.view = tableView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _allGroups = [NSMutableArray array];
    
}

#pragma mark - Table view data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _allGroups.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    ZJSettingGroup *group = _allGroups[section];
    
    return group.items.count;
}

#pragma mark 每当有一个cell进入视野范围内就会调用，返回当前这行显示的cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.创建一个ZFSettingCell
    ZJSettingCell *cell = [ZJSettingCell settingCellWithTableView:tableView];
    
    // 2.取出这行对应的模型（ZFSettingItem）
    ZJSettingGroup *group = _allGroups[indexPath.section];
    cell.item = group.items[indexPath.row];
    __block ZJSettingCell *weakCell = cell;
    
    cell.switchChangeBlock = ^ (BOOL on){
        if (weakCell.item.switchBlock) {
            weakCell.item.switchBlock(on);
        }
    };
    
    return cell;
}

#pragma mark 点击了cell后的操作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 0.取出这行对应的模型
    ZJSettingGroup *group = _allGroups[indexPath.section];
    ZJSettingItem *item = group.items[indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // 1.取出这行对应模型中的block代码
    if (item.operation) {
        // 执行block
        item.operation();
    }
}

#pragma mark 返回每一组的header标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    ZJSettingGroup *group = _allGroups[section];
    
    return group.header;
}
#pragma mark 返回每一组的footer标题
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    ZJSettingGroup *group = _allGroups[section];
    
    return group.footer;
}

@end
