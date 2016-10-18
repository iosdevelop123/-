//
//  DaysDetailController.m
//  MarKet
//
//  Created by Secret Wang on 16/3/11.
//  Copyright © 2016年 Secret. All rights reserved.
//
#import "DaysDetailController.h"
#import "BaseNavigation.h"
#import <AVKit/AVKit.h>
#import "BaseWKWebView.h"
#import <AFNetworking/AFNetworking.h>

#define URL @"http://175.102.13.51:8080/XDSY/Detail"
#define SIZE [[UIScreen mainScreen] bounds].size
@interface DaysDetailController ()
@property (strong,nonatomic) BaseWKWebView *wkWebView;
@end
@implementation DaysDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    //自定义导航栏
    [BaseNavigation loadUIViewController:self title:_navigationTitle navigationBarBgColor:[UIColor blackColor] backSelector:@selector(backToMainView)];
    //创建WKWebView
    _wkWebView = [[BaseWKWebView alloc] initWithFrame:CGRectMake(0,0, SIZE.width  , SIZE.height-64)];
    [self.view addSubview:_wkWebView];
    [self getDataFromWeb];
}
#pragma mark ****** 数据请求
-(void)getDataFromWeb{
    NSDictionary* parmarters = [[NSDictionary alloc]initWithObjectsAndKeys:
                                @"OfficialDto",@"type",
                                _Id,@"id",
                                nil];
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    [manager GET:URL parameters:parmarters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray* array = responseObject[@"data"];
        NSString* str = array[0][@"Body"];
        if (_isVido==YES) {
             NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:str]];
            [_wkWebView loadRequest:request];
        }else
            [_wkWebView loadHTMLString:str baseURL:nil];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
-(void)backToMainView{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end