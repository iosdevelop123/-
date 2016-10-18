//

#import "MarketsViewController.h"
#import "VarietiesView.h"

#import "DaysInvestmentViewController.h"
#import "ProfitSkillViewController.h"
#import "TodayJiepanController.h"

#import "MoreVarietiesViewController.h"

#import "DaysDetailController.h"
#import "BrokenLineViewController.h"

#import "BasePushViewController.h"

#define SIZE [[UIScreen mainScreen] bounds].size

@interface MarketsViewController ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate,UIScrollViewDelegate>
{
    UIView* mainView;
    
    UIPageControl* _pageControl;
    UIScrollView* _scroll;//多个品种活动scroll
    
    UIView* _VarietyBgView;//品种背景
    NSArray* _nameArray;//每日投资等名字的数组
    
    UIView* _lineView;//每日投资下面的横线
    
    UIPageViewController* _pageViewController;
    NSMutableArray* _vcArray;
    NSInteger _currentPage;
    
    BOOL _isFirstUp;//上下滑动手势是不是第一次上下滑动
}
@end

@implementation MarketsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _isFirstUp = YES;
    [self createData];
    [self createUI];
    [self createSwipGesture];
    
}

#pragma mark ****** 创建上下滑手势
-(void)createSwipGesture{
    UISwipeGestureRecognizer* swipGesture;
    swipGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [swipGesture setDirection:UISwipeGestureRecognizerDirectionUp];
    [self.view addGestureRecognizer:swipGesture];
    swipGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [swipGesture setDirection:UISwipeGestureRecognizerDirectionDown];
    [self.view addGestureRecognizer:swipGesture];
}
#pragma mark ****** 上下滑手势的实现
-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer{
    if (recognizer.direction == UISwipeGestureRecognizerDirectionUp) {
        if (_isFirstUp == YES) {
            [UIView animateWithDuration:0.5 animations:^{
                CGRect frame = mainView.frame;
                frame.origin.y = frame.origin.y - SIZE.height*0.3;
                mainView.frame = frame;
            }];
        }
        _isFirstUp = NO;
    }else if (recognizer.direction == UISwipeGestureRecognizerDirectionDown){
        if (_isFirstUp == NO) {
            [UIView animateWithDuration:0.5 animations:^{
                CGRect frame = mainView.frame;
                frame.origin.y = frame.origin.y + SIZE.height*0.3;
                mainView.frame = frame;
            }];
        }
        _isFirstUp = YES;
    }
}

#pragma mark ****** 创建data
-(void)createData{
    //------ 回调，pageViewController中的TableViewCell点击回调到主View ------
    DaysInvestmentViewController* vc1 = [[DaysInvestmentViewController alloc]init];
    [vc1 setCallBack:^(NSString *Id) {
        DaysDetailController* vc = [[DaysDetailController alloc]init];
        vc.Id = Id;
        vc.navigationTitle = @"专家策略";
        vc.hidesBottomBarWhenPushed = YES;
        [BasePushViewController customPushViewController:self.navigationController WithTargetViewController:vc];
    }];
    ProfitSkillViewController* vc2 = [[ProfitSkillViewController alloc]init];
    [vc2 setCallBackToViewController:^(NSString* Id){
        DaysDetailController* vc = [[DaysDetailController alloc]init];
        vc.Id = Id;
        vc.navigationTitle = @"盈利技巧";
        vc.hidesBottomBarWhenPushed = YES;
        [BasePushViewController customPushViewController:self.navigationController WithTargetViewController:vc];
    }];
    TodayJiepanController* vc3 = [[TodayJiepanController alloc]init];
    [vc3 setCallBack:^(NSString *Id) {
        DaysDetailController* vc = [[DaysDetailController alloc]init];
        vc.Id = Id;
        vc.navigationTitle = @"今日解说";
        vc.isVido = YES;
        vc.hidesBottomBarWhenPushed = YES;
        [BasePushViewController customPushViewController:self.navigationController WithTargetViewController:vc];
    }];
    _vcArray = [[NSMutableArray alloc]initWithObjects:vc1,vc2,vc3, nil];
    
    _nameArray = [NSArray arrayWithObjects:@"每日投资策略",@"盈利技巧", nil];
    NSArray *nameArr = @[@"现货白银",@"美元指数",@"原油指数"];
    NSArray *profitArr = @[@"3902",@"95.747",@"49.44"];
    NSArray *changeProfitArr = @[@"7",@"0.090",@"-0.10"];
    NSArray *zhishuArr = @[@"+0.18%",@"+0.09%",@"-0.20%"];
    _dataArray = [[NSMutableArray alloc]init];
    for (int i=0; i<3; i++) {
        VarietyModel* model = [[VarietyModel alloc]init];
        model.nameString = nameArr[i];
        model.profitString = profitArr[i];
        model.changeProfitString = changeProfitArr[i];
        model.zhishuSting = zhishuArr[i];
        [_dataArray addObject:model];
    }
}

-(void)createUI{
    mainView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SIZE.width, 1.3*SIZE.height)];
    [self.view addSubview:mainView];
//    UIView* picView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SIZE.width, SIZE.height*0.3)];
//    picView.backgroundColor = [UIColor grayColor];
//    [mainView addSubview:picView];
//    UITapGestureRecognizer* picSingleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(brokenLineGraphClick)];
//    [picView addGestureRecognizer:picSingleTap];
    UIImageView *picView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SIZE.width, SIZE.height*0.3)];
    picView.image = [UIImage imageNamed:@"marketImg"];
    [mainView addSubview:picView];
    
    UIView* bgView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(picView.frame), SIZE.width, 110)];
    bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
    [mainView addSubview:bgView];
    _scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SIZE.width, 80)];
    _scroll.delegate = self;
    _scroll.pagingEnabled = YES;
    _scroll.showsHorizontalScrollIndicator = NO;
    [bgView addSubview:_scroll];
    
    [self createVarietyView];
    
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(80, CGRectGetMaxY(_scroll.frame), SIZE.width-160, 30)];
    [bgView addSubview:_pageControl];
    //------ 更多品种按钮 ------
    UIButton* moreBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    moreBtn.frame = CGRectMake(SIZE.width-70, _pageControl.frame.origin.y, 60, 30) ;
    [moreBtn setTitle:@"更多品种" forState:UIControlStateNormal];
    [moreBtn setTintColor:[UIColor colorWithRed:0.83 green:0.84 blue:0.84 alpha:1]];
