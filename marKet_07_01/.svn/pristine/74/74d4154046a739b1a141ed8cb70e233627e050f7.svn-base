//
//  NewsDetailViewController.m
//  MarKet
//
//  Created by Aaron Lee on 16/3/11.
//  Copyright © 2016年 Secret. All rights reserved.
//

#import "NewsDetailViewController.h"
#import "NewsTool.h"
#define WIDTH CGRectGetWidth([UIScreen mainScreen].bounds)
#define HEIGHT CGRectGetHeight([UIScreen mainScreen].bounds)
@interface NewsDetailViewController ()<UIWebViewDelegate>
@property(strong,nonatomic)UIAlertController *alert;
@property(strong,nonatomic)UIWebView *webView;
@property(strong,nonatomic)UIView *opaqueView;
@property(strong,nonatomic) UIActivityIndicatorView *activityIndicatorView;
@property(strong,nonatomic)UIButton *collectBtn;//收藏按钮
@end

@implementation NewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title=@"新闻详情";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"root_back"] style:UIBarButtonItemStylePlain target:self action:@selector(backBtnClick)];
    _collectBtn =[[UIButton alloc]init];
    [_collectBtn setBackgroundImage:[UIImage imageNamed:@"bctb"] forState:UIControlStateNormal];
    [_collectBtn setBackgroundImage:[UIImage imageNamed:@"Head"] forState:UIControlStateSelected];
    _collectBtn.frame=CGRectMake(0, 0, 20, 20);
    [_collectBtn addTarget:self action:@selector(collectClick:) forControlEvents:UIControlEventTouchUpInside];
    _collectBtn.selected=YES;
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:_collectBtn];
    
    [self createUI];
}

#pragma mark - 加载视图
-(void) createUI{
//    NSLog(@"%@    %@",_newid,_timeStr);
//    NSData *nsdata = [@"1469169135"
//                      dataUsingEncoding:NSUTF8StringEncoding];
//    NSString *base64Encoded = [nsdata base64EncodedStringWithOptions:0];
//    NSLog(@"Encoded=%@", base64Encoded);
//    NSData *nsdataFromBase64String = [[NSData alloc]
//                                      initWithBase64EncodedString:base64Encoded options:0];
//    NSString *base64Decoded = [[NSString alloc]
//                               initWithData:nsdataFromBase64String encoding:NSUTF8StringEncoding];
//    NSLog(@"Decoded: %@", base64Decoded);
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-64)];
    [_webView setUserInteractionEnabled:YES];//是否支持交互
    _webView.delegate=self;
    [_webView setOpaque:NO];//opaque是不透明的意思
    [_webView setScalesPageToFit:YES];//自动缩放以适应屏幕
    [self.view addSubview:_webView];
    
    //加载网页的方式
    //1.创建并加载远程网页
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://htmdata.fx678.com/15/oem/detail.php?s=ee2a88734cb4245254ecd78194a6eef6&oid=1&nid=%@&time=%@&key=b1198d2847a919924d8da3f650f2ca64",_newid,_timeStr]];
    
    [_webView loadRequest:[NSURLRequest requestWithURL:url]];
    //2.加载本地文件资源
    /* NSURL *url = [NSURL fileURLWithPath:filePath];
     NSURLRequest *request = [NSURLRequest requestWithURL:url];
     [webView loadRequest:request];*/
    //3.读入一个HTML，直接写入一个HTML代码
    //NSString *htmlPath = [[[NSBundle mainBundle]bundlePath]stringByAppendingString:@"webapp/loadar.html"];
    //NSString *htmlString = [NSString stringWithContentsOfURL:htmlPath encoding:NSUTF8StringEncoding error:NULL];
    //[webView loadHTMLString:htmlString baseURL:[NSURL fileURLWithPath:htmlPath]];
    _opaqueView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    _activityIndicatorView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    [_activityIndicatorView setCenter:_opaqueView.center];
    [_activityIndicatorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
    [_opaqueView setBackgroundColor:[UIColor blackColor]];
    [_opaqueView setAlpha:0.6];
    [self.view addSubview:_opaqueView];
    [_opaqueView addSubview:_activityIndicatorView];
}
#pragma mark
-(void)webViewDidStartLoad:(UIWebView *)webView{
    [_activityIndicatorView startAnimating];
    _opaqueView.hidden = NO;
}
#pragma mark
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [_activityIndicatorView startAnimating];
    _opaqueView.hidden = YES;
}
//UIWebView如何判断 HTTP 404 等错误
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSURL *url = [NSURL URLWithString:@"http://htmdata.fx678.com/15/oem/detail.php?s=ee2a88734cb4245254ecd78194a6eef6&oid=1&nid=201607221110292252&time=1469158286&key=1aca2ad7eee2927c65eed598ef2a32ac"];
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    if ((([httpResponse statusCode]/100) == 2)) {
        // self.earthquakeData = [NSMutableData data];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        
        [ _webView loadRequest:[ NSURLRequest requestWithURL: url]];
        _webView.delegate = self;
    } else {
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:
                                  NSLocalizedString(@"HTTP Error",
                                                    @"Error message displayed when receving a connection error.")
                                                             forKey:NSLocalizedDescriptionKey];
        NSError *error = [NSError errorWithDomain:@"HTTP" code:[httpResponse statusCode] userInfo:userInfo];
        if ([error code] == 404) {
            NSLog(@"404");
            _webView.hidden = YES;
        }
        
    }
}
#pragma mark -返回按钮点击事件
-(void)backBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -收藏按钮点击事件
-(void)collectClick:(UIBarButtonItem *)sender{
    _collectBtn.selected=!_collectBtn.selected;
    if (_collectBtn.selected==true) {
        _alert=[UIAlertController alertControllerWithTitle:@"" message:@"收藏成功" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:_alert animated:YES completion:^{
        }];
        [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(dismiss) userInfo:nil repeats:NO];
    }else{
        _alert=[UIAlertController alertControllerWithTitle:@"" message:@"取消收藏成功" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:_alert animated:YES completion:^{
        }];
        [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(dismiss) userInfo:nil repeats:NO];
    }
}
-(void)dismiss{
    [_alert dismissViewControllerAnimated:YES completion:nil];
}
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
    //UIStatusBarStyleDefault = 0 黑色文字，浅色背景时使用
    //UIStatusBarStyleLightContent = 1 白色文字，深色背景时使用
}
@end