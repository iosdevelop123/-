//
//  OnlineReleaseViewController.m
//  MarKet
//
//  Created by Secret Wang on 16/5/12.
//  Copyright © 2016年 Secret. All rights reserved.
//

#import "OnlineReleaseViewController.h"
#import "BaseNavigation.h"
#import "NAnswerViewController.h"
#import "AnswerViewController.h"
#import "AFNetworking.h"

#define URL @"http://175.102.13.51:8080/XDSY/Detail"
#define SIZE [[UIScreen mainScreen] bounds].size
#define GLODENCOLOR [UIColor colorWithRed:186/255.0 green:128/255.0 blue:15/255.0 alpha:1.0]
@interface OnlineReleaseViewController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource,UITextFieldDelegate>
{
    NSMutableArray* _vcArray;
    UIPageViewController* _pageViewController;
    UISegmentedControl* _segment;
    UITextField* _textFiled;
    UIView * bgView;
}
@end

@implementation OnlineReleaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [BaseNavigation loadUIViewController:self title:@"在线解套" navigationBarBgColor:[UIColor blackColor] backSelector:@selector(back)];
    [self createPageData];
    [self createPageView];
    [self createTextFiled];
    [self createSegment];
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}
-(void)keyboardWillShow:(NSNotification *)aNotification{
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    CGRect frame = bgView.frame;
    frame.origin.y = SIZE.height-64-40-height;
    bgView.frame = frame;
}
//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification
{
    CGRect frame = bgView.frame;
    frame.origin.y = SIZE.height-64-40;
    bgView.frame = frame;
}
#pragma mark ****** segment
-(void)createSegment{
    NSArray* segmentArray = @[@"已回答",@"未回答"];
    _segment = [[UISegmentedControl alloc]initWithItems:segmentArray];
    _segment.frame = CGRectMake(0, 0, 180,25);
    _segment.selectedSegmentIndex = 0;
    _segment.backgroundColor = [UIColor blackColor];;
    _segment.tintColor = GLODENCOLOR;
    _segment.layer.borderColor = GLODENCOLOR.CGColor;
    [_segment addTarget:self action:@selector(segmentClick:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = _segment;
    NSDictionary* dict = [[NSDictionary alloc]initWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, [UIFont systemFontOfSize:14.0f],NSFontAttributeName,nil];
    [_segment setTitleTextAttributes:dict forState:UIControlStateNormal];
    [_segment setTitleTextAttributes:dict forState:UIControlStateSelected];
}
#pragma mark ****** segment点击
-(void)segmentClick:(UISegmentedControl*)sender {
    NSInteger index = sender.selectedSegmentIndex;
    UIViewController* vc = _vcArray[index];
    [_pageViewController setViewControllers:@[vc] direction:index<0 animated:NO completion:nil];
}

#pragma mark ****** 创建pageVIew数据
-(void)createPageData{
    AnswerViewController* vc1 = [[AnswerViewController alloc]init];
    NAnswerViewController* vc2 = [[NAnswerViewController alloc]init];
    _vcArray = [[NSMutableArray alloc]initWithObjects:vc1,vc2, nil];
}
#pragma mark ****** 创建pageViewController
-(void)createPageView{
    _pageViewController = [[UIPageViewController alloc]initWithTransitionStyle:1 navigationOrientation:0 options:nil];
    _pageViewController.view.frame = CGRectMake(0, 0, SIZE.width, SIZE.height-40) ;
    [_pageViewController setViewControllers:@[_vcArray[0]] direction:1 animated:YES completion:nil];
    _pageViewController.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_pageViewController.view];
    _pageViewController.dataSource = self;
    _pageViewController.delegate = self;
}
#pragma mark ****** pageView的代理方法
-(void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed{
    UIViewController* vc = pageViewController.viewControllers[0];
    NSInteger index = [_vcArray indexOfObject:vc];
    _segment.selectedSegmentIndex = index;
}
-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    NSInteger index = [_vcArray indexOfObject:viewController];
    if (index==_vcArray.count-1) {
        return nil;
    }
    return _vcArray[index+1];
}
-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    NSInteger index = [_vcArray indexOfObject:viewController];
    if (index==0) {
        return nil;
    }
    return _vcArray[index-1];
}
#pragma mark ****** 提问输入框
-(void)createTextFiled{
    bgView = [[UIView alloc]initWithFrame:CGRectMake(0, SIZE.height-64-40, SIZE.width, 40)];
    [self.view addSubview:bgView];
    _textFiled = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, SIZE.width*0.8, 40)];
    _textFiled.borderStyle = UITextBorderStyleRoundedRect;
    _textFiled.placeholder = @"请输入问题";
    _textFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    _textFiled.returnKeyType = UIReturnKeyDone;
    _textFiled.delegate = self;
    _textFiled.clearsOnBeginEditing = YES;
    [bgView addSubview:_textFiled];
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setTitle:@"提交" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor = GLODENCOLOR;
    btn.frame = CGRectMake(CGRectGetMaxX(_textFiled.frame), _textFiled.frame.origin.y, SIZE.width*0.2, 40);
    [btn addTarget:self action:@selector(tijiao) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:btn];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ([_textFiled.text isEqual:@""]) {}
    else
        [self SubmitQuestion];
    [_textFiled resignFirstResponder];
    return YES;
}
#pragma mark ****** 提交按钮点击
-(void)tijiao{
    if ([_textFiled.text isEqual:@""]) {}
    else
        [self SubmitQuestion];
    [_textFiled resignFirstResponder];
}
#pragma mark ****** 返回
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)SubmitQuestion {
    NSNumber* userId = [[NSUserDefaults standardUserDefaults]objectForKey:@"id"];
    NSString* text = [NSString stringWithFormat:@"%@*%@",userId,_textFiled.text];
    NSCharacterSet* set = [NSCharacterSet URLPasswordAllowedCharacterSet];
    text = [text stringByAddingPercentEncodingWithAllowedCharacters:set];
    NSDictionary* parm = [[NSDictionary alloc]initWithObjectsAndKeys:
                          @"-1",@"id",
                          text,@"type",
                          nil];
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    [manager GET:URL parameters:parm progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString* i = responseObject[@"flag"];
        int index = [i intValue];
        if (index==1) {
            [self showAlert:@"提交成功..."];
        }else
            [self showAlert:@"未登录.."];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self showAlert:[NSString stringWithFormat:@"%@",error]];
    }];
}
#pragma mark ****** 提示框
- (void)timerFireMethod:(NSTimer*)theTimer//弹出框
{
    UIAlertController *promptAlert = (UIAlertController*)[theTimer userInfo];
    [promptAlert dismissViewControllerAnimated:YES completion:nil];
    promptAlert =nil;
}
- (void)showAlert:(NSString *) _message{//时间
    UIAlertController *promptAlert = [UIAlertController alertControllerWithTitle:@"提示" message:_message preferredStyle:UIAlertControllerStyleAlert];
    [NSTimer scheduledTimerWithTimeInterval:1.5f
                                     target:self
                                   selector:@selector(timerFireMethod:)
                                   userInfo:promptAlert
                                    repeats:YES];
    [self presentViewController:promptAlert animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
