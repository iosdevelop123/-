//
//  XiDuNewsDetailViewController.m
//  MarKet
//
//  Created by Aaron Lee on 16/5/18.
//  Copyright © 2016年 Secret. All rights reserved.
//

#import "XiDuNewsDetailViewController.h"
#import "BaseNavigation.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import "BaseWKWebView.h"
#import "BaseWebRequest.h"
#define URL @"http://175.102.13.51:8080/XDSY/Detail"
#define SIZE [[UIScreen mainScreen] bounds].size
@interface XiDuNewsDetailViewController ()
@property (strong,nonatomic) BaseWKWebView *wkWebView;
@end

@implementation XiDuNewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [BaseNavigation loadUIViewController:self title:@"西都新闻详情" navigationBarBgColor:[UIColor blackColor] backSelector:@selector(back)];
    //创建WKWebView
    _wkWebView = [[BaseWKWebView alloc] initWithFrame:CGRectMake(0, 0, SIZE.width, SIZE.height - 64)];
    [self.view addSubview:_wkWebView];
    //网络请求
    _Id=[[NSUserDefaults standardUserDefaults]objectForKey:@"id"];
    NSDictionary* parmarters = [[NSDictionary alloc]initWithObjectsAndKeys:
                                @"OfficialDto",@"type",
                                _Id,@"id",
                                nil];
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    [manager GET:URL parameters:parmarters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray* array = responseObject[@"data"];
        NSString* str = array[0][@"Body"];
        [_wkWebView loadHTMLString:str baseURL:nil];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}
- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
@end