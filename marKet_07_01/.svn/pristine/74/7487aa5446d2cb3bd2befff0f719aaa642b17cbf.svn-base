//
//  MoreVarietiesViewController.m
//  Market
//
//  Created by Secret Wang on 16/3/7.
//  Copyright © 2016年 dayu. All rights reserved.
//

#import "MoreVarietiesViewController.h"
#import "VarietiesView.h"
#import "ItemTableViewCell.h"
#import "BaseNavigation.h"
#import "BrokenLineViewController.h"
#import "AFNetworking.h"
#define ADD @"++"
#define SUB @"--"
#define SIZE [[UIScreen mainScreen] bounds].size
#define GLODENCOLOR [UIColor colorWithRed:186/255.0 green:128/255.0 blue:15/255.0 alpha:1.0]
#define LINEWIDTH 90
#define URL @""
@interface MoreVarietiesViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UISegmentedControl* segment;
    NSMutableArray* _nameInternational;//行情名字
    UIScrollView* _scroll;//创建名字scroll
    UIView* _lineView;//nameButton下面的下划线
    UITableView* _tableView;
    NSMutableArray* _dataArray;
}
@end

@implementation MoreVarietiesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    [BaseNavigation loadUIViewController:self title:nil navigationBarBgColor:[UIColor blackColor] backSelector:@selector(popDiyView)];
    NSInteger i = 0;
    _dataArray = [[NSMutableArray alloc]init];
    [self createUI];
    [self createScrollView];
    [self createNameButtonData:i];
}
#pragma mark ****** 最新行情的数据请求
-(void)requestDate:(NSString*)sender{
    NSDictionary* param = [[NSDictionary alloc]initWithObjectsAndKeys:@"",sender, nil];
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    [manager GET:URL parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [_dataArray removeAllObjects];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

-(void)createNameButtonData:(NSInteger)sender{
    if (sender==0) {
        _nameInternational = [[NSMutableArray alloc]initWithObjects:@"NAXT",@"IPE",@"外汇",@"国际黄金",@"原油", nil];
    }else if(sender==1){
        _nameInternational = [[NSMutableArray alloc]initWithObjects:@"qqqqqqq",@"wwwww",@"eeeeee",@"rrrrrr黄金",@"ttttt", @"yyyyyy",@"uuuuuu",nil];
    }
    for (int i=0; i<_nameInternational.count; i++) {
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn.frame = CGRectMake(i*LINEWIDTH, 2, LINEWIDTH, 40);
        [btn setTitle:_nameInternational[i] forState:UIControlStateNormal];
        [btn setTintColor:[UIColor colorWithRed:0.73 green:0.5 blue:0.05 alpha:1]];
        btn.tag = 100+i;
        [btn addTarget:self action:@selector(nameButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_scroll addSubview:btn];
    }
    CGRect frame = _lineView.frame;
    frame.origin.x = 0;
    _lineView.frame = frame;
    _scroll.contentSize = CGSizeMake(_nameInternational.count*LINEWIDTH, 0);
}
-(void)nameButtonClick:(UIButton*)sender{
    NSInteger index = sender.tag-100;
    CGRect frame = _lineView.frame;
    frame.origin.x = LINEWIDTH*index;
    _lineView.frame = frame;
    
    UIButton* btn = (UIButton*)[self.view viewWithTag:sender.tag];
    [self requestDate:btn.titleLabel.text];
}
#pragma mark ****** 创建名字scroll
-(void)createScrollView{
    _scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SIZE.width, 44)];
    _scroll.backgroundColor = [UIColor colorWithRed:0.9 green:0.89 blue:0.88 alpha:1];
    _scroll.delegate = self;
    _scroll.tag = 50;
    _scroll.showsHorizontalScrollIndicator = NO;
    _scroll.pagingEnabled = NO;
    [self.view addSubview:_scroll];
    _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, _scroll.frame.size.height-2, LINEWIDTH, 2)];
    _lineView.backgroundColor = [UIColor colorWithRed:0.73 green:0.51 blue:0.05 alpha:1];
    [_scroll addSubview:_lineView];
    
    NSArray* arr = [[NSArray alloc]initWithObjects:@"品种",@"最新",@"涨跌", nil];
    for (int i=0; i<arr.count; i++) {
        UILabel* lable = [[UILabel alloc]initWithFrame:CGRectMake(SIZE.width/3*i, CGRectGetMaxY(_scroll.frame), SIZE.width/3, 40)];
        [self.view addSubview:lable];
        [lable setText:arr[i]];
        lable.textColor = [UIColor whiteColor];
        lable.backgroundColor = [UIColor blackColor];
        lable.textAlignment = NSTextAlignmentCenter;
    }
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_scroll.frame)+40, SIZE.width, SIZE.height-CGRectGetMaxY(_scroll.frame)-64-40) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor blackColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
}
#pragma mark ****** tableView的代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* cellId = @"cell";
    ItemTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId ];
    if (!cell) {
        cell = [[ItemTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = [UIColor grayColor];
    }
    if (_dataArray.count>0) {
        MoreDetailModel* model = _dataArray[indexPath.row];
        [cell configData:model];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BrokenLineViewController* vc = [[BrokenLineViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;}
}
#pragma mark ****** 返回按钮点击
-(void)popDiyView{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark ****** 创建segment
-(void)createUI{
    NSArray* segArray = @[@"国际行情",@"国内行情"];
    segment = [[UISegmentedControl alloc]initWithItems:segArray];
    segment.frame = CGRectMake(0, 0, 120, 25);
    [segment addTarget:self action:@selector(segmentClick:) forControlEvents:UIControlEventValueChanged];
    segment.selectedSegmentIndex = 0;
    segment.backgroundColor = [UIColor blackColor];;
    segment.tintColor = GLODENCOLOR;
    segment.layer.borderColor = GLODENCOLOR.CGColor;
    self.navigationItem.titleView = segment;
    NSDictionary* dict = [[NSDictionary alloc]initWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, [UIFont systemFontOfSize:12.0f],NSFontAttributeName,nil];
    [segment setTitleTextAttributes:dict forState:UIControlStateNormal];
    [segment setTitleTextAttributes:dict forState:UIControlStateSelected];
}
-(void)segmentClick:(UISegmentedControl*)sender {
    _scroll.contentOffset = CGPointMake(0, 0);
    NSInteger index = sender.selectedSegmentIndex;
    switch (index) {
        case 0:
        {
            UIScrollView* scroll = (UIScrollView*)[self.view viewWithTag:50];
            for (UIButton* btn  in scroll.subviews) {
                if ([btn isKindOfClass:[UIButton class]]) {
                    [btn removeFromSuperview];
                }
            }
            [self createNameButtonData:index];
        }
            break;
        case 1:
        {
            UIScrollView* scroll = (UIScrollView*)[self.view viewWithTag:50];
            for (UIButton* btn  in scroll.subviews) {
                if ([btn isKindOfClass:[UIButton class]]) {
                    [btn removeFromSuperview];
                }            }
            [self createNameButtonData:index];
        }
            break;
        default:
            break;
    }
}
@end