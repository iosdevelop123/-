//
//  OpenAccountViewController.m
//  MarKet
//
//  Created by pan on 16/5/9.
//  Copyright © 2016年 Secret. All rights reserved.
//开户申请

#import "OpenAccountViewController.h"
#import "BaseNavigation.h"
#import <AFNetworking/AFNetworking.h>
#import "LQQMonitorKeyboard.h"

#define WIDTH self.view.bounds.size.width
#define HEIGHT self.view.bounds.size.height

@interface OpenAccountViewController ()
@property (strong,nonatomic) UITextField *userNameTxt;//用户名文本框
@property (strong,nonatomic) UITextField *phoneNumberTxt;//手机号码文本框
@property (strong,nonatomic) UITextField *authCodeTxt;//验证码文本框
@property (strong,nonatomic) UIButton *getAuthCodeBtn;//获取验证码按钮
@property (strong,nonatomic) NSMutableArray *array;
@property (strong,nonatomic) UIButton *openAccountBtn;
@property (assign,nonatomic) int secondsCountDown; //倒计时总时长
@property (strong,nonatomic) NSTimer *countDownTimer;//计时器

@end

@implementation OpenAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"免费开户"]];
    [BaseNavigation loadUIViewController:self title:@"申请开户" navigationBarBgColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1.0] backSelector:@selector(back)];
    _array = [NSMutableArray array];
    
    [self customUI];

}
-(void)customUI{
    UIImageView *backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    backImageView.image = [UIImage imageNamed:@"免费开户"];
    [self.view addSubview:backImageView];
    NSArray *imgs = [NSArray arrayWithObjects:@"用户名",@"手机", @"验证码",nil];
    NSArray *texts = [NSArray arrayWithObjects:@" 请输入用户名",@" 请输入手机号码", @" 请输入验证码",nil];
    for (NSInteger i=0; i<3; i++) {
        UIView *userView = [[UIView alloc]initWithFrame:CGRectMake(WIDTH*0.107, HEIGHT*0.45+i*HEIGHT*(0.075+0.03), WIDTH-WIDTH*0.214, HEIGHT*0.08)];
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
        if (i==0) {
            _userNameTxt = userNameTxt;
            _userNameTxt.autocapitalizationType = UITextAutocapitalizationTypeNone;
        }else if (i==1){
            _phoneNumberTxt = userNameTxt;
            _phoneNumberTxt.autocapitalizationType = UITextAutocapitalizationTypeNone;
            _phoneNumberTxt.keyboardType =UIKeyboardTypePhonePad;
        }else{
            _authCodeTxt = userNameTxt;
            _authCodeTxt.autocapitalizationType = UITextAutocapitalizationTypeNone;
            _authCodeTxt.keyboardType = UIKeyboardTypeNumberPad;
            userView.frame = CGRectMake(WIDTH*0.107, HEIGHT*0.45+i*HEIGHT*(0.075+0.03), WIDTH-WIDTH*0.214-WIDTH*0.213, HEIGHT*0.08);
            //            _userNameTxt.autocorrectionType = UITextAutocorrectionTypeNo;
            //------ 获取验证码 ------
            _getAuthCodeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            _getAuthCodeBtn.frame = CGRectMake(CGRectGetMaxX(userView.frame)+1, CGRectGetMinY(userView.frame)+HEIGHT*0.021+HEIGHT*0.01, WIDTH*0.16+WIDTH*0.053, HEIGHT*0.047);
            [_getAuthCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
            [_getAuthCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            _getAuthCodeBtn.titleLabel.font = [UIFont systemFontOfSize:HEIGHT*0.02];
            _getAuthCodeBtn.layer.cornerRadius = 2.0;//设置矩形四个圆角半径
            _getAuthCodeBtn.layer.masksToBounds = YES;
            _getAuthCodeBtn.backgroundColor=[UIColor orangeColor];
            _getAuthCodeBtn.enabled=YES;
            [_getAuthCodeBtn addTarget:self action:@selector(getAuthCodeClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:_getAuthCodeBtn];
        }
        
    }
    //------ 登录按钮 ------
    _openAccountBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _openAccountBtn.frame = CGRectMake(0.107*WIDTH, HEIGHT*0.69+HEIGHT*0.02*4, WIDTH-WIDTH*0.214, 0.08*HEIGHT);
    [_openAccountBtn setTitle:@"申请开户" forState:UIControlStateNormal];
    [_openAccountBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_openAccountBtn.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    [_openAccountBtn.layer setMasksToBounds:YES];
    _openAccountBtn.titleLabel.font = [UIFont systemFontOfSize:0.028*HEIGHT];
    _openAccountBtn.backgroundColor=[UIColor orangeColor];
    [_openAccountBtn addTarget:self action:@selector(openAccountBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_openAccountBtn];
    
    //点击空白收起键盘
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];
}
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    for (NSInteger i=0 ; i<3; i++) {
        [_array[i] resignFirstResponder];
    }
}
#pragma mark 获取验证码按钮事件
-(void)getAuthCodeClick:(UIButton*)sender{
    //设置倒计时总时长
    _secondsCountDown = 30;//60秒倒计时http://175.102.13.51:8080/XDSY/HTGetCode?mob=%@
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"http://175.102.13.51:8080/XDSY/HTGetCode?mob=%@",_phoneNumberTxt.text]];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
            NSString *msgstr = jsonObject[@"msg"];
            NSString *codestr = [jsonObject[@"code"] stringValue];
            if ([@"0" isEqualToString:codestr]) {
                UIAlertController *AlertController = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"%@！",msgstr] message:@"" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                [AlertController addAction:action];
                [self presentViewController:AlertController animated:YES completion:nil];
            }else{
                //开始倒计时
                _countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES]; //启动倒计时后会每秒钟调用一次方法 timeFireMethod
                _getAuthCodeBtn.enabled = NO;
                //设置倒计时显示的数字
                _getAuthCodeBtn.backgroundColor = [UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1.0];
                [_getAuthCodeBtn setTitle:[NSString stringWithFormat:@"%d",_secondsCountDown] forState:UIControlStateNormal];
                [_getAuthCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }
            
        }
    }];
    [dataTask resume];
}
-(void)timeFireMethod{
    //倒计时-1
    _secondsCountDown--;
    //修改倒计时标签现实内容
    [_getAuthCodeBtn setTitle:[NSString stringWithFormat:@"%d",_secondsCountDown] forState:UIControlStateNormal];
    //当倒计时到0时，做需要的操作，比如验证码过期不能提交
    if(_secondsCountDown==0){
        [_countDownTimer invalidate];
        _getAuthCodeBtn.enabled = YES;
        [_getAuthCodeBtn setTitle:@"重新获取" forState:UIControlStateNormal];
        _getAuthCodeBtn.backgroundColor = [UIColor orangeColor];
    }
}
#pragma mark 申请开户事件
-(void)openAccountBtnClick:(UIButton*)sender{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"http://175.102.13.51:8080/XDSY/HTUser?type=kaihu&username=%@&mobile=%@&code=%@&cb=1",_userNameTxt.text,_phoneNumberTxt.text,_authCodeTxt.text]];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
            NSString *msgstr = jsonObject[@"msg"];
            NSString *codestr = jsonObject[@"code"];
            if (![@"1" isEqualToString:codestr]) {//申请失败
                UIAlertController *AlertController = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"%@！",msgstr] message:@"" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                [AlertController addAction:action];
                [self presentViewController:AlertController animated:YES completion:nil];
            }else{
                [self.navigationController popViewControllerAnimated:YES];
            }
            
        }
    }];
    [dataTask resume];

}
- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
