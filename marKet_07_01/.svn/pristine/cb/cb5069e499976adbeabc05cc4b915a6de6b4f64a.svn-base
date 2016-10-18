//
//  AnswerViewController.m
//  MarKet
//
//  Created by Secret Wang on 16/5/12.
//  Copyright © 2016年 Secret. All rights reserved.
//

#import "AnswerViewController.h"
#import "AFNetworking.h"
#import "BaseTableView.h"
#import "AnswerTableViewCell.h"

#define SIZE [[UIScreen mainScreen] bounds].size
#define URL @"http://175.102.13.51:8080/XDSY/ZhuBan"
@interface AnswerViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    BaseTableView* _tableView;
    NSInteger _page;
    NSMutableArray* _dataArray;
}
@end

@implementation AnswerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _dataArray = [[NSMutableArray alloc]init];
    [self createTbaleView];
}
#pragma mark ****** 创建tableView
-(void)createTbaleView{
    _tableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 0, SIZE.width, SIZE.height-64)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    __weak AnswerViewController* blockSelf = self;
    [_tableView setRequestData:^{
        [blockSelf loadData:NO];
    }];
    [_tableView setUpToLoadMore:^{
        [blockSelf loadData:YES];
    }];
}
#pragma mark ****** 数据加载
-(void)loadData:(BOOL)is{
    if (is==YES) { _page++;}
    else _page = 1;
    NSDictionary* parameters = [[NSDictionary alloc]initWithObjectsAndKeys:
                                @".lybzhibo",@"type",
                                @"dayi",@"defference",
                                [NSString stringWithFormat:@"%ld",(long)_page],@"indexPage",
                                nil];
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    [manager GET:URL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString* i = responseObject[@"flag"];
        int index = [i intValue];
        if (index == 1) {
            if (is==YES) {}else [_dataArray removeAllObjects];
            NSArray* array = responseObject[@"data"];
            for (int i=0; i<array.count; i++) {
                AnswerModel* model = [[AnswerModel alloc]init];
                model.q = array[i][@"Q"];
                model.qn = array[i][@"Qn"];
                model.qt = array[i][@"Qutime"];
                model.an = array[i][@"An"];
                model.a = array[i][@"A"];
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
#pragma mark ****** tableView的代理方法
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* cellId = @"cell";
    AnswerTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[AnswerTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    if (_dataArray.count>0) {
        AnswerModel* model = _dataArray[indexPath.row];
        [cell configModel:model];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_dataArray.count>0) {
        UITableViewCell* cell = [self tableView:_tableView cellForRowAtIndexPath:indexPath];
        return cell.frame.size.height+10;
    }else
        return 160;

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_dataArray.count>0) {
        return _dataArray.count;
    }else
        return 10;
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
    // Dispose of any resources that can be recreated.
}


@end
