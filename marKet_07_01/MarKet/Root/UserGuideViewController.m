//
//  UserGuideViewController.m
//  MarKet
//
//  Created by dayu on 16/4/6.
//  Copyright © 2016年 Secret. All rights reserved.
//
#import "UserGuideViewController.h"
#import "MainTabBarController.h"
#define WIDTH CGRectGetWidth([UIScreen mainScreen].bounds)
#define HEIGHT CGRectGetHeight([UIScreen mainScreen].bounds)
@interface UserGuideViewController ()<UIScrollViewDelegate>

@property (strong,nonatomic) UIPageControl *pageControl;//引导页码
@property (strong,nonatomic) UIScrollView *scrollView;//引导视图

@end

@implementation UserGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *launchImageArray = @[@"GuideImage1_%dh.png",@"GuideImage2_%dh.png",@"GuideImage3_%dh.png"];
    //------ 加载新用户引导页面 ------
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    [_scrollView setContentSize:CGSizeMake(WIDTH*3, HEIGHT)];
    [_scrollView setPagingEnabled:YES];  //视图整页显示
    [_scrollView setDelegate:self];
    [_scrollView setBounces:NO]; //避免弹跳效果
    [_scrollView setShowsHorizontalScrollIndicator:NO];
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    [imageview setImage:[UIImage imageNamed:[NSString stringWithFormat:launchImageArray[0],(NSInteger)HEIGHT]]];
    [_scrollView addSubview:imageview];
    
    UIImageView *imageview1 = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH, 0, WIDTH, HEIGHT)];
    [imageview1 setImage:[UIImage imageNamed:[NSString stringWithFormat:launchImageArray[1],(NSInteger)HEIGHT]]];
    [_scrollView addSubview:imageview1];
    
    UIImageView *imageview2 = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH*2, 0, WIDTH, HEIGHT)];
    [imageview2 setImage:[UIImage imageNamed:[NSString stringWithFormat:launchImageArray[2],(NSInteger)HEIGHT]]];
    imageview2.userInteractionEnabled = YES;    //打开imageview3的用户交互;否则下面的button无法响应
    [_scrollView addSubview:imageview2];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];//在imageview3上加载一个透明的button
    [button setTitle:@"立即开启 24小时解盘" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor colorWithRed:230/255.0 green:159/255.0 blue:115/255.0 alpha:1.0];
    button.frame = CGRectMake(WIDTH*0.5-95, HEIGHT-132, 190, 36);
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 18.0;
    button.layer.borderColor = [UIColor colorWithRed:241/255.0 green:122/255.0 blue:68/255.0 alpha:1.0].CGColor;
    button.layer.borderWidth = 2.0;
    [button addTarget:self action:@selector(firstPressed) forControlEvents:UIControlEventTouchUpInside];
    [imageview2 addSubview:button];
    [self.view addSubview:_scrollView];
    
    //------ 引导页码 ------
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, HEIGHT - 80, WIDTH, 10)];
    [_pageControl setNumberOfPages:3];
    [_pageControl setCurrentPageIndicatorTintColor:[UIColor colorWithRed:241/255.0 green:122/255.0 blue:68/255.0 alpha:1.0]];
    [_pageControl setPageIndicatorTintColor:[UIColor colorWithRed:241/255.0 green:197/255.0 blue:172/255.0 alpha:1.0]];
    [_pageControl addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_pageControl];
}

#pragma mark 引导视图滑动结束事件
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [_pageControl setCurrentPage:_scrollView.contentOffset.x/WIDTH];
}

#pragma mark 跳转根视图
- (void)firstPressed{
    MainTabBarController *mainVC = [[MainTabBarController alloc] init];
    [self presentViewController:mainVC animated:YES completion:nil];  //点击button跳转到根视图
}

#pragma mark 点击引导页码切换引导页
- (void)valueChange:(UIPageControl *)sender{
    [_scrollView setContentOffset:CGPointMake(sender.currentPage*WIDTH, 0) animated:YES];
}

@end