//
//  ExpertsLiveViewController.m
//  MarKet
//
//  Created by Secret Wang on 16/3/10.
//  Copyright © 2016年 Secret. All rights reserved.
//

#import "ExpertsLiveViewController.h"
#import "ExpertsLiveTableViewCell.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import "HandanViewController.h"
#import "LoginViewController.h"
#import <WebKit/WebKit.h>

#define GLODENCOLOR [UIColor colorWithRed:186/255.0 green:128/255.0 blue:15/255.0 alpha:1.0]
#define WIDTH self.view.bounds.size.width
#define HEIGHT self.view.bounds.size.height

@interface ExpertsLiveViewController ()<UIScrollViewDelegate>
@property (strong,nonatomic) WKWebView *wkWebView;
@property (strong,nonatomic) UIView *topView;
@property (assign,nonatomic) CGFloat webViewHeight;
@end
@implementation ExpertsLiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createHandan];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.view.backgroundColor=[UIColor whiteColor];
    [self createLiveCerterUI];
    NSString *userName = [[NSUserDefaults standardUserDefaults]objectForKey:@"userName"];
    NSString *pwd = [[NSUserDefaults standardUserDefaults]objectForKey:@"pwd"];
    if (_wkWebView == nil && userName != nil && pwd != nil) {
        [self loadWKWebViewWithUserName:userName andPwd:pwd];
    }
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(login:) name:@"noti" object:nil];
}
-(void)login:(NSNotification*)sender{
    NSMutableArray* arr = [sender object];
    [self loadWKWebViewWithUserName:arr[0] andPwd:arr[1]];
    [_wkWebView setFrame:CGRectMake(0, CGRectGetMaxY(_topView.frame), WIDTH, _webViewHeight)];
}
#pragma mark ****** 创建右上角喊单
-(void)createHandan{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"喊单记录" style:UIBarButtonItemStyleDone target:self action:@selector(handan)];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:15.0f],NSFontAttributeName, nil] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
}
#pragma mark ****** 喊单记录
-(void)handan{
    HandanViewController* vc = [[HandanViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;}
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark 加载直播中心视图
-(void)createLiveCerterUI{
    _topView=[[UIView alloc]init];
    [_topView setFrame:CGRectMake(0, 0, WIDTH, HEIGHT*0.043)];
    _topView.backgroundColor=[UIColor colorWithRed:243/255.0 green:244/255.0 blue:245/255.0 alpha:1.0];
    [self.view addSubview:_topView];
    
    UILabel *nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH*0.05, HEIGHT*0.015, WIDTH*0.213, HEIGHT*0.024)];
    nameLabel.text=@"现货白银";
    nameLabel.font=[UIFont fontWithName:@"Helvetica" size:HEIGHT*0.024];
    nameLabel.numberOfLines=0;
    nameLabel.textColor=[UIColor redColor];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    [_topView addSubview:nameLabel];
    
    UILabel *newestPrice=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(nameLabel.frame)+40, HEIGHT*0.015, WIDTH*0.213, HEIGHT*0.024)];
    newestPrice.text=@"3902";
    newestPrice.font=[UIFont fontWithName:@"Helvetica" size:HEIGHT*0.024];
    newestPrice.textColor=[UIColor redColor];
    newestPrice.textAlignment = NSTextAlignmentCenter;
    [_topView addSubview:newestPrice];
    
    UILabel *changeLabel=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(newestPrice.frame)+40, HEIGHT*0.015, WIDTH*0.128, HEIGHT*0.021)];
    changeLabel.text=@"7";
    changeLabel.font=[UIFont fontWithName:@"Helvetica" size:HEIGHT*0.021];
    changeLabel.textColor=[UIColor redColor];
    changeLabel.textAlignment = NSTextAlignmentCenter;
    [_topView addSubview:changeLabel];
    
    UILabel *changeRateLabel=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(changeLabel.frame)+5, HEIGHT*0.015, WIDTH*0.128, HEIGHT*0.021)];
    changeRateLabel.text=@"+0.18%";
    changeRateLabel.font=[UIFont fontWithName:@"Helvetica" size:HEIGHT*0.021];
    changeRateLabel.textColor=[UIColor redColor];
    changeRateLabel.textAlignment = NSTextAlignmentCenter;
    [_topView addSubview:changeRateLabel];
    
    _webViewHeight = HEIGHT-112-HEIGHT*0.043;
}
#pragma mark 加载WKWebView
- (void)loadWKWebViewWithUserName:(NSString *)userName andPwd:(NSString *)pwd{
    //配置项
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    // 设置偏好设置
    configuration.preferences = [[WKPreferences alloc]init];
    // 默认为0
    configuration.preferences.minimumFontSize = 10;
    // 默认认为YES
    configuration.preferences.javaScriptEnabled = YES;
    // 在iOS上默认为NO，表示不能自动通过窗口打开
    configuration.preferences.javaScriptCanOpenWindowsAutomatically = NO;
    //交互控制器
    WKUserContentController *userContentController = [[WKUserContentController alloc] init];
    //添加一个js到html中
    WKUserScript *script = [[WKUserScript alloc] initWithSource:[NSString stringWithFormat:@"getuser('%@','%@');",userName,pwd] injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    [userContentController addUserScript:script];
    configuration.userContentController = userContentController;
    //创建wkWebView
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"h5socket" withExtension:@"html"];
    _wkWebView  = [[WKWebView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_topView.frame), WIDTH, _webViewHeight) configuration:configuration];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_wkWebView loadRequest:request];
    [self.view addSubview:_wkWebView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end