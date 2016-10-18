//
//  XiDuNewsViewController.m
//  MarKet
//
//  Created by Aaron Lee on 16/4/18.
//  Copyright © 2016年 Secret. All rights reserved.
//

#import "XiDuNewsViewController.h"
#import "AFNetworking.h"
#import "XiDuNewsCell.h"
#import "BaseTableView.h"
#import "XiDuNewsDetailViewController.h"
#define WIDTH CGRectGetWidth([UIScreen mainScreen].bounds)
#define HEIGHT CGRectGetHeight([UIScreen mainScreen].bounds)
#define URL @"http://175.102.13.51:8080/XDSY/ZhuBan"
@interface XiDuNewsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) UIRefreshControl *reFresh;//下拉刷新控件
@property (strong,nonatomic) UIActivityIndicatorView *activity;//加载刷新控件
@property (strong,nonatomic) NSMutableArray* dataSourceArray;//数据集合
@property (strong,nonatomic) BaseTableView *tableView;//表格
@property (nonatomic) NSInteger page;//加载页面数
@end

@implementation XiDuNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"西都新闻";
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"root_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(backBtnClick)];
    //刷新控件
    _activity = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];//刷新控件
    [_activity setCenter:self.view.center];//指定进度轮中心点
    [_activity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];//设置进度轮显示类型
    [self.view addSubview:_activity];
    _page=1;
    _dataSourceArray =[[NSMutableArray alloc]init];
    [self createTableView];
}
#pragma mark 请求网络
- (void)refreshStateChangeisUpToGetMore:(BOOL)isUp{
    if (isUp==YES) {
        _page++;
    }
    else _page=1;
    NSDictionary* parameters = [[NSDictionary alloc]initWithObjectsAndKeys:
                                @".guanwang",@"type",
                                @"gonggao",@"defference",
                                [NSString stringWithFormat:@"%ld",(long)_page],@"indexPage",
                                nil];
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    [manager GET:URL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString* i = responseObject[@"flag"];
        if ([i intValue] == 1) {
            if (isUp==YES) {}else [_dataSourceArray removeAllObjects];
            NSArray *data=[responseObject objectForKey:@"data"];
            for (int i=0;i<data.count;i++) {
                XiDuNewsModel *model=[[XiDuNewsModel alloc]init];
                model.Senddate=data[i][@"Senddate"];
                model.Title=data[i][@"Title"];
                model.Keywords=data[i][@"Keywords"];
                model.Id=data[i][@"Id"];
               [_dataSourceArray addObject:model];
    }
        }
        [_tableView reloadData];
        [_tableView endrefresh];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [_tableView endrefresh];
    }];
}

#pragma mark 初始化表格
- (void)createTableView{
    _tableView=[[BaseTableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-64) style:UITableViewStylePlain];
    _tableView.backgroundColor=[UIColor colorWithRed:243/255.0 green:244/255.0 blue:245/255.0 alpha:1.0];
    _tableView.delegate=self; 
    _tableView.dataSource=self;
    _tableView.bounces=YES;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.separatorColor=[UIColor grayColor];
    [_tableView setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:_tableView];
    __weak XiDuNewsViewController *blockSelf=self;
    [_tableView setRequestData:^{
        [blockSelf refreshStateChangeisUpToGetMore:NO];
    }];
    //------ 防止block循环引用 ------
    [_tableView setUpToLoadMore:^{
        [blockSelf refreshStateChangeisUpToGetMore:YES];
    }];
}
#pragma mark -返回按钮点击
- (void)backBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark tableView的代理返回cell高度和个数
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_dataSourceArray.count>0) {
        return _dataSourceArray.count;
    }else
        return 7;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
#pragma mark tableView的代理方法
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* cellId = @"cell";
    XiDuNewsCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell==nil) {
        cell=[[XiDuNewsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    if (_dataSourceArray.count>0) {
        XiDuNewsModel *model=_dataSourceArray[indexPath.row];
        [cell Refresh:model];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_dataSourceArray.count>0) {
        XiDuNewsModel *model=_dataSourceArray[indexPath.row];
        [[NSUserDefaults standardUserDefaults]setObject:model.Id forKey:@"id"];
        [self.navigationController pushViewController:[[XiDuNewsDetailViewController alloc]init] animated:YES];
    }
}
@end
