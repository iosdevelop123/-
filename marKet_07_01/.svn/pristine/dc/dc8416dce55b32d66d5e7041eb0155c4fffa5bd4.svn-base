//
//  AppDelegate.m
//  MarKet
//
//  Created by Secret Wang on 16/3/10.
//  Copyright © 2016年 Secret. All rights reserved.
//
#import "AppDelegate.h"
#import "MainTabBarController.h"
#import "UserGuideViewController.h"
#import <SMS_SDK/SMSSDK.h>

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>

//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

//微信SDK头文件
#import "WXApi.h"

//新浪微博SDK头文件
#import "WeiboSDK.h"

@interface AppDelegate ()
@end

@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [SMSSDK registerApp:@"e1028399eb4d" withSecret:@"f8dbeda4e90e165c555d67c3195b2ebd"];
    [self shareSDk];
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]){
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        self.window.rootViewController = [[UserGuideViewController alloc] init];
    } else {
        self.window.rootViewController =  [[MainTabBarController alloc]init];
    }
    [self.window makeKeyAndVisible];
    return YES;
}
#pragma mark ****** 分享
-(void)shareSDk{
    [ShareSDK registerApp:@"104d0eec8b052" activePlatforms:@[
                                                        @(SSDKPlatformTypeSinaWeibo),
                                                        @(SSDKPlatformTypeWechat),
                                                        @(SSDKPlatformTypeQQ)] onImport:^(SSDKPlatformType platformType) {
                                                            switch (platformType) {
                                                                case SSDKPlatformTypeSinaWeibo:
                                                                    [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                                                                    break;
                                                                case SSDKPlatformTypeWechat:
                                                                    [ShareSDKConnector connectWeChat:[WXApi class]];
                                                                    break;
                                                                case SSDKPlatformTypeQQ:
                                                                    [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                                                                    break;
                                                                default:
                                                                    break;
                                                            }
                                                        } onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
                                                            switch (platformType) {
                                                                case SSDKPlatformTypeSinaWeibo:
                                                                    //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                                                                    [appInfo SSDKSetupSinaWeiboByAppKey:@"568898243"
                                                                                              appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
                                                                                            redirectUri:@"http://www.sharesdk.cn"
                                                                                               authType:SSDKAuthTypeBoth];
                                                                    break;
                                                                case SSDKPlatformTypeWechat:
                                                                    [appInfo SSDKSetupWeChatByAppId:@"wx4868b35061f87885"
                                                                                          appSecret:@"64020361b8ec4c99936c0e3999a9f249"];
                                                                    break;
                                                                case SSDKPlatformTypeQQ:
                                                                    [appInfo SSDKSetupQQByAppId:@"100371282"
                                                                                         appKey:@"aed9b0303e3ed1e27bae87c33761161d"
                                                                                       authType:SSDKAuthTypeBoth];
                                                                    break;
                                                                default:
                                                                    break;
                                                            }
                                                        }];
}
#pragma mark 禁用第三方输入法
- (BOOL)application:(UIApplication *)application shouldAllowExtensionPointIdentifier:(NSString *)extensionPointIdentifier{
    return NO;
}

@end