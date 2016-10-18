//
//  HandanViewController.m
//  MarKet
//
//  Created by Secret Wang on 16/5/6.
//  Copyright © 2016年 Secret. All rights reserved.
//

#import "HandanViewController.h"
#import "BaseNavigation.h"
#import "AFNetworking.h"
#import "HandanTableViewCell.h"
#import "HandanModel.h"
#import "BaseTableView.h"

#define URL @"http://175.102.13.51:8080/XDSY/ZhuBan"
#define SIZE [[UIScreen mainScreen] bounds].size
@interface HandanViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    BaseTableView* _tableView;
    NSMutableArray* _dataArray;
    NSInteger _page;
}
@end

@implementation HandanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [BaseNavigation loadUIViewController:self title:@"喊单记录" navigationBarBgColor:[UIColor blackColor] backSelector:@selector(back)];
    _dataArray = [[NSMutableArray alloc]init];
    //    [self loadData];
    [self createUI];
}
#pragma mark ****** 创建界面
-(void)createUI{
    _tableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 0, SIZE.width, SIZE.height-64)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    __weak HandanViewController* blockSelf = self;
    [_tableView setRequestData:^{
        [blockSelf loadData:NO];
    }];
    [_tableView setUpToLoadMore:^{
        [blockSelf loadData:YES];
    }];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_dataArray.count>0) {
        return _dataArray.count;
    }else
        return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 140;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellId = @"cell";
    HandanTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"HandanTableViewCell" owner:nil options:nil] firstObject];
    }
    if (_dataArray.count>0) {
        HandanModel* model = _dataArray[indexPath.row];
        [cell configModel:model];
    }
    return cell;
}
#pragma mark ****** 数据请求
-(void)loadData:(BOOL)isUp{
    if (isUp==YES)
    { _page++;}
    else _page = 1;
    NSDictionary* parameters = [[NSDictionary alloc]initWithObjectsAndKeys:
                                @".lybzhibo",@"type",
                                @"handan",@"defference",
                                [NSString stringWithFormat:@"%ld",(long)_page],@"indexPage",
                                nil];
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    [manager GET:URL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString* i = responseObject[@"flag"];
        int index = [i intValue];
        if (index==1) {
            NSArray* array = responseObject[@"data"];
            if (isUp==YES) {}else [_dataArray removeAllObjects];
            for (int i=0; i<array.count; i++) {
                HandanModel* model = [[HandanModel alloc]init];
                model.Id = array[i][@"Id"] ;
                model.OpenTime = array[i][@"OpenTime"];
                model.Type = array[i][@"Type"];
                model.Position = array[i][@"Position"];
                model.OpenPrice = array[i][@"OpenPrice"];
                model.StopLossPrice = array[i][@"StopLossPrice"];
                model.StopGainPrice = array[i][@"StopGainPrice"];
                model.GainPercent = array[i][@"GainPercent"];
                model.ClosingPrice = array[i][@"ClosingPrice"];
                model.ClosingTime = array[i][@"ClosingTime"];
                [_dataArray addObject:model];
            }
            if (array.count==0) {
                [self showAlert:@"加载失败..."];
            }
        }else
            [self showAlert:@"加载失败..."];
        [_tableView reloadData];
        [_tableView endrefresh];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [_tableView endrefresh];
        [self showAlert:@"加载失败..."];
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


#pragma mark ****** 返回
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
