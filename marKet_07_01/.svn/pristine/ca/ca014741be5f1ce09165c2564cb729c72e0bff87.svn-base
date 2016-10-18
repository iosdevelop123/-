//
//  BrokenLineViewController.m
//  MarKet
//
//  Created by Secret Wang on 16/3/21.
//  Copyright © 2016年 Secret. All rights reserved.
//

#import "BrokenLineViewController.h"
#import "BaseNavigation.h"
#import "DaysDetailController.h"

#import "TimeShareViewController.h"
#import "KLineViewController.h"
#import "NewsViewController.h"

#define SIZE [UIScreen mainScreen].bounds.size
#define GLODENCOLOR [UIColor colorWithRed:186/255.0 green:128/255.0 blue:15/255.0 alpha:1.0]
@interface BrokenLineViewController ()
{
    UIPageViewController*_pageViewController;
    NSMutableArray* _vcArray;
    UISegmentedControl* _segment;
    NSInteger _pageCurrent;
}
@end

@implementation BrokenLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [BaseNavigation loadUIViewController:self title:nil navigationBarBgColor:[UIColor blackColor] backSelector:@selector(popToView)];
    [self createSegment];
    [self createViewController];
    [self createPageViewConteoller];
}
#pragma mark ****** 返回上一页
-(void)popToView{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark ****** segment
-(void)createSegment{
    NSArray* segmentArray = @[@"分时",@"K线",@"新闻"];
    _segment = [[UISegmentedControl alloc]initWithItems:segmentArray];
    _segment.frame = CGRectMake(0, 0, 180,25);
    _segment.selectedSegmentIndex = 0;
    _segment.backgroundColor = [UIColor blackColor];;
    _segment.tintColor = GLODENCOLOR;
    _segment.layer.borderColor = GLODENCOLOR.CGColor;
    [_segment addTarget:self action:@selector(segmentClick:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = _segment;
    NSDictionary* dict = [[NSDictionary alloc]initWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, [UIFont systemFontOfSize:12.0f],NSFontAttributeName,nil];
    [_segment setTitleTextAttributes:dict forState:UIControlStateNormal];
    [_segment setTitleTextAttributes:dict forState:UIControlStateSelected];
}
#pragma mark ****** segment点击
-(void)segmentClick:(UISegmentedControl*)sender{
    NSInteger index = sender.selectedSegmentIndex ;
    [_pageViewController setViewControllers:@[(UIViewController *)_vcArray[index]] direction:index<_pageCurrent animated:YES completion:nil];
    _pageCurrent = index;
}
#pragma mark ******
-(void)createViewController{
    TimeShareViewController* vc1 = [[TimeShareViewController alloc]init];
    KLineViewController* vc2 = [[KLineViewController alloc]init];
    NewsViewController* vc3 = [[NewsViewController alloc]init];
    
    [vc3 setCallBackToMainView:^{
        DaysDetailController* vc = [[DaysDetailController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    _vcArray = [[NSMutableArray alloc]initWithObjects:vc1,vc2,vc3, nil];
}
#pragma mark ****** 创建pageViewController
-(void)createPageViewConteoller{
    _pageViewController =[[ UIPageViewController alloc]initWithTransitionStyle:1 navigationOrientation:0 options:nil];
    [_pageViewController setViewControllers:@[_vcArray[0]] direction:1 animated:YES completion:nil];
    [self.view addSubview:_pageViewController.view];
    _pageViewController.dataSource = self;
    _pageViewController.delegate = self;
}
#pragma mark ****** pageViewController的代理方法
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end