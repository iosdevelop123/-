//
//  LoginViewController.m
//  MarKet
//
//  Created by pan on 16/3/15.
//  Copyright © 2016年 Secret. All rights reserved.
//

#import "LoginViewController.h"
#import "BaseNavigation.h"
#import "RegisterViewController.h"
#import "AboutXiDuViewController.h"
#import "AFNetworking.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <AFNetworking/AFNetworking.h>
#import "ProfessorTeamViewController.h"
#import "MainTabBarController.h"
#import "BaseNavigationController.h"
#import "MainTabBarController.h"
#define WIDTH self.view.bounds.size.width
#define HEIGHT self.view.bounds.size.height

@interface LoginViewController ()
@property (strong,nonatomic) UITextField *userNameTxt;//用户名文本框
@property (strong,nonatomic) UITextField *pwdTxt;//密码文本框
@property (strong,nonatomic) UIButton *loginBtn;//登录按钮
@property (strong,nonatomic) NSMutableArray *array;
@property (strong,nonatomic) UIWebView *phoneCallWebView;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [BaseNavigation loadUIViewController:self title:@"登录" navigationBarBgColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1.0] backSelector:@selector(back)];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"立即注册" style:UIBarButtonItemStyleDone target:self action:@selector(registClick:)];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:15.0f],NSFontAttributeName, nil] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem.tintColor=[UIColor whiteColor];
    _array = [NSMutableArray array];
    [self customUI];
}
-(void)customUI{
    UIImageView *topImageView = [[UIImageView alloc]initWithFrame:CGRectMake((WIDTH-0.32*WIDTH)/2, 0.159*HEIGHT-64, 0.32*WIDTH, 0.06*HEIGHT)];
    topImageView.image = [UIImage imageNamed:@"logo"];
    [self.view addSubview:topImageView];
    NSArray *imgs = [NSArray arrayWithObjects:@"用户名",@"密码", nil];
    NSArray *texts = [NSArray arrayWithObjects:@"  请输入用户名",@"  请输入密码", nil];
    for (NSInteger i=0; i<2; i++) {
        UIView *userView = [[UIView alloc]initWithFrame:CGRectMake(WIDTH*0.107, CGRectGetMaxY(topImageView.frame)+HEIGHT*0.045+i*(HEIGHT*(0.075+0.04)), WIDTH-WIDTH*0.214, HEIGHT*0.08)];
        userView.backgroundColor = [UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1.0];
        userView.layer.cornerRadius = 5;
        userView.layer.masksToBounds = YES;
        [self.view addSubview:userView];
        
        UIButton *userButton = [UIButton buttonWithType:UIButtonTypeCustom];
        userButton.frame =CGRectMake(0, 0, HEIGHT*0.08, HEIGHT*0.08);
        [userButton setImage:[UIImage imageNamed:imgs[i]] forState:UIControlStateNormal];
        userButton.backgroundColor = [UIColor orangeColor];
        userButton.userInteractionEnabled = NO;
        [userView addSubview:userButton];
        
        UITextField *userNameTxt = [[UITextField alloc] initWithFrame:CGRectMake(WIDTH*0.157, 0, userView.frame.size.width-WIDTH*0.157, HEIGHT*0.08)];
        userNameTxt.placeholder=texts[i];
        NSAttributedString *placeholderString = [[NSAttributedString alloc] initWithString:texts[i] attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:HEIGHT*0.028],NSFontAttributeName, nil]];
        userNameTxt.attributedPlaceholder = placeholderString;
        userNameTxt.clearButtonMode = UITextFieldViewModeAlways;
        userNameTxt.font = [UIFont systemFontOfSize:HEIGHT*0.028];
        userNameTxt.keyboardType=UIKeyboardTypeDefault;
        userNameTxt.tag = 999+i;
        [_array addObject:userNameTxt];
        [userView addSubview:userNameTxt];
        if (i==1) {
            _pwdTxt = userNameTxt;
            _pwdTxt.secureTextEntry = YES;
        }else{
            _userNameTxt = userNameTxt;
            _userNameTxt.autocapitalizationType = UITextAutocapitalizationTypeNone;
        }
        
    }
    //------ 登录按钮 ------
    _loginBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _loginBtn.frame = CGRectMake(0.107*WIDTH, CGRectGetMaxY(topImageView.frame)+HEIGHT*0.24/*30+90+40*/+HEIGHT*0.02*3, WIDTH-WIDTH*0.214, 0.08*HEIGHT);
    [_loginBtn setTitle:@"马上登录" forState:UIControlStateNormal];
    [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_loginBtn.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    [_loginBtn.layer setMasksToBounds:YES];
    _loginBtn.backgroundColor=[UIColor orangeColor];
    _loginBtn.titleLabel.font = [UIFont systemFontOfSize:HEIGHT*0.028];
    [_loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginBtn];
    
    UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.107*WIDTH, CGRectGetMaxY(_loginBtn.frame)+0.239*HEIGHT, WIDTH-WIDTH*0.214, 0.5)];
    lineLabel.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:lineLabel];
    NSArray *images = [NSArray arrayWithObjects:@"名师团队",@"转发",@"电话",@"关于西都", nil];
    for (NSInteger i=0; i<4; i++) {
        UIButton *bottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
        bottomButton.frame = CGRectMake(WIDTH*0.05+i*(WIDTH/4), CGRectGetMaxY(lineLabel.frame)+HEIGHT*0.0225, WIDTH/4-WIDTH*0.1, WIDTH/4-HEIGHT*0.046);
        [bottomButton setBackgroundImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        bottomButton.tag = 100+i;
        [bottomButton addTarget:self action:@selector(bottomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:bottomButton];
    }
    //点击空白收起键盘
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
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
#pragma mark 点击底部button事件处理
-(void)bottomButtonClick:(UIButton*)sender{
    if (sender.tag == 100) {//名师团队
        ProfessorTeamViewController *professor=[[ProfessorTeamViewController alloc]init];
        [self.navigationController pushViewController:professor animated:true];
        if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.navigationController.interactivePopGestureRecognizer.delegate = nil;
        }
    }else if(sender.tag == 101){//分享APP
        [self shareApp];
    }else if (sender.tag == 102){//客服热线
        NSString *telephoneNumber =  @"400-105-4080";
        NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",telephoneNumber]];
        if ( !_phoneCallWebView ) {
            _phoneCallWebView = [[UIWebView alloc]initWithFrame:CGRectZero];
        }
        [_phoneCallWebView loadRequest:[NSURLRequest requestWithURL:phoneURL]];
    }else{//关于西都
        self.hidesBottomBarWhenPushed = YES;
        AboutXiDuViewController *about = [[AboutXiDuViewController alloc]init];
//        [self pushNextWithType:@"cube" Subtype:@"fromRight" Viewcontroller:about];
        [self.navigationController pushViewController:about animated:YES];
        if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.navigationController.interactivePopGestureRecognizer.delegate = nil;
        }
        
    }
}
#pragma mark 键盘收起
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    for (NSInteger i=0 ; i<2; i++) {
        [_array[i] resignFirstResponder];
    }
}
#pragma mark 跳转到注册页面
- (void)registClick:(UIBarButtonItem *)sender{
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:[[RegisterViewController alloc]init] animated:YES];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
}
#pragma mark 登陆按钮事件
-(void)loginBtnClick{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"http://175.102.13.51:8080/XDSY/HTUser?type=login&username=%@&pwd=%@&cb=1",_userNameTxt.text,_pwdTxt.text]];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
            NSString *msgstr = jsonObject[@"msg"];
            NSString *codestr = jsonObject[@"code"];
            if (![@"1" isEqualToString:codestr]) {
                UIAlertController *AlertController = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"%@！",msgstr] message:@"" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                [AlertController addAction:action];
                [self presentViewController:AlertController animated:YES completion:nil];
            }else{
                [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"login"];//------ 修改登录状态 ------
                NSString *idstr = jsonObject[@"id"];
                [[NSUserDefaults standardUserDefaults]setObject:idstr forKey:@"id"];
                NSString *faceImg = jsonObject[@"faceImg"];
                NSString *faceURL = jsonObject[@"faceURL"];
                NSString *imgURL=[NSString stringWithFormat:@"%@%@",faceURL,faceImg];
                NSDictionary *userDic=[NSDictionary dictionaryWithObjectsAndKeys:jsonObject[@"nickName"],@"nickeName",jsonObject[@"type_id"],@"type_id",imgURL,@"imgURL",jsonObject[@"userId"],@"userId",jsonObject[@"userName"],@"userName",nil];
                [[NSUserDefaults standardUserDefaults]setObject:userDic forKey:@"userDic"];
                [[NSUserDefaults standardUserDefaults]setObject:_pwdTxt.text forKey:@"pwd"];
                [[NSUserDefaults standardUserDefaults]setObject:_userNameTxt.text forKey:@"userName"];
                NSMutableArray* arr = [NSMutableArray arrayWithObjects:_userNameTxt.text,_pwdTxt.text, nil] ;
                [[NSNotificationCenter defaultCenter]postNotificationName:@"noti" object:arr];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
    }];
    [dataTask resume];
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end