//
//  ProfessorTeamViewController.m
//  MarKet
//
//  Created by Aaron Lee on 16/5/16.
//  Copyright © 2016年 Secret. All rights reserved.
//

#import "ProfessorTeamViewController.h"
#define WIDTH CGRectGetWidth([UIScreen mainScreen].bounds)
#define HEIGHT CGRectGetHeight([UIScreen mainScreen].bounds)
@interface ProfessorTeamViewController ()<UIScrollViewDelegate>
@property (strong,nonatomic) UIPageControl *pageControl;//引导页码
@property (strong,nonatomic) UIScrollView *scrollView;//滚动视图
@property (strong,nonatomic) NSArray *headImgArr;//正常图像数组
@property (strong,nonatomic) NSArray *selectedImgArr;//选中图像数组
@property (strong,nonatomic) UIImageView *imageView;//详细视图
@property (strong,nonatomic) NSArray *briefArr;//简介数组
@property (strong,nonatomic) UIButton *Btn;
@property (strong,nonatomic) UIButton *starBtn;//选中按钮
@property (strong,nonatomic) NSMutableArray *btnMutableArray;//button存放数组
@end

@implementation ProfessorTeamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title=@"名师团队";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"root_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(backBtnClick)];
    //初始化滚动视图
    [self initScrollView];
    //初始化详细视图
    [self initImageView];
}
#pragma mark 初始化顶部滚动视图
- (void)initScrollView{
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, WIDTH/5+50)];
    [_scrollView setContentSize:CGSizeMake(WIDTH*2, WIDTH/5-10)];
    [_scrollView setPagingEnabled:YES];//视图整页显示
    [_scrollView setDelegate:self];
    [_scrollView setBackgroundColor:[UIColor whiteColor]];
    [_scrollView setBounces:NO]; //避免弹跳效果
    [_scrollView setShowsHorizontalScrollIndicator:NO];
    [_scrollView setShowsVerticalScrollIndicator:NO];
    _scrollView.delaysContentTouches=NO;//scrollview监听touch和移动,让他先响应touch
    [self.view addSubview:_scrollView];
    _btnMutableArray=[[NSMutableArray alloc]init];
    _headImgArr=[NSArray arrayWithObjects:@"韩云头像",@"李教授头像",@"鲁教授头像", @"张教授头像",@"朱达头像",@"刘小鹏头像",@"卢成贤头像",nil];
    _selectedImgArr=[NSArray arrayWithObjects:@"韩云头像-1",@"李教授头像-1",@"鲁教授头像-1", @"张教授头像-1",@"朱达头像-1",@"刘小鹏头像-1",@"卢成贤头像-1",nil];
    //------ 创建按钮 ------
    for (int i=0; i<7; i++) {
        _Btn=[UIButton buttonWithType:UIButtonTypeCustom];
        _Btn.frame=CGRectMake(WIDTH*i/5+10, 10, WIDTH/5-20, WIDTH/5-5);
        _Btn.tag=i;
        [_Btn setBackgroundColor:[UIColor whiteColor]];
        [_Btn setBackgroundImage:[UIImage imageNamed:_headImgArr[i]] forState:UIControlStateNormal];
        [_Btn setBackgroundImage:[UIImage imageNamed:_selectedImgArr[i]] forState:UIControlStateSelected];
        [_Btn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:_Btn];
        [_btnMutableArray addObject:_Btn];
    }
     ((UIButton *)[_btnMutableArray objectAtIndex:0]).selected=YES;  //设置数组的第一个button为选中状态
    //------ 引导页码 ------
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, WIDTH/5+20, WIDTH, 10)];
    [_pageControl setNumberOfPages:2];
    [_pageControl setCurrentPageIndicatorTintColor:[UIColor colorWithRed:251/255.0 green:158/255.0 blue:53/255.0 alpha:1.0]];
    [_pageControl setPageIndicatorTintColor:[UIColor colorWithRed:178/255.0 green:178/255.0 blue:178/255.0 alpha:1.0]];
    [self.view addSubview:_pageControl];

}
#pragma mark -返回按钮点击
- (void)backBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark  按钮点击事件
- (void)BtnClick:(UIButton *)sender{
    ((UIButton *)[_btnMutableArray objectAtIndex:0]).selected=NO; //点击其他button之后这里设置为非选中状态，否则会出现2个颜色的选中状态
   _imageView.image=[UIImage imageNamed:_briefArr[sender.tag]];
    if (sender != _starBtn) {
        _starBtn.selected=NO;
        _starBtn=sender;
    }
        _starBtn.selected=YES;
}
#pragma mark 初始化详细视图
- (void)initImageView{
    _imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_scrollView.frame)+10, WIDTH, HEIGHT-64-_scrollView.frame.size.height-30)];
    _briefArr=[NSArray arrayWithObjects:@"韩云-简介",@"李教授简介",@"鲁教授简介", @"张教授简介",@"朱达简介",@"刘小鹏简介",@"卢成贤简介", nil];
    _imageView.image=[UIImage imageNamed:_briefArr[0]];
    [self.view addSubview:_imageView];

}
#pragma mark 引导视图滑动结束事件
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [_pageControl setCurrentPage:_scrollView.contentOffset.x/WIDTH];
}


@end
