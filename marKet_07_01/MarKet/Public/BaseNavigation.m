//
//  BaseNavigation.m
//  MarKet
//
//  Created by dayu on 16/4/20.
//  Copyright © 2016年 Secret. All rights reserved.
//

#import "BaseNavigation.h"
#import <UIKit/UIKit.h>
@implementation BaseNavigation
+ (void)loadUIViewController:(UIViewController *)viewController title:(NSString *)title navigationBarBgColor:(UIColor *)color backSelector:(SEL)backSelector{
    [viewController.view setBackgroundColor:[UIColor whiteColor]];
    //------ 导航栏 ------
    //------ 背景色 ------
    [viewController.navigationController.navigationBar setBarTintColor: color];
    //------ 前景色(除标题色) ------
    [viewController.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    //------ 标题 ------
    [viewController.navigationItem setTitle:title];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:18.0f],NSFontAttributeName, nil];
    [viewController.navigationController.navigationBar setTitleTextAttributes:dic];
    //------ 返回按钮 ------
    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"root_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:viewController action:backSelector];
}
@end