//    [moreBtn addTarget:self action:@selector(moreVariety) forControlEvents:UIControlEventTouchUpInside];
    //[bgView addSubview:moreBtn];
    
    for (int i=0; i<_nameArray.count; i++) {
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn.frame = CGRectMake(i*SIZE.width/2, CGRectGetMaxY(bgView.frame), SIZE.width/2, 40) ;
        btn.backgroundColor = [UIColor colorWithRed:0.89 green:0.88 blue:0.88 alpha:1];
        [btn setTitle:_nameArray[i] forState:UIControlStateNormal];
        [btn setTintColor:[UIColor colorWithRed:0.73 green:0.51 blue:0.07 alpha:1]];
        btn.tag = 100+i;
        [btn addTarget:self action:@selector(daysInvestmentBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [mainView addSubview:btn];
    }
    _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(bgView.frame)+40-3, SIZE.width/2, 3)];
    _lineView.backgroundColor = [UIColor colorWithRed:0.73 green:0.51 blue:0.07 alpha:1];
    [mainView addSubview:_lineView];
    
    [self createPageViewController:_lineView];
}
#pragma mark ****** 折线图点击事件
-(void)brokenLineGraphClick{
    BrokenLineViewController* vc = [[BrokenLineViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
}
#pragma mark ****** 创建pageViewController
-(void)createPageViewController:(UIView*)sender{
    _pageViewController = [[UIPageViewController alloc]initWithTransitionStyle:1 navigationOrientation:0 options:nil];
    _pageViewController.view.frame = CGRectMake(0, CGRectGetMaxY(sender.frame), SIZE.width, SIZE.height) ;
    [_pageViewController setViewControllers:@[_vcArray[0]] direction:1 animated:YES completion:nil];
    _pageViewController.view.backgroundColor = [UIColor whiteColor];
    [mainView addSubview:_pageViewController.view];
    _pageViewController.dataSource = self;
    _pageViewController.delegate = self;
}
#pragma mark ****** pageView的代理方法
-(void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed{
    UIViewController* vc = pageViewController.viewControllers[0];
    NSInteger index = [_vcArray indexOfObject:vc];
    CGRect frame = _lineView.frame;
    frame.origin.x = SIZE.width/3*index;
    _lineView.frame = frame;
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
#pragma mark ****** scrollView的代理方法
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger page =scrollView.contentOffset.x/SIZE.width;
    _pageControl.currentPage = page;
}

#pragma mark ****** 更多品种点击
-(void)moreVariety{
    MoreVarietiesViewController* vc = [[MoreVarietiesViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [BasePushViewController customPushViewController:self.navigationController WithTargetViewController:vc];
    /*
     [vc setBackToMainView:^(NSMutableArray *array) {
     _dataArray = array;
     NSInteger index = _dataArray.count%3;
     NSInteger page;//根据品种的个数设置scroll的滑动范围
     for (UIView* vie in _scroll.subviews) {
     [vie removeFromSuperview];
     }
     //------ 创建产品 ------
     [self createVarietyView];
     
     switch (index) {
     case 0:
     page = _dataArray.count/3;
     break;
     
     default:
     page = _dataArray.count/3+1;
     break;
     }
     if (page>1) {
     _pageControl.numberOfPages = page;
     }
     _scroll.contentSize = CGSizeMake(page*SIZE.width, 0);
     }];
     vc.array = _dataArray;
     */
    
}
#pragma mark ****** 品种的选择
-(void)singleTapClick:(UITapGestureRecognizer*)tap{
    NSInteger index = tap.view.tag-1;
    CGRect frame = _VarietyBgView.frame;
    frame.origin.x = SIZE.width/3*index;
    _VarietyBgView.frame = frame;
}
#pragma mark ****** 每日投资等按钮点击
-(void)daysInvestmentBtnClick:(UIButton*)sender{
    NSInteger index = sender.tag-100;
    CGRect frame = _lineView.frame;
    frame.origin.x = index*SIZE.width/2;
    _lineView.frame = frame;
    UIViewController* vc = _vcArray[index];
    [_pageViewController setViewControllers:@[vc] direction:index<_currentPage animated:YES completion:nil];
    _currentPage = _lineView.frame.origin.x*2/SIZE.width;
}
#pragma mark ****** 创建品种按钮详情
-(void)createVarietyView{
    _VarietyBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 5, SIZE.width/3, 75)];
    _VarietyBgView.layer.cornerRadius = 3;
    _VarietyBgView.layer.masksToBounds = YES;
    _VarietyBgView.backgroundColor = [UIColor colorWithRed:0.18 green:0.18 blue:0.18 alpha:1];
    [_scroll addSubview:_VarietyBgView];
    for (int i=0; i<_dataArray.count; i++) {
        VarietiesView* vie = [[VarietiesView alloc]initWithFrame:CGRectMake(i*SIZE.width/3, 5, SIZE.width/3, 80)];
        vie.backgroundColor = [UIColor clearColor];
        VarietyModel* model = _dataArray[i];
        vie.tag = i+1;
        [vie config:model];
        [_scroll addSubview:vie];
        //------ 创建单击手势 ------
        UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTapClick:)];
        singleTap.numberOfTapsRequired = 1;
        [vie addGestureRecognizer:singleTap];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end