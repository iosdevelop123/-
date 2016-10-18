//
//  PwdChangeViewController.m
//  MarKet
//
//  Created by Aaron Lee on 16/3/16.
//  Copyright © 2016年 Secret. All rights reserved.
//

#import "PwdChangeViewController.h"
#define ORANGERCOLOR [UIColor colorWithRed:254/255.0 green:159/255.0 blue:33/255.0 alpha:1]
#define HEIGHT self.view.bounds.size.height
#define WIDTH self.view.bounds.size.width
@interface PwdChangeViewController ()<UITextFieldDelegate>
@property (strong,nonatomic) UITextField *Txt;//文本框
@property (strong,nonatomic) UIButton *saveBtn;//保存按钮
@property (strong,nonatomic) NSMutableArray *array;
@end

@implementation PwdChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title=@"修改密码";
    [self initNavigationBar];//初始化导航栏
}
#pragma mark 初始化导航栏
- (void)initNavigationBar{
    //------ 初始化安全开户和个人中心按钮 ------
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"root_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(backBtnClick)];
    //------ 更新视图 ------
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:18.0],NSFontAttributeName, nil];
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    _array = [NSMutableArray array];
    [self loadUI];
}

#pragma mark 更新视图
- (void)loadUI{
    NSArray *texts = [NSArray arrayWithObjects:@"  旧密码",@"  新密码",@"  重复新密码",nil];
    for (NSInteger i=0; i<3; i++) {
        UIView *userView = [[UIView alloc]initWithFrame:CGRectMake(WIDTH*0.107, 30+i*(HEIGHT*0.075), WIDTH-WIDTH*0.214, HEIGHT*0.06)];
        userView.backgroundColor = [UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1.0];
        userView.layer.cornerRadius = 5;
        userView.layer.masksToBounds = YES;
        [self.view addSubview:userView];
        
        UIButton *userButton = [UIButton buttonWithType:UIButtonTypeCustom];
        userButton.frame =CGRectMake(0, 0, HEIGHT*0.06, HEIGHT*0.06);
        [userButton setImage:[UIImage imageNamed:@"密码"] forState:UIControlStateNormal];
        userButton.backgroundColor = [UIColor orangeColor];
        userButton.userInteractionEnabled = NO;
        [userView addSubview:userButton];
        
        UITextField *TxtField = [[UITextField alloc] initWithFrame:CGRectMake(WIDTH*0.107, 0, userView.frame.size.width-WIDTH*0.107, HEIGHT*0.06)];
        NSAttributedString *placeholderString = [[NSAttributedString alloc] initWithString:texts[i] attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:HEIGHT*0.022],NSFontAttributeName, [NSNumber numberWithDouble:-0.001*HEIGHT],NSBaselineOffsetAttributeName, nil]];
        TxtField.attributedPlaceholder = placeholderString;
        TxtField.clearButtonMode = UITextFieldViewModeAlways;
        TxtField.keyboardType=UIKeyboardTypeDefault;
        TxtField.tag = 999+i;
        [_array addObject:TxtField];
        [userView addSubview:TxtField];
    }
    //------ 保存按钮 ------
    _saveBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _saveBtn.frame = CGRectMake(0.107*WIDTH, HEIGHT*0.28, 0.786*WIDTH, 0.06*HEIGHT);
    [_saveBtn setTitle:@"保存新密码" forState:UIControlStateNormal];
    [_saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_saveBtn.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    [_saveBtn.layer setMasksToBounds:YES];
    _saveBtn.backgroundColor=[UIColor orangeColor];
    _saveBtn.enabled=NO;
    [self.view addSubview:_saveBtn];
    //点击空白收起键盘
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];
}
#pragma mark -返回按钮点击
- (void)backBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    for (NSInteger i=0 ; i<2; i++) {
        [_array[i] resignFirstResponder];
    }
}
#pragma mark ****** 按return时调用
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
@end