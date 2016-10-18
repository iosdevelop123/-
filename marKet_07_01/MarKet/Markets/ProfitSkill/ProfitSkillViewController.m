//
//  ProfitSkillViewController.m
//  MarKet
//
//  Created by Secret Wang on 16/3/10.
//  Copyright © 2016年 Secret. All rights reserved.
//

#import "ProfitSkillViewController.h"
#import "ProfitSkillCell.h"
#import "BaseTableView.h"
#import "AFNetworking.h"

#define SIZE [UIScreen mainScreen].bounds.size
#define URL @"http://175.102.13.51:8080/XDSY/ZhuBan"
@interface ProfitSkillViewController ()
{
    BaseTableView* _tableView;
    NSInteger _page;
    NSMutableArray* _dataArray;
}
@end

@implementation ProfitSkillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _page = 1;
    _dataArray = [[NSMutableArray alloc]init];
    [self createTableView];
}
-(void)refreshStateChangeIsUpToGetMore:(BOOL)isUp
{
    if (isUp==YES) {_page++;}
    else _page = 1;
    NSDictionary* paramenters = [[NSDictionary alloc]initWithObjectsAndKeys:@".guanwang",@"type",
                                                                                                                                @"touzi",@"defference",
                                                                                                                               [NSString stringWithFormat:@"%ld",(long)_page],@"indexPage",
                                                                                                                                nil];
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    [manager GET:URL parameters:paramenters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString* i = responseObject[@"flag"];
        int index = [i intValue];
        if (index==1) {
            if (isUp==YES) {}else [_dataArray removeAllObjects];
            NSArray* array = responseObject[@"data"];
            for (int i=0; i<array.count; i++) {
                ProfitSkillModel* model = [[ProfitSkillModel alloc]init];
                NSString* data = array[i][@"Senddate"];
                [self getTimeAndDate:data AndModel:model];
                model.titleString = array[i][@"Title"];
                model.Keywords = array[i][@"Keywords"];
                model.Id = array[i][@"Id"];
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
#pragma mark ****** 截取时间字符串
-(void)getTimeAndDate:(NSString*)string AndModel:(ProfitSkillModel*)model{
    NSArray* array = [string componentsSeparatedByString:@"  "];
    NSString* date = array[0];
//    NSRange  range1 = NSMakeRange(5, 5);
//    NSString* dateString = [date substringWithRange:range1];
    model.dateString = date;
//    NSRange range2 = NSMakeRange(0, 5);
//    NSString* timeString = [array[1] substringWithRange:range2];
//    model.timeString = timeString;
}


#pragma mark ****** 创建tableView
-(void)createTableView{
    _tableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 0, SIZE.width, SIZE.height-150-64-49) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    __weak ProfitSkillViewController* blockSelf = self;
    [_tableView setRequestData:^{
        [blockSelf refreshStateChangeIsUpToGetMore:NO];
    }];
    [_tableView setUpToLoadMore:^{
        [blockSelf refreshStateChangeIsUpToGetMore:YES];
    }];
}
#pragma mark ****** tableView的代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_dataArray.count>0) {
        return _dataArray.count;
    }else
        return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* cellId = @"cell";
    ProfitSkillCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[ProfitSkillCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    if (_dataArray.count>0){
        ProfitSkillModel* model = _dataArray[indexPath.row];
        [cell configModel:model];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_dataArray.count>0) {
        ProfitSkillModel* model = _dataArray[indexPath.row];
        if (_callBackToViewController) {
            _callBackToViewController(model.Id);
        }
    }else{
        if (_callBackToViewController) {
             _callBackToViewController(@"1");
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