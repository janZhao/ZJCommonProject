//
//  Macros.h
//  ZJCommonProject
//
//  Created by jyd on 16/1/27.
//  Copyright © 2016年 jyd. All rights reserved.
//


//中文字体
#define CHINESE_FONT_NAME  @"Heiti SC"
#define CHINESE_SYSTEM(x) [UIFont fontWithName:CHINESE_FONT_NAME size:x]

#define UNICODETOUTF16(x) (((((x - 0x10000) >>10) | 0xD800) << 16)  | (((x-0x10000)&3FF) | 0xDC00))
#define MULITTHREEBYTEUTF16TOUNICODE(x,y) (((((x ^ 0xD800) << 2) | ((y ^ 0xDC00) >> 8)) << 8) | ((y ^ 0xDC00) & 0xFF)) + 0x10000

//获取View的属性
#define GetViewWidth(view)  view.frame.size.width
#define GetViewHeight(view) view.frame.size.height
#define GetViewX(view)      view.frame.origin.x
#define GetViewY(view)      view.frame.origin.y

//导航栏高度
#define TopBarHeight 64.5

// 字体大小(常规/粗体)
#define BOLDSYSTEMFONT(FONTSIZE)[UIFont boldSystemFontOfSize:FONTSIZE]
#define SYSTEMFONT(FONTSIZE)    [UIFont systemFontOfSize:FONTSIZE]
#define FONT(NAME, FONTSIZE)    [UIFont fontWithName:(NAME) size:(FONTSIZE)]

// 当前版本
#define FSystemVersion          ([[[UIDevice currentDevice] systemVersion] floatValue])
#define DSystemVersion          ([[[UIDevice currentDevice] systemVersion] doubleValue])
#define SSystemVersion          ([[UIDevice currentDevice] systemVersion])

// 是否IOS7
#define isIOS7                  ([[[UIDevice currentDevice]systemVersion]floatValue] >= 7.0)
// 是否IOS6
#define isIOS6                  ([[[UIDevice currentDevice]systemVersion]floatValue] < 7.0)
//
#define isIOS8                  ([[[UIDevice currentDevice]systemVersion]floatValue] >=8.0)
// 是否iPad
#define isPad                   (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

//获得RGB颜色
#define ZJColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define ZJColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//随机颜色
#define ZJRandomColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]

//3.自定义Log
#ifdef DEBUG
//#define ZJLog(...) NSLog(__VA_ARGS__)
#define ZJLog(...) NSLog(@"%s %d \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define ZJLog(...)
#endif

//4.输出frame(frame是结构体，没法%@)
#define ZJLogSize(size) ZJLog(@"[%s]:{%.2f, %.2f}", (#size), size.width, size.height);
#define ZJLogRect(f) NSLog(@"\nx:%f\ny:%f\nwidth:%f\nheight:%f\n",f.origin.x,f.origin.y,f.size.width,f.size.height)

//手机型号判别
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

//屏幕的分辨率 当结果为1时，显示的是普通屏幕，结果为2时，显示的是Retian屏幕
#define MainScreenScale [[UIScreen mainScreen]scale]
// App Frame Height&Width
#define Application_Frame  [[UIScreen mainScreen] applicationFrame] //除去信号区的屏幕的frame
#define APP_Frame_Height   [[UIScreen mainScreen] applicationFrame].size.height //应用程序的屏幕高度
#define App_Frame_Width    [[UIScreen mainScreen] applicationFrame].size.width  //应用程序的屏幕宽度
/*** MainScreen Height Width */
#define App_Main_Screen_Height [[UIScreen mainScreen] bounds].size.height //主屏幕的高度
#define App_Main_Screen_Width  [[UIScreen mainScreen] bounds].size.width  //主屏幕的宽度

// 是否空对象
#define IS_NULL_CLASS(OBJECT) [OBJECT isKindOfClass:[NSNull class]]

//色值
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

#define HEXCOLOR(hex) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0 green:((float)((hex & 0xFF00) >> 8)) / 255.0 blue:((float)(hex & 0xFF)) / 255.0 alpha:1]

#define COLOR_RGB(rgbValue,a) [UIColor colorWithRed:((float)(((rgbValue) & 0xFF0000) >> 16))/255.0 green:((float)(((rgbValue) & 0xFF00)>>8))/255.0 blue: ((float)((rgbValue) & 0xFF))/255.0 alpha:(a)]


//App版本号
#define appMPVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

//AppDelegate对象
#define AppDelegateInstance [[UIApplication sharedApplication] delegate]

//获取图片资源
#define GetImage(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]

//在Main线程上运行
#define DISPATCH_ON_MAIN_THREAD(mainQueueBlock) dispatch_async(dispatch_get_main_queue(), mainQueueBlock);

//主线程上Demo
//DISPATCH_ON_MAIN_THREAD(^{
    //更新UI
//})

//在Global Queue上运行
#define DISPATCH_ON_GLOBAL_QUEUE_HIGH(globalQueueBlocl) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), globalQueueBlocl);
#define DISPATCH_ON_GLOBAL_QUEUE_DEFAULT(globalQueueBlocl) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), globalQueueBlocl);
#define DISPATCH_ON_GLOBAL_QUEUE_LOW(globalQueueBlocl) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), globalQueueBlocl);
#define DISPATCH_ON_GLOBAL_QUEUE_BACKGROUND(globalQueueBlocl) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), globalQueueBlocl);

//Global Queue
//DISPATCH_ON_GLOBAL_QUEUE_DEFAULT(^{
    //异步耗时任务
//})
//DDLog等级
#ifdef DEBUG
static const int ddLogLevel = LOG_LEVEL_VERBOSE;
#else
static const int ddLogLevel = LOG_LEVEL_ERROR;
#endif
