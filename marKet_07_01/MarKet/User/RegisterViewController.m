//
//  RegistViewController.m
//  MarKet
//
//  Created by pan on 16/3/15.
//  Copyright © 2016年 Secret. All rights reserved.
//

#import "RegisterViewController.h"
#import "BaseNavigation.h"
#import <SMS_SDK/SMSSDK.h>
#import "LQQMonitorKeyboard.h"
#import <AFNetworking/AFNetworking.h>

#define WIDTH self.view.bounds.size.width
#define HEIGHT self.view.bounds.size.height
@interface RegisterViewController ()
@property (strong,nonatomic) UITextField *userNameTxt;//用户名文本框
@property (strong,nonatomic) UITextField *nickName;//昵称文本框
@property (strong,nonatomic) UITextField *pwdTxt;//密码文本框
@property (strong,nonatomic) UITextField *surePwdTxt;//确认密码文本框
@property (strong,nonatomic) UITextField *phoneNumber;//手机号码文本框
@property (strong,nonatomic) UITextField *authCode;//验证码文本框
@property (strong,nonatomic) UIButton *getAuthCodeBtn;//获取验证码按钮
@property (strong,nonatomic) UIButton *registBtn;//注册按钮
@property (assign,nonatomic) int secondsCountDown; //倒计时总时长
@property (strong,nonatomic) NSTimer *countDownTimer;//计时器
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [BaseNavigation loadUIViewController:self title:@"注册" navigationBarBgColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1.0] backSelector:@selector(back)];
    [self customUI];
}
-(void)customUI{
    UIImageView *topImageView = [[UIImageView alloc]initWithFrame:CGRectMake((WIDTH-0.32*WIDTH)/2, 0.159*HEIGHT-64, 0.32*WIDTH, 0.06*HEIGHT)];
    topImageView.image = [UIImage imageNamed:@"logo"];
    [self.view addSubview:topImageView];
    UIView *userView = [[UIView alloc]initWithFrame:CGRectMake(WIDTH*0.107, CGRectGetMaxY(topImageView.frame)+HEIGHT*0.045, WIDTH-WIDTH*0.214, HEIGHT*0.06)];
    userView.backgroundColor = [UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1.0];
    userView.layer.cornerRadius = 5;
    userView.layer.masksToBounds = YES;
    [self.view addSubview:userView];
    NSMutableArray *uiviewArray = [NSMutableArray arrayWithObject:userView];
    for (int i = 1; i<6; i++) {
        UIView *aView = [[UIView alloc] init];
        if(i != 5) {
            UIView *v = (UIView *)[uiviewArray objectAtIndex:i - 1];
            aView.frame = CGRectMake(WIDTH*0.107, CGRectGetMaxY(v.frame)+5, WIDTH-WIDTH*0.214, HEIGHT*0.06);
        }else{
            UIView *v = (UIView *)[uiviewArray objectAtIndex:4];
            aView.frame = CGRectMake(WIDTH*0.107, CGRectGetMaxY(v.frame)+5, WIDTH-WIDTH*(0.16+0.213)-WIDTH*0.053, HEIGHT*0.06);
        }
        aView.backgroundColor = [UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1.0];
        aView.layer.cornerRadius = 5;
        aView.layer.masksToBounds = YES;
        [self.view addSubview:aView];
        [uiviewArray addObject:aView];
    }
    NSArray *nameArray = @[@"  用户名",@"  昵称",@"  密码",@"  确认密码",@"  手机号码",@"  验证码"];
    NSArray *imgNameArray = @[@"用户名",@"昵称",@"密码",@"密码",@"手机",@"验证码"];
    NSMutableArray *buttonArray  = [NSMutableArray array];
    for (int i = 0; i < 6; i++) {
        UIButton *aButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, HEIGHT*0.06, HEIGHT*0.06)];
        [aButton setImage:[UIImage imageNamed:imgNameArray[i]] forState:UIControlStateNormal];
        aButton.backgroundColor = [UIColor orangeColor];
        aButton.userInteractionEnabled = NO;
        UIView *aView = [uiviewArray objectAtIndex:i];
        [aView addSubview:aButton];
        [buttonArray addObject:aButton];
    }
    NSMutableArray *textFieldArray = [NSMutableArray array];
    for (int i = 0; i<6; i++) {
        UIView *aView = [uiviewArray objectAtIndex:i];
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(WIDTH*0.107, 0, aView.frame.size.width-WIDTH*0.107, HEIGHT*0.06)];
        textField.placeholder = nameArray[i];
        NSAttributedString *placeholderString = [[NSAttributedString alloc] initWithString:nameArray[i] attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:HEIGHT*0.022],NSFontAttributeName, [NSNumber numberWithDouble:-0.001*HEIGHT],NSBaselineOffsetAttributeName, nil]];
        textField.attributedPlaceholder = placeholderString;
        textField.keyboardType=UIKeyboardTypeDefault;
        textField.clearButtonMode = UITextFieldViewModeAlways;
        [aView addSubview:textField];
        [textFieldArray addObject:textField];
    }
    _userNameTxt = (UITextField *)[textFieldArray objectAtIndex:0];
    _userNameTxt.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _nickName = (UITextField *)[textFieldArray objectAtIndex:1];
    _nickName.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _pwdTxt = (UITextField *)[textFieldArray objectAtIndex:2];
    _pwdTxt.secureTextEntry = YES;
    _surePwdTxt = (UITextField *)[textFieldArray objectAtIndex:3];
    _surePwdTxt.secureTextEntry = YES;
    _phoneNumber = (UITextField *)[textFieldArray objectAtIndex:4];
    _phoneNumber.keyboardType = UIKeyboardTypeNumberPad;
    _authCode = (UITextField *)[textFieldArray objectAtIndex:5];
    _authCode.keyboardType = UIKeyboardTypeNumberPad;
    //------ 获取验证码 ------
    _getAuthCodeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    UIView *authCodeView = (UIView *)[uiviewArray objectAtIndex:5];
    _getAuthCodeBtn.frame = CGRectMake(CGRectGetMaxX(authCodeView.frame)+1, CGRectGetMinY(authCodeView.frame)+HEIGHT*0.021, WIDTH*0.16+WIDTH*0.053, HEIGHT*0.037);
    [_getAuthCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_getAuthCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _getAuthCodeBtn.titleLabel.font = [UIFont systemFontOfSize:HEIGHT*0.02];
    [_getAuthCodeBtn.layer setCornerRadius:2.0]; //设置矩形四个圆角半径
    [_getAuthCodeBtn.layer setMasksToBounds:YES];
    _getAuthCodeBtn.backgroundColor=[UIColor orangeColor];
    _getAuthCodeBtn.enabled=YES;
    [_getAuthCodeBtn addTarget:self action:@selector(getAuthCodeClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_getAuthCodeBtn];
    //------  注册按钮 ------
    _registBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _registBtn.frame = CGRectMake(0.107*WIDTH, CGRectGetMaxY(authCodeView.frame)+HEIGHT*0.042, WIDTH-WIDTH*0.214, 0.06*HEIGHT);
    [_registBtn setTitle:@"立即注册" forState:UIControlStateNormal];
    [_registBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_registBtn.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    [_registBtn.layer setMasksToBounds:YES];
    _registBtn.backgroundColor=[UIColor orangeColor];
    _registBtn.enabled=YES;
    [_registBtn addTarget:self action:@selector(registClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_registBtn];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    //监听键盘高度，用来自适应键盘弹出与消失
    [LQQMonitorKeyboard LQQAddMonitorWithShowBack:^(NSInteger height) {
        [UIView animateWithDuration:1 animations:^{//键盘弹出
            if (HEIGHT > 568.00) {//判断屏幕尺寸进行调整
                topImageView.frame = CGRectMake((WIDTH-0.32*WIDTH)/2, HEIGHT-HEIGHT*0.0675*7.5-height, WIDTH*0.321, 0.06*HEIGHT);
            }else{
                topImageView.frame = CGRectMake((WIDTH-0.32*WIDTH)/2, HEIGHT-HEIGHT*0.0675*7.1-height, WIDTH*0.321, 0.06*HEIGHT);
            }
            for (int i = 0; i<5; i++) {
                UIView *v = (UIView *)[uiviewArray objectAtIndex:i];
                v.frame = CGRectMake(WIDTH*0.107, HEIGHT-HEIGHT*0.0675*(6-i)-height, WIDTH-WIDTH*0.214, 0.06*HEIGHT);
            }
            authCodeView.frame = CGRectMake(WIDTH*0.107, HEIGHT-HEIGHT*0.0675-height, WIDTH-WIDTH*(0.16+0.213)-WIDTH*0.053, 0.06*HEIGHT);
            _getAuthCodeBtn.frame = CGRectMake(CGRectGetMaxX(authCodeView.frame)+1, CGRectGetMinY(authCodeView.frame)+HEIGHT*0.021, WIDTH*0.16+WIDTH*0.053, HEIGHT*0.037);
            _registBtn.frame = CGRectMake(0.107*WIDTH, CGRectGetMaxY(authCodeView.frame)+HEIGHT*0.042, WIDTH-WIDTH*0.214, 0.06*HEIGHT);
        }];
    } andDismissBlock:^(NSInteger height) {//键盘退出
        [UIView animateWithDuration:2 animations:^{
            topImageView.frame = CGRectMake((WIDTH-0.32*WIDTH)/2, 0.159*HEIGHT-HEIGHT*0.096, WIDTH*0.321, 0.06*HEIGHT);
            userView.frame = CGRectMake(WIDTH*0.107, CGRectGetMaxY(topImageView.frame)+HEIGHT*0.045, WIDTH-WIDTH*0.214, 0.06*HEIGHT);
            for (int i = 1; i <5; i++) {
                UIView *preV = (UIView *)[uiviewArray objectAtIndex:i-1];
                UIView *v = (UIView *)[uiviewArray objectAtIndex:i];
                v.frame = CGRectMake(WIDTH*0.107, CGRectGetMaxY(preV.frame)+5, WIDTH-WIDTH*0.214, 0.06*HEIGHT);
            }
            UIView *phoneNumberView = (UIView *)[uiviewArray objectAtIndex:4];
            authCodeView.frame = CGRectMake(WIDTH*0.107, CGRectGetMaxY(phoneNumberView.frame)+5, WIDTH-WIDTH*(0.16+0.213)-WIDTH*0.053, 0.06*HEIGHT);
            _getAuthCodeBtn.frame = CGRectMake(CGRectGetMaxX(authCodeView.frame)+1, CGRectGetMinY(authCodeView.frame)+HEIGHT*0.021, WIDTH*0.16+WIDTH*0.053, HEIGHT*0.037);
            _registBtn.frame = CGRectMake(0.107*WIDTH, CGRectGetMaxY(authCodeView.frame)+HEIGHT*0.042, WIDTH-WIDTH*0.214, 0.06*HEIGHT);
        }];
    }];
}
#pragma mark 收起键盘
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [_userNameTxt resignFirstResponder];
    [_nickName resignFirstResponder];
    [_pwdTxt resignFirstResponder];
    [_surePwdTxt resignFirstResponder];
    [_phoneNumber resignFirstResponder];
    [_authCode resignFirstResponder];
}
#pragma mark 获取验证码按钮事件
-(void)getAuthCodeClick:(UIButton*)sender{
    //设置倒计时总时长
    _secondsCountDown = 30;//60秒倒计时http://175.102.13.51:8080/XDSY/HTGetCode?mob=%@
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"http://175.102.13.51:8080/XDSY/HTGetCode?mob=%@",_phoneNumber.text]];
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
#pragma mark 注册按钮事件
-(void)registClick:(UIButton*)sender{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"http://175.102.13.51:8080/XDSY/HTUser?type=reg&username=%@&nickname=%@&pwd=%@&mobile=%@&code=%@&cb=1",_userNameTxt.text,_nickName.text,_pwdTxt.text,_phoneNumber.text,_authCode.text]];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
            NSString *msgstr = jsonObject[@"msg"];
            NSString *codestr = jsonObject[@"code"];
            if (![@"1" isEqualToString:codestr]) {//注册失败
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
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end