//
//  AppDelegate.m
//  ZJCommonProject
//
//  Created by jyd on 16/1/27.
//  Copyright © 2016年 jyd. All rights reserved.
//
//把Lumberjack框架添加到你的项目
//需要添加的主要文件有四个：
//1.@DDLog（整个框架的基础）
//2.@DDASLLogger（发送日志语句到苹果的日志系统，以便它们显示在Console.app上）
//3.@DDTTYLoyger（发送日志语句到Xcode控制台，如果可用）
//4.@DDFIleLoger（把日志语句发送至文件）
//
//DDLog是强制性的，其余的都是可选的，这取决于你打算如何使用这个框架。例如，如果你不打算纪录到一个文件，你可以跳过DDFileLogger，或者你想跳过ASL以便更快的文件记录，你可以跳过DDASLLoger。

#import "AppDelegate.h"
#import "YTKNetworkConfig.h"
#import "YTKUrlArgumentsFilter.h"
#import "MyCustomLogFormatter.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //1.日志开启记录
    [DDLog addLogger:[DDTTYLogger sharedInstance]];   // TTY = Xcode console
    //[DDLog addLogger:[DDASLLogger sharedInstance]]; // ASL = Apple System Logs
    
    //1.1日志打印格式
    MyCustomLogFormatter *formatter = [[MyCustomLogFormatter alloc]init];
    [[DDTTYLogger sharedInstance] setLogFormatter:formatter];
    
    //1.2日志级别
    [DDLog addLogger:[DDTTYLogger sharedInstance] withLevel:ddLogLevel];

    //1.3 And we also enable colors
    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
    
    //1.3.1 Customize our colors.
    #if TARGET_OS_IPHONE
        UIColor *pink = [UIColor colorWithRed:(255/255.0) green:(58/255.0) blue:(159/255.0) alpha:1.0];
    #else
        NSColor *pink = [NSColor colorWithCalibratedRed:(255/255.0) green:(58/255.0) blue:(159/255.0) alpha:1.0];
    #endif
    
    [[DDTTYLogger sharedInstance] setForegroundColor:pink backgroundColor:nil forFlag:DDLogFlagInfo];
     
    //1.4记录文件日志
    //DDFileLogger *fileLogger = [[DDFileLogger alloc] init]; // File Logger
    //fileLogger.rollingFrequency = 60 * 60 * 24; // 24 hour rolling
    //fileLogger.logFileManager.maximumNumberOfLogFiles = 7;
    //[DDLog addLogger:fileLogger];

    //2、请求全局地址设置
    [self setupRequestConfig];
    
    //3、请求统一加参数配置
    //[self setupRequestFilters];
    
    return YES;
}

- (void)setupRequestConfig
{
    YTKNetworkConfig *config = [YTKNetworkConfig sharedInstance];
    config.baseUrl = @"http://www.wenba99.com";
    config.cdnUrl = @"http://fen.bi";
}

- (void)setupRequestFilters
{
    NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    YTKNetworkConfig *config = [YTKNetworkConfig sharedInstance];
    YTKUrlArgumentsFilter *urlFilter = [YTKUrlArgumentsFilter filterWithArguments:@{@"version": appVersion}];
    [config addUrlFilter:urlFilter];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.jyd.ZJCommonProject" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"ZJCommonProject" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"ZJCommonProject.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
