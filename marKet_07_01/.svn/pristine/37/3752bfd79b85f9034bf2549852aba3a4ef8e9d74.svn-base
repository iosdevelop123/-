//
//  XiDuInfoViewController.m
//  MarKet
//
//  Created by Aaron Lee on 16/4/19.
//  Copyright © 2016年 Secret. All rights reserved.
//

#import "XiDuInfoViewController.h"
#import "BaseWKWebView.h"
#import "BaseWebRequest.h"
#define WIDTH CGRectGetWidth(self.view.bounds)
#define HEIGHT CGRectGetHeight(self.view.bounds)
#define API @"http://175.102.13.51:8080/XDSY/ZhuBan?type=.guanwang&defference=gongsi&indexPage=0"
@interface XiDuInfoViewController ()<UIWebViewDelegate>
@property (strong,nonatomic) BaseWKWebView *wkWebView;
@end
@implementation XiDuInfoViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"西都简介";
    //自定义返回按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"root_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    //创建WKWebView
    _wkWebView = [[BaseWKWebView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-64)];
    [self.view addSubview:_wkWebView];
    //网络请求
    BaseWebRequest *webRequest = [[BaseWebRequest alloc] init];
    [webRequest webRequestWithAPI:API CompletionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSDictionary *dic = (NSDictionary *)responseObject;
            NSString *htmlString = [[dic objectForKey:@"data"] objectForKey:@"gongsi"];
            //加载html字符串
            [_wkWebView loadHTMLString:htmlString baseURL:nil];
        }
    }];
}
- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
@end