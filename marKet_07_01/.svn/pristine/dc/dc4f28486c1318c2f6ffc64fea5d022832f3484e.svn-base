//
//  BasePushViewController.m
//  MarKet
//
//  Created by dayu on 16/4/20.
//  Copyright © 2016年 Secret. All rights reserved.
//

#import "BasePushViewController.h"
#import <UIKit/UIKit.h>
@implementation BasePushViewController
+ (void)customPushViewController:(UINavigationController *)navigationController WithTargetViewController:(UIViewController *)viewController{
    [navigationController pushViewController:viewController animated:true];
    if ([navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
}
@end
