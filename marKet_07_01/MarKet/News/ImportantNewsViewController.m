//
//  ImportantNewsViewController.m
//  Market
//
//  Created by dayu on 16/3/3.
//  Copyright © 2016年 dayu. All rights reserved.
//

#import "ImportantNewsViewController.h"
#import "ImportantNewsCell.h"
#import "NewsDetailViewController.h"
#import "AFNetworking.h"
#import "BaseTableView.h"
#define WIDTH CGRectGetWidth([UIScreen mainScreen].bounds)
#define HEIGHT CGRectGetHeight([UIScreen mainScreen].bounds)
#define URL @"http://htmdata.fx678.com/15/oem/news.php"
@interface ImportantNewsViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property (strong,nonatomic) UIPageControl *pageControl;//引导页码
@property (strong,nonatomic) UIScrollView *scrollView;//滚动视图
@property (strong,nonatomic) BaseTableView *tableView;//表格
@property (strong,nonatomic) UILabel *TitleLabel;//按钮标题文字
@property (strong,nonatomic) UIRefreshControl *reFresh;//下拉刷新控件
@property (strong,nonatomic) NSArray *titleArr;//按钮标题数组
@property(strong,nonatomic) UIActivityIndicatorView *activity;//加载刷新控件
@property (strong,nonatomic) NSMutableArray *dataSource;//数据集合
//@property (nonatomic) NSInteger page;//加载页面数
@property (strong,nonatomic) NSArray *timeArr;
@property (strong,nonatomic) NSArray *keyArr;
@property (strong,nonatomic) NSArray *ncArr;
@end
@implementation ImportantNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"要闻";
  _ncArr=@[@"NEWS_YAO_WEN",@"NEWS_ZHI_BO",@"NEWS_XI_DU_SHI_YOU",@"NEWS_WAI_HUI",@"NEWS_JIN_YIN",@"NEWS_MEI_GUO",@"NEWS_ZHONG_GUO",@"NEWS_OU_ZHOU",@"NEWS_MEI_ZHOU",@"NEWS_YA_ZHOU",@"NEWS_SHANG_PIN",@"NEWS_GU_SHI",@"NEWS_ZHAI_SHI",@"NEWS_MEI_LIAN_CHU",@"NEWS_YANG_HANG",@"NEWS_TRADEREAD",@"NEWS_ONEPIC",@"NEWS_JIONGTU"];
   _timeArr=@[@"1469080306",@"1469080763",@"1469082993",@"1469083034",@"1469083068",@"1469083235",@"1469083272",@"1469083290",@"1469083309",@"1469083322",@"1469083093",@"1469083134",@"1469083154",@"1469083193",@"1469083210",@"1469085063",@"1469085107",@"1469085138"];
 _keyArr=@[@"498412803a24af9f01451039ef6ff610",@"c2257cefbf226b006be8a8168d64bb5c",@"6823f9d50543353b4036d1cd54965228",@"d7b67a3d9613eb25af1e9b2e1738ce5e",@"4d953df367f1eb08e6eae4b6fb7b709d",@"429a22e01f63ae7049006280c1e490d6",@"edd5ac327a3e1d1c900b751e9e040a71",@"7668703a366cef85681a34bca46ecf01",@"29b1992526302d5f24869d52f8c78339",@"095ca88195666076e9109627490cb823",@"63b7c9defedc4d935e19e8d6c6acbdaf",@"62b337495b6363acf338a68678604c54",@"ebe7ed76d1cbcf5424b22f542c1d1151",@"b1a50ec73a07188e6476bddbe44cf402",@"994cf54bbbb810f3552a669b12c90d3e",@"b10c3450c6ced47b34ed6863288e5620",@"1264dbbaf636a91aca209586b055db8f",@"7807b2fab6831ff23dd299f65af485de"];
    [self initScrollView];//初始化顶部滚动视图
    // 初始数据源
    _dataSource = [[NSMutableArray alloc] init];
    [self createTableView];//初始化表格视图
}

#pragma mark 请求网络
- (void)refreshStateChangeisUpToGetMore:(BOOL)isUp{
    int m=0;
    for (int k=0; k<19; k++) {
        if (_titleArr[k]==self.navigationItem.title) {
            m=k;
        }
    }
    NSDictionary* parameters = [[NSDictionary alloc]initWithObjectsAndKeys:@"ee2a88734cb4245254ecd78194a6eef6",@"s",@"1",@"oid",_ncArr[m],@"nc",@"0",@"nid",_timeArr[m],@"time",_keyArr[m],@"key",nil];
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:URL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (isUp==YES) {}else [_dataSource removeAllObjects];
            NSArray *data=[responseObject objectForKey:@"news"];
            for (int i=0;i<data.count;i++) {
                ImportantNewsModel *model=[[ImportantNewsModel alloc]init];
                model.DetailLabel=data[i][@"title"];
                model.Id=data[i][@"nid"];
                model.PicStr=data[i][@"picture"];
                model.timestamp=data[i][@"publish"];
                NSDate *date = [NSDate dateWithTimeIntervalSince1970:[data[i][@"publish"] doubleValue]];
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                NSString *destDateString = [dateFormatter stringFromDate:date];
                model.TimeStr=destDateString;
                [_dataSource addObject:model];
            }
        [_tableView reloadData];
        [_tableView endrefresh];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       // NSLog(@"error===%@",error.description);
        [_tableView endrefresh];
    }];


}
#pragma mark 初始化顶部滚动视图
- (void)initScrollView{
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, WIDTH*2/5+40)];
    [_scrollView setContentSize:CGSizeMake(WIDTH*2, WIDTH*2/5-9)];
    [_scrollView setPagingEnabled:YES];//视图整页显示
    [_scrollView setDelegate:self];
    [_scrollView setBackgroundColor:[UIColor whiteColor]];
    [_scrollView setBounces:NO]; //避免弹跳效果
    [_scrollView setShowsHorizontalScrollIndicator:NO];
    [_scrollView setShowsVerticalScrollIndicator:NO];
    _scrollView.delaysContentTouches=NO;//scrollview监听touch和移动,让他先响应touch
    [self.view addSubview:_scrollView];
    _titleArr=[NSArray arrayWithObjects:@"要闻",@"直播",@"石油",@"外汇",@"金银",@"美国",@"中国",@"欧洲",@"美洲",@"亚洲",@"商品",@"股市",@"债市",@"美联储",@"央行",@"交易必读",@"一张图",@"全球囧闻",@"收藏",nil];
    //------ 创建按钮 ------
    for (int i=0; i<10; i++) {
        UIButton *Btn=[UIButton buttonWithType:UIButtonTypeSystem];
        Btn.frame=CGRectMake(WIDTH*i/5+15, 10, WIDTH/5-30, WIDTH/5-30);
        [Btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"News%d",i]] forState:UIControlStateNormal];
        Btn.layer.cornerRadius=WIDTH/10-15;
        Btn.tag=i+1;
        [Btn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:Btn];
        _TitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(i*WIDTH/5,WIDTH/5-10, WIDTH/5, 10)];
        _TitleLabel.text=_titleArr[i];
        _TitleLabel.textColor=[UIColor blackColor];
        _TitleLabel.textAlignment=NSTextAlignmentCenter;
        _TitleLabel.font=[UIFont systemFontOfSize:12.0];
        [_scrollView addSubview:_TitleLabel];
    }
    for (int j=10; j<19; j++) {
        UIButton *Btn=[UIButton buttonWithType:UIButtonTypeSystem];
        Btn.frame=CGRectMake(WIDTH*(j-10)/5+15, WIDTH/5+10, WIDTH/5-30, WIDTH/5-30);
        [Btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"News%d",j]] forState:UIControlStateNormal];
        Btn.layer.cornerRadius=WIDTH/10-15;
        Btn.tag=j+1;
        [Btn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:Btn];
        _TitleLabel=[[UILabel alloc]initWithFrame:CGRectMake((j-10)*WIDTH/5,2*WIDTH/5-10, WIDTH/5, 10)];
        _TitleLabel.text=_titleArr[j];
        _TitleLabel.textColor=[UIColor blackColor];
        _TitleLabel.textAlignment=NSTextAlignmentCenter;
        _TitleLabel.font=[UIFont systemFontOfSize:12.0];
        [_scrollView addSubview:_TitleLabel];
    }
    //------ 引导页码 ------
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, WIDTH*2/5+14, WIDTH, 10)];
    [_pageControl setNumberOfPages:2];
    [_pageControl setCurrentPageIndicatorTintColor:[UIColor colorWithRed:251/255.0 green:158/255.0 blue:53/255.0 alpha:1.0]];
    [_pageControl setPageIndicatorTintColor:[UIColor colorWithRed:178/255.0 green:178/255.0 blue:178/255.0 alpha:1.0]];
    [self.view addSubview:_pageControl];

}
#pragma mark 初始化表格
- (void)createTableView{
    _tableView=[[BaseTableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_scrollView.frame), WIDTH, HEIGHT-_scrollView.frame.size.height-49-64) style:UITableViewStylePlain];
    _tableView.backgroundColor=[UIColor whiteColor];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.bounces=YES;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.separatorColor=[UIColor grayColor];
    _tableView.userInteractionEnabled = YES;
    [_tableView setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:_tableView];
    _activity = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [_activity setCenter:_tableView.center];
    [_activity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    [self.view addSubview:_activity];
    __weak ImportantNewsViewController *blockSelf=self;
    [_tableView setRequestData:^{
        [blockSelf refreshStateChangeisUpToGetMore:NO];
    }];
    //------ 防止block循环引用 ------
    [_tableView setUpToLoadMore:^{
        [blockSelf refreshStateChangeisUpToGetMore:YES];
    }];
}

#pragma mark tableView的代理返回cell高度和个数
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_dataSource.count>0) {
        return _dataSource.count;
    }else
        return 7;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
#pragma mark tableView的代理方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* cellId = @"cell";
    ImportantNewsCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell==nil) {
        cell=[[ImportantNewsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.selectedBackgroundView=[[UIView alloc]initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor=[UIColor colorWithRed:208/255.0 green:218/255.0 blue:245/255.0 alpha:0.8];
    if (_dataSource.count>0) {
        ImportantNewsModel *model=_dataSource[indexPath.row];
        [cell refresh:model];
    }
    return cell;
}
#pragma mark 设置cell的显示动画
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    //设置cell的显示动画为3d缩放，xy方向的缩放动画，初始值为0.1 结束值为1
    cell.layer.transform=CATransform3DMakeScale(0.1, 0.1, 1);
    [UIView animateWithDuration:0.25 animations:^{
        cell.layer.transform=CATransform3DMakeScale(1, 1, 1);
    }];
}
#pragma mark  按钮点击事件
- (void)BtnClick:(UIButton *)sender{
    self.navigationItem.title=_titleArr[sender.tag-1];
    sender.enabled = NO;
    if (sender.tag==19) {
        [_activity startAnimating];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                sleep(0.8);
                [_activity stopAnimating];
                sender.enabled = YES;
            });
        });
    }else if (sender.tag==3){
        [_activity startAnimating];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [_dataSource removeAllObjects];
            sleep(1.0);
            NSDictionary* parameters = [[NSDictionary alloc]initWithObjectsAndKeys:@"ee2a88734cb4245254ecd78194a6eef6",@"s",@"201",@"oid",_ncArr[sender.tag-1],@"nc",@"0",@"nid",_timeArr[sender.tag-1],@"time",_keyArr[sender.tag-1],@"key",nil];
            AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
            manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
            [manager GET:URL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                //NSLog(@"%@",responseObject);
                NSArray *data=[responseObject objectForKey:@"news"];
                for (int i=0;i<data.count;i++) {
                    ImportantNewsModel *model=[[ImportantNewsModel alloc]init];
                    model.DetailLabel=data[i][@"title"];
                    model.Id=data[i][@"nid"];
                    model.PicStr=data[i][@"picture"];
                    model.timestamp=data[i][@"publish"];
                    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[data[i][@"publish"] doubleValue]];
                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                    NSString *destDateString = [dateFormatter stringFromDate:date];
                    model.TimeStr=destDateString;
                    [_dataSource addObject:model];
                }
                [_tableView reloadData];
                [_tableView endrefresh];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                // NSLog(@"error===%@",error.description);
                [_tableView endrefresh];
            }];
            dispatch_async(dispatch_get_main_queue(), ^{
                [_activity stopAnimating];
                sender.enabled = YES;
            });
        });
    }else{
        [_activity  startAnimating];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [_dataSource removeAllObjects];
            sleep(1.0);
            NSDictionary* parameters = [[NSDictionary alloc]initWithObjectsAndKeys:@"ee2a88734cb4245254ecd78194a6eef6",@"s",@"1",@"oid",_ncArr[sender.tag-1],@"nc",@"0",@"nid",_timeArr[sender.tag-1],@"time",_keyArr[sender.tag-1],@"key",nil];
            AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
            manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
            [manager GET:URL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                //NSLog(@"%@",responseObject);
                NSArray *data=[responseObject objectForKey:@"news"];
                for (int i=0;i<data.count;i++) {
                    ImportantNewsModel *model=[[ImportantNewsModel alloc]init];
                    model.DetailLabel=data[i][@"title"];
                    model.Id=data[i][@"nid"];
                    model.PicStr=data[i][@"picture"];
                    model.timestamp=data[i][@"publish"];
                    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[data[i][@"publish"] doubleValue]];
                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                    NSString *destDateString = [dateFormatter stringFromDate:date];
                    model.TimeStr=destDateString;
                    [_dataSource addObject:model];
                }
                [_tableView reloadData];
                [_tableView endrefresh];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                // NSLog(@"error===%@",error.description);
                [_tableView endrefresh];
            }];
            dispatch_async(dispatch_get_main_queue(), ^{
                [_activity stopAnimating];
                sender.enabled = YES;
            });
        });
    }
}
//#pragma mark cell点击事件
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    self.hidesBottomBarWhenPushed = YES;
//    if (_dataSource.count>0) {
//        ImportantNewsModel *model=_dataSource[indexPath.row];
//        NewsDetailViewController *VC=[[NewsDetailViewController alloc]init];
//        VC.timeStr=model.timestamp;
//        VC.newid=model.Id;
//        [self.navigationController pushViewController:VC animated:YES];
//        if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
//            self.navigationController.interactivePopGestureRecognizer.delegate = nil;
//        }
//    }
//    self.hidesBottomBarWhenPushed = NO;
//}
#pragma mark 引导视图滑动结束事件
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [_pageControl setCurrentPage:_scrollView.contentOffset.x/WIDTH];
}

@end