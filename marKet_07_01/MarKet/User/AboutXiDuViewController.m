//
//  AboutXiDuViewController.m
//  MarKet
//
//  Created by Aaron Lee on 16/3/16.
//  Copyright © 2016年 Secret. All rights reserved.
//

#import "AboutXiDuViewController.h"
#import "AboutXiDuTableViewCell.h"
#import "XiDuNewsViewController.h"
#import "ExchangeInfoViewController.h"
#import "XiDuInfoViewController.h"
#import "ContactUsViewController.h"
#import "BasePushViewController.h"
#define WIDTH CGRectGetWidth([UIScreen mainScreen].bounds)
#define HEIGHT CGRectGetHeight([UIScreen mainScreen].bounds)
@interface AboutXiDuViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong,nonatomic) UIImageView *bannerView;
@property (strong,nonatomic) UITableView *tableView;
@end

@implementation AboutXiDuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
    self.navigationItem.title=@"关于西都石油";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"root_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(backBtnClick)];
    [self loadUI];
    [self createTabelview];
}
#pragma mark -加载视图
- (void)loadUI{
    _bannerView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 0.36*HEIGHT)];
    _bannerView.image=[UIImage imageNamed:@"banner"];
    [self.view addSubview:_bannerView];
}

#pragma mark -返回按钮点击
- (void)backBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -创建tableview
- (void)createTabelview{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_bannerView.frame)+10, WIDTH, 200)];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.bounces=YES;
    _tableView.separatorColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    _tableView.separatorInset = UIEdgeInsetsMake(0, 10, 0, 10);
    _tableView.scrollEnabled=NO;//设置tableview 不能滚动
    [_tableView setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:_tableView];
}

#pragma mark tableView的代理返回cell高度和个数
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
#pragma mark tableView的代理方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* cellId = @"cell";
    AboutXiDuTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell==nil) {
        cell=[[AboutXiDuTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    NSArray *titleArr=[[NSArray alloc]initWithObjects:@"交易所简介",@"西都简介",@"西都新闻",@"联系我们",nil];
    cell.TitleLabel.text=titleArr[indexPath.row];
    NSArray *imageArr=[[NSArray alloc]initWithObjects:@"交易所图标",@"西都简介图标",@"新闻图标",@"联系我们图标", nil];
    cell.IconImgv.image=[UIImage imageNamed:imageArr[indexPath.row]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        [BasePushViewController customPushViewController:self.navigationController WithTargetViewController:[[ExchangeInfoViewController alloc] init]];
    }else if (indexPath.row==1){
        [BasePushViewController customPushViewController:self.navigationController WithTargetViewController:[[XiDuInfoViewController alloc] init]];
    }else if (indexPath.row==2){
        [BasePushViewController customPushViewController:self.navigationController WithTargetViewController:[[XiDuNewsViewController alloc] init]];
    }else if (indexPath.row==3){
        [BasePushViewController customPushViewController:self.navigationController WithTargetViewController:[[ContactUsViewController alloc] init]];
    }
}

@end