//
//  BaseViewController.m
//  MarKet
//
//  Created by Secret Wang on 16/3/17.
//  Copyright © 2016年 Secret. All rights reserved.
//
#import "BaseViewController.h"
#import "LoginViewController.h"
#import "UserInfoViewController.h"
#import "OpenAccountViewController.h"

@interface BaseViewController ()
@end
@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"root_user"] style:UIBarButtonItemStylePlain target:self action:@selector(userCenter)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"安全开户" style:UIBarButtonItemStyleDone target:self action:@selector(safeOpen)];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:15.0f],NSFontAttributeName, nil] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
}
#pragma mark -翻转动画
//- (void)pushNextWithType:(NSString *)type Subtype:(NSString *)subtype Viewcontroller:(UIViewController *)viewController
//{
//    CATransition *transition = [CATransition animation];
//    transition.type = type;
//    transition.subtype = subtype;
//    transition.duration = 0.5;
//    viewController.hidesBottomBarWhenPushed = YES;
//    [self.navigationController .view.layer addAnimation:transition forKey:nil];
//    [self.navigationController pushViewController:viewController animated:YES];
//    
//}
-(void)userCenter{
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"login"]==0) {
        LoginViewController *login = [[LoginViewController alloc]init];
//        [self pushNextWithType:@"cube" Subtype:@"fromRight" Viewcontroller:login];
        login.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:login animated:true];
    }else{
        UserInfoViewController *user = [[UserInfoViewController alloc]init];
//        [self pushNextWithType:@"cube" Subtype:@"fromRight" Viewcontroller:user];
        user.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:user animated:true];
    }
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
}
-(void)safeOpen{
    OpenAccountViewController *openAccount = [[OpenAccountViewController alloc]init];
//    [self pushNextWithType:@"cube" Subtype:@"fromRight" Viewcontroller:openAccount];
    openAccount.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:openAccount animated:true];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end