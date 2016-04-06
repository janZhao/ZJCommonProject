//
//  ZJSettingViewController.m
//  ZJCommonProject
//
//  Created by jyd on 16/4/1.
//  Copyright © 2016年 jyd. All rights reserved.
//

#import "ZJSettingViewController.h"
#import "ZJSettingItem.h"
#import "ZJSettingGroup.h"

@interface ZJSettingViewController ()

@property (nonatomic, copy) NSString *cacheSizeStr;

@end

@implementation ZJSettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //缓存大小
    self.cacheSizeStr = [self getCacheSize];
    
    // 1.第0组：3个
    [self add0SectionItems];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}

-(NSString *)getCacheSize
{
    NSString *descriStr = @"0M";
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    float folderSize;
    
    if ([fileManager fileExistsAtPath:path])
    {
        //拿到算有文件的数组
        NSArray *childerFiles = [fileManager subpathsAtPath:path];
        //拿到每个文件的名字,如有有不想清除的文件就在这里判断
        for (NSString *fileName in childerFiles)
        {
            //将路径拼接到一起
            NSString *fullPath = [path stringByAppendingPathComponent:fileName];
            folderSize += [self fileSizeAtPath:fullPath];
        }
        
        if (folderSize > 0)
        {
            descriStr = [NSString stringWithFormat:@"%.2fM", folderSize];
        }
    }
    
    return descriStr;
}

#pragma mark 添加第0组的模型数据
- (void)add0SectionItems
{
    //__weak typeof(self) weakSelf = self;
    
    ZJSettingItem *updateItem = [ZJSettingItem itemWithIcon:@"icon-list02" title:@"检查更新" type:ZFSettingItemTypeArrow detailTitle:@""];
    updateItem.operation = ^{
        DDLogVerbose(@"检查更新");
    };
    
    ZJSettingItem *cleanCacheItem = [ZJSettingItem itemWithIcon:@"icon-list03" title:@"清理缓存" type:ZFSettingItemTypeArrow detailTitle:self.cacheSizeStr];
    
    cleanCacheItem.operation = ^{
        DDLogVerbose(@"清缓存");
        [self cacheClean];
    };
    
    ZJSettingGroup *group = [[ZJSettingGroup alloc] init];
    group.header = @"基本设置";
    group.items = @[updateItem, cleanCacheItem];
    [_allGroups addObject:group];
}

//清理缓存
-(void)cacheClean
{
    //拿到要清理的路径,其实就是caches的路径,一般像这种很多地方都会用到的地方真好搞成宏,不过现在苹果不提倡用宏了
    //在swift中可以定义成全局的常量
    //遍历caches,将内部的文件大小计算出来,点击确认删除的话直接删除全部文件,如果有不想清理的文件,可以在遍历文件时根据路径过滤掉
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    float folderSize;
    if ([fileManager fileExistsAtPath:path]) {
        //拿到算有文件的数组
        NSArray *childerFiles = [fileManager subpathsAtPath:path];
        //拿到每个文件的名字,如有有不想清除的文件就在这里判断
        for (NSString *fileName in childerFiles) {
            //将路径拼接到一起
            NSString *fullPath = [path stringByAppendingPathComponent:fileName];
            folderSize += [self fileSizeAtPath:fullPath];
        }
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"清理缓存" message:[NSString stringWithFormat:@"缓存大小为%.2fM,确定要清理缓存吗?", folderSize] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
    }
    
}

#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1)
    {

        //点击了确定,遍历整个caches文件,将里面的缓存清空
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        NSFileManager *fileManager=[NSFileManager defaultManager];
        if ([fileManager fileExistsAtPath:path])
        {
            NSArray *childerFiles=[fileManager subpathsAtPath:path];
            for (NSString *fileName in childerFiles)
            {
                //如有需要，加入条件，过滤掉不想删除的文件
                NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
                [fileManager removeItemAtPath:absolutePath error:nil];
            }
        }
    }
    
}

//计算单个文件夹的大小
-(float)fileSizeAtPath:(NSString *)path
{    
    NSFileManager *fileManager=[NSFileManager defaultManager];
    
    if([fileManager fileExistsAtPath:path])
    {
        
        long long size=[fileManager attributesOfItemAtPath:path error:nil].fileSize;
        
        return size/1024.0/1024.0;
    }
    return 0;
}


@end
