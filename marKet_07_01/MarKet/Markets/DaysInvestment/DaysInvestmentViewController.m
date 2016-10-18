//
//  DaysInvestmentViewController.m
//  Market
//
//  Created by Secret Wang on 16/3/7.
//  Copyright © 2016年 dayu. All rights reserved.
//

#import "DaysInvestmentViewController.h"
#import "DaysDetailController.h"
#import "DayInvestmentCell.h"
#import "AFNetworking.h"
#import "BaseTableView.h"


#define SIZE [[UIScreen mainScreen] bounds].size
#define URL @"http://175.102.13.51:8080/XDSY/ZhuBan"

@interface DaysInvestmentViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    BaseTableView* _tableView;
    NSInteger _page;
    NSMutableArray* _dataArray;
}
@end

@implementation DaysInvestmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _dataArray = [[NSMutableArray alloc]init];
    _page = 1;
    [self createTableView];
}
#pragma mark ****** 数据请求
-(void)refreshStateChangeIsUpToMore:(BOOL)is{
    if (is==YES) {_page++;}
    else _page = 1;
    NSDictionary* dic = [[NSDictionary alloc]initWithObjectsAndKeys:
                         @".guanwang",@"type",
                         @"hangqing",@"defference",
                         [NSString stringWithFormat:@"%ld",(long)_page],@"indexPage",
                         nil];
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    [manager GET:URL parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString* i = responseObject[@"flag"];
        int index = [i intValue];
        if (index == 1) {
            NSArray*  array = responseObject[@"data"];
            //------ 判断是否时上拉加载更多，判断是否删除数据数组 ------
            if (is==YES) { }else [_dataArray removeAllObjects];
            for(int i=0;i<array.count;i++){
                DaysInvestmentModel* model = [[DaysInvestmentModel alloc]init];
                model.titleString = array[i][@"Title"];
                NSString* date = array[i][@"Senddate"];
                [self getTimeAndDate:date AndModel:model];
                model.textString = array[i][@"Body"];
                model.IdString = array[i][@"Id"];
                [_dataArray addObject:model];
            }
            if (array.count==0) {
                [self showAlert:@"加载失败..."];
            }}
        else
            [self showAlert:@"加载失败..."];
        [_tableView reloadData];
        [_tableView endrefresh];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [_tableView endrefresh];
        [self showAlert:@"加载失败..."];
    }];
    
}
#pragma mark ****** 截取时间字符串
-(void)getTimeAndDate:(NSString*)string AndModel:(DaysInvestmentModel*)model{
    NSArray* array = [string componentsSeparatedByString:@"  "];
    NSString* date = array[0];
    NSRange  range1 = NSMakeRange(5, 5);
    NSString* dateString = [date substringWithRange:range1];
    model.dateString = dateString;
    NSRange range2 = NSMakeRange(0, 5);
    NSString* timeString = [array[1] substringWithRange:range2];
    model.timeString = timeString;
}
#pragma mark ****** 创建tableView
-(void)createTableView{
    _tableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 0, SIZE.width, SIZE.height-150-64-49) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    __weak DaysInvestmentViewController* blockSelf = self;
    [_tableView setRequestData:^{
        [blockSelf refreshStateChangeIsUpToMore:NO];
    }];
    //------ 防止block循环引用 ------
    [_tableView setUpToLoadMore:^{
        [blockSelf refreshStateChangeIsUpToMore:YES];
    }];
}
#pragma mark ****** tableView的代理方法
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* cellId = @"cell";
    DayInvestmentCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[DayInvestmentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    if (_dataArray.count>0) {
        DaysInvestmentModel* model = _dataArray[indexPath.row];
        [cell configModel:model];
    }
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_dataArray.count>0) {
        return  _dataArray.count;
    }else
        return 30;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_dataArray.count>0) {
        DaysInvestmentModel* model = _dataArray[indexPath.row];
        if (_callBack) {
            _callBack(model.IdString);
        }
    }else{
        if (_callBack) {
            _callBack(@"1");
        }
    }
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end