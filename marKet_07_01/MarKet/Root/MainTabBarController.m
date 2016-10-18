//
//  MainTabBarController.m
//  MarKet
//
//  Created by Secret Wang on 16/3/10.
//  Copyright © 2016年 Secret. All rights reserved.
//
#import "MainTabBarController.h"
#import "BaseNavigationController.h"
#import "MarketsViewController.h"
#import "EconomicCalendarViewController.h"
#import "ExpertsLiveViewController.h"
#import "ImportantNewsViewController.h"
#import "LoginViewController.h"

@interface MainTabBarController ()<UITabBarControllerDelegate>
@property (strong,nonatomic) BaseNavigationController* nav2;
@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tabBar setTintColor:[UIColor colorWithRed:186/255.0 green:128/255.0 blue:15/255.0 alpha:1.0]];
    [self createTabbar];
    [self setImage];
}
-(void)setImage{
    NSArray *nameArray = @[@"行情中心",@"专家在线",@"财经日历",@"重要新闻"];
    NSArray *selectArray = @[@"tabbar_marketHL",@"tabbar_expertsLiveHL",@"tabbar_economicCalendarHL",@"tabbar_importantNewsHL"];
    NSArray *unSelectArray = @[@"tabbar_market",@"tabbar_expertsLive",@"tabbar_economicCalendar",@"tabbar_importantNews"];
    
    for (int i=0; i<nameArray.count; i++) {
        UITabBarItem * item = self.tabBar.items[i];
        UIImage* unSelectImage = [UIImage imageNamed:unSelectArray[i]];
        item.image = [unSelectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage* selectImage = [UIImage imageNamed:selectArray[i]];
        item.selectedImage = [selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item.title =  nameArray[i];
    }
}
-(void)createTabbar{
    MarketsViewController* vc1 = [[MarketsViewController alloc]init];
    ExpertsLiveViewController *vc2 = [[ExpertsLiveViewController alloc]init];
    EconomicCalendarViewController* vc3 = [[EconomicCalendarViewController alloc]init];
    ImportantNewsViewController* vc4 = [[ImportantNewsViewController alloc]init];
    
    BaseNavigationController* nav1 = [[BaseNavigationController alloc]initWithRootViewController:vc1];
    _nav2 = [[BaseNavigationController alloc]initWithRootViewController:vc2];
    BaseNavigationController * nav3= [[BaseNavigationController alloc]initWithRootViewController:vc3];
    BaseNavigationController* nav4 = [[BaseNavigationController alloc]initWithRootViewController:vc4];
    
    vc1.navigationItem.title = @"行情中心";
    vc2.navigationItem.title = @"专家在线";
    vc3.navigationItem.title = @"财经日历";
    vc4.navigationItem.title = @"重要新闻";
    
    vc1.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    vc2.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    vc3.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    vc4.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    
    vc1.navigationController.navigationBar.translucent = NO;
    vc2.navigationController.navigationBar.translucent = NO;
    vc3.navigationController.navigationBar.translucent = NO;
    vc4.navigationController.navigationBar.translucent = NO;
    
    self.viewControllers = @[nav1,_nav2,nav3,nav4];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    if (tabBar.selectedItem ==tabBar.items[1]) {
        NSString *userName = [[NSUserDefaults standardUserDefaults]objectForKey:@"userName"];
        NSString *pwd = [[NSUserDefaults standardUserDefaults]objectForKey:@"pwd"];
        if (userName==nil||pwd==nil) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle: @"请先登录" message:@"" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
            UIAlertAction *loginAction = [UIAlertAction actionWithTitle:@"登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                LoginViewController *loginV = [[LoginViewController alloc]init];
                loginV.hidesBottomBarWhenPushed = YES;
                [_nav2 pushViewController:loginV animated:YES];
            }];
            [alertController addAction:cancleAction];
            [alertController addAction:loginAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
