//
//  AppDelegate.m
//  Healthdoctor
//
//  Created by 郭凯 on 16/5/17.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "AppDelegate.h"
#import "HZTabBarViewController.h"
#import "UIColor+Utils.h"
#import "LoginViewController.h"
#import "iflyMSC/IFlyMSC.h"
#import "Config.h"
#import "PasswdLoginViewController.h"
//#import <Bugly/Bugly.h>
#import "HZUtils.h"
#import "JPUSHService.h"

#define kIflyAppId @"57bf998f"
//#define kBugluAppId @"900037400"
#define kJPushAppId @"330bf15f3128cf7802eb9921"
#define kChannelId @"App Stroe"

@interface AppDelegate ()

@property (nonatomic, strong)UIViewController *main;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [NSThread sleepForTimeInterval:2.0];
    
  //  [Bugly startWithAppId:kBugluAppId];
    //获取应用沙盒
    NSString *path = NSHomeDirectory();
    NSLog(@"_______%@",path);
    
    /**************** 控件外观设置 *******************/
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    NSDictionary *navBarTitleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:18]};
    [[UINavigationBar appearance] setTitleTextAttributes:navBarTitleTextAttributes];
    [[UINavigationBar appearance] setBarTintColor:[UIColor navigationBarColor]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor tabBarColor]} forState:UIControlStateSelected];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} forState:UIControlStateNormal];
    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"tabbar_background"]];
    
    /********************************************** 配置讯飞语音 *******************************************/
    //创建语音配置  appid必须要传入  仅执行一次
    NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@",kIflyAppId];
    //所有服务启动之前  需要确保执行createUtility
    [IFlySpeechUtility createUtility:initString];
    
    /********************************************** 配置极光推送 *******************************************/
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    }else {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert)
                                              categories:nil];
    }

    // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
//    [JPUSHService setupWithOption:launchOptions appKey:kJPushAppId
//                          channel:kChannelId
//                 apsForProduction:NO
//            advertisingIdentifier:nil];
    [JPUSHService setupWithOption:launchOptions appKey:kJPushAppId channel:kChannelId apsForProduction:NO];
    
    [JPUSHService crashLogON];  //统计用户应用崩溃日志
    
    /*********************************************** 设置根视图 **********************************************/
    //UIViewController *root = [[LoginViewController alloc] init];
    UIViewController *root = [[PasswdLoginViewController alloc] init];
    if ([Config isLogin]) {
        root = [[HZTabBarViewController alloc] init];
    }
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = root;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
    
   // UILocalNotification
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    // IOS 7 Support Required
    [JPUSHService handleRemoteNotification:userInfo];
    NSLog(@"__________UserInfo:%@",userInfo);
    NSDictionary *aps = userInfo[@"aps"];
    [[[UIAlertView alloc] initWithTitle:@"提示" message:aps[@"alert"] delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil] show];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

- (void)applicationWillResignActive:(UIApplication *)application {
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
}

@end
