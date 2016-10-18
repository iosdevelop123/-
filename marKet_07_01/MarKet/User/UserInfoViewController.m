//
//  UserInfoViewController.m
//  MarKet
//
//  Created by Aaron Lee on 16/3/15.
//  Copyright © 2016年 Secret. All rights reserved.
//

#import "UserInfoViewController.h"
#import "PwdChangeViewController.h"
#import "AboutXiDuViewController.h"
#import "MainTabBarController.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import "ProfessorTeamViewController.h"
#import "UIImageView+WebCache.h"
#define WIDTH CGRectGetWidth([UIScreen mainScreen].bounds)
#define HEIGHT CGRectGetHeight([UIScreen mainScreen].bounds)
@interface UserInfoViewController ()
@property (strong,nonatomic) NSArray *titleArr;
@property (strong,nonatomic) UILabel *nickLabel;
@property (strong,nonatomic) UIWebView *phoneCallWebView;
@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _titleArr=[NSArray arrayWithObjects:@"名师团队",@"转发",@"电话",@"关于西都", nil];
    self.navigationItem.title=@"个人资料";
    [self initNavigationBar];//初始化导航栏
    [self loadUI];
}
#pragma mark 初始化导航栏
- (void)initNavigationBar{
    //------ 初始化安全开户和个人中心按钮 ------
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"root_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(backBtnClick)];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleDone target:self action:@selector(pwdBtnClick:)];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:15.0f],NSFontAttributeName, nil] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem.tintColor=[UIColor whiteColor];
    
}
#pragma mark - 加载视图
- (void)loadUI{
    NSDictionary *dic=[[NSUserDefaults standardUserDefaults]objectForKey:@"userDic"];
    UIImageView *backgroundView=[[UIImageView alloc]initWithFrame:CGRectMake(0, -3, WIDTH, HEIGHT)];
    backgroundView.image=[UIImage imageNamed:@"background"];
    [self.view addSubview:backgroundView];
    
    UIImageView *headImgv=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH/2-30, 0.15*HEIGHT, 60, 60)];
    [headImgv sd_setImageWithURL:[NSURL URLWithString:dic[@"imgURL"]] placeholderImage:[UIImage imageNamed:@"Head"]];
    headImgv.layer.cornerRadius=30.0;
    [self.view  addSubview:headImgv];
    
    _nickLabel=[[UILabel alloc] init];
    _nickLabel.text = dic[@"nickeName"];
    _nickLabel.font=[UIFont systemFontOfSize:13.0];
    CGSize size =[_nickLabel.text boundingRectWithSize:CGSizeMake(1000, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:_nickLabel.font forKey:NSFontAttributeName] context:nil].size;
    _nickLabel.frame = CGRectMake(WIDTH/2-5-size.width, CGRectGetMaxY(headImgv.frame)+10, size.width, 20);
    _nickLabel.textAlignment=NSTextAlignmentLeft;
    [self.view  addSubview:_nickLabel];
    
    UILabel *userLabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2, CGRectGetMaxY(headImgv.frame)+10, 60, 20)];
    NSArray *arr=[NSArray arrayWithObjects:@"游客",@"普通会员",@"VIP",@"名师",@"客户经理",@"管理员",@"钻石VIP",@"至尊VIP",nil];
    userLabel.text=arr[[dic[@"type_id"] intValue]];
    userLabel.font=[UIFont systemFontOfSize:12.0];
    userLabel.textAlignment=NSTextAlignmentLeft;
    [self.view  addSubview:userLabel];
    
    UILabel *mottoLabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2-60, CGRectGetMaxY(_nickLabel.frame)+5, 120, 20)];
    mottoLabel.text=@"努力让梦想更近一点";
    mottoLabel.textAlignment=NSTextAlignmentCenter;
    mottoLabel.font=[UIFont systemFontOfSize:12.0];
    [self.view  addSubview:mottoLabel];
    
    UIButton *exitBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    exitBtn.frame=CGRectMake(40, CGRectGetMaxY(mottoLabel.frame)+0.13*HEIGHT, WIDTH-80, 0.08*HEIGHT);
    exitBtn.backgroundColor=[UIColor colorWithRed:254/255.0 green:159/255.0 blue:33/255.0 alpha:1.0];
    [exitBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    exitBtn.titleLabel.font = [UIFont systemFontOfSize:HEIGHT*0.028];
    [exitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    exitBtn.layer.cornerRadius=5;
    exitBtn.enabled=YES;
    [exitBtn addTarget:self action:@selector(exitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view  addSubview:exitBtn];
    
    UILabel *lineLabel=[[UILabel alloc]initWithFrame:CGRectMake(40, CGRectGetMaxY(exitBtn.frame)+0.10*HEIGHT, WIDTH-80, 1)];
    lineLabel.backgroundColor=[UIColor colorWithRed:232/255.0 green:212/255.0 blue:182/255.0 alpha:1.0];
    [self.view  addSubview:lineLabel];
    
    for (int i=0; i<4; i++) {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame=CGRectMake(WIDTH*0.05+i*(WIDTH/4), CGRectGetMaxY(lineLabel.frame)+HEIGHT*0.0225, WIDTH/4-WIDTH*0.1, WIDTH/4-HEIGHT*0.048);
        btn.tag=i;
        [btn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setBackgroundImage:[UIImage imageNamed:_titleArr[i]] forState:UIControlStateNormal];
        [self.view  addSubview:btn];
        //        [btn setTitle:_titleArr[i] forState:UIControlStateNormal];
        //        btn.titleLabel.font=[UIFont systemFontOfSize:11.0];
        //        btn.titleLabel.textAlignment=NSTextAlignmentCenter;
        //        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];//设置title在一般情况下为白色字体
        //        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];//设置title在button被选中情况下为灰色字体
        //        btn.titleEdgeInsets = UIEdgeInsetsMake(70, -btn.titleLabel.bounds.size.width-5, 0, 0);//设置title在button上的位置（上top，左left，下bottom，右right）
        //    [button setContentEdgeInsets:UIEdgeInsetsMake(70, 0, 0, 0)];//
        //   button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//设置button的内容横向居中。。设置content是title和image一起变化
    }
}
#pragma mark - 退出登录点击事件
- (void)exitBtnClick{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"要否退出登录" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"退出登录" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self presentViewController:[[MainTabBarController alloc]init] animated:YES completion:^{
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"login"];//------ 修改登录状态 ------
        }];
        [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"pwd"];
        [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"userName"];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];

}
#pragma mark -返回按钮点击
- (void)backBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -修改密码按钮点击(没接口)
- (void)pwdBtnClick:(UIBarButtonItem *)sender{
//    [self.navigationController pushViewController:[[PwdChangeViewController alloc]init] animated:YES];
//    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
//        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
//    }
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

#pragma mark -四个按钮点击事件
- (void)titleBtnClick:(UIButton *)sender{
    switch (sender.tag) {
        case 0:{
            ProfessorTeamViewController *professor=[[ProfessorTeamViewController alloc]init];
            [self.navigationController pushViewController:professor animated:true];
            if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
                self.navigationController.interactivePopGestureRecognizer.delegate = nil;
            }
            break;
        }
        case 1:
            [self shareApp];
            break;
        case 2:{
            //拨打电话
            NSString *telephoneNumber =  @"400-105-4080";
            NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",telephoneNumber]];
            if ( !_phoneCallWebView ) {
                _phoneCallWebView = [[UIWebView alloc]initWithFrame:CGRectZero];
            }
            [_phoneCallWebView loadRequest:[NSURLRequest requestWithURL:phoneURL]];
        }
            break;
        case 3:{
            AboutXiDuViewController *about = [[AboutXiDuViewController alloc]init];
//            [self pushNextWithType:@"cube" Subtype:@"fromRight" Viewcontroller:about];
            [self.navigationController pushViewController:about animated:YES];
            if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
                self.navigationController.interactivePopGestureRecognizer.delegate = nil;
            }
            break;
        }
        default:
            break;
    }
}
#pragma mark ****** 分享
-(void)shareApp{
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:@"下载去吧"
                                     images:[UIImage imageNamed:@"map.png"]
                                        url:[NSURL URLWithString:@"http://mob.com"]
                                      title:@"分享标题"
                                       type:SSDKContentTypeAuto];
    [ShareSDK showShareActionSheet:nil items:nil shareParams:shareParams onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
        switch (state) {
            case SSDKResponseStateSuccess:
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                    message:nil
                                                                   delegate:nil
                                                          cancelButtonTitle:@"确定"
                                                          otherButtonTitles:nil];
                [alertView show];
                break;
            }
            case SSDKResponseStateFail:
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                message:[NSString stringWithFormat:@"%@",error]
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil, nil];
                [alert show];
                break;
            }
            default:
                break;
        }
    }];
}
@end