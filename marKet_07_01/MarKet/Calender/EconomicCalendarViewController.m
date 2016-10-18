//
//  EconomicCalendarViewController.m
//  Market
//
//  Created by dayu on 16/3/3.
//  Copyright © 2016年 dayu. All rights reserved.
//
#import "EconomicCalendarViewController.h"
#import "DateView.h"
#import "BasePushViewController.h"
#import "OnlineReleaseViewController.h"

#define HEIGHT CGRectGetHeight(self.view.bounds)
#define WIDTH CGRectGetWidth(self.view.bounds)
#define CALENDARBUTTONWIDTH 60
#define CALENDARBUTTONHEIGHT 44
#define CALENDARITEMWIDTH (WIDTH-CALENDARBUTTONWIDTH*2)/5.0-1
#define GOLD [UIColor colorWithRed:195/255.0 green:150/255.0 blue:69/255.0 alpha:1.0]
#define GRAY [UIColor colorWithRed:230/255.0 green:229/255.0 blue:227/255.0 alpha:1.0]
#import "CalendarCell.h"
@interface EconomicCalendarViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

@property (strong,nonatomic) UIScrollView *dateScrollView;//日期选项卡
@property (strong,nonatomic) NSMutableArray *dayArray;//日期数组
@property (strong,nonatomic) NSMutableArray *weekArray;//星期数组
@property (strong,nonatomic) NSMutableArray *viewArray;//日期View数组
@property (strong,nonatomic) UIAlertController *calendarAlert;//日期弹窗
@property (strong,nonatomic) NSDate *selectedDate;//选中日期
@property (strong,nonatomic) UITableView *tableView;//表格
@property (strong,nonatomic) UIAlertController *dateAlert;//自定义日历控制器弹窗

@end
@implementation EconomicCalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createOnline];
    self.navigationItem.title = @"财经日历";
    self.view.backgroundColor = [UIColor whiteColor];
    self.viewArray = [NSMutableArray array];
    //日历按钮
    UIButton *calendarButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CALENDARBUTTONWIDTH-1, CALENDARBUTTONHEIGHT)];
    calendarButton.backgroundColor = GRAY;
    [calendarButton setImage:[UIImage imageNamed:@"calendar"] forState:UIControlStateNormal];
    [calendarButton addTarget:self action:@selector(calendarClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:calendarButton];
    //获取本月的"日"和星期数组
    self.dayArray = [self getDayArrayFromDate:[NSDate date]];
    self.weekArray = [self getWeekArrayFromDate:[NSDate date]];
    //创建日期选项卡 UIScrollView
    [self createScrollViewWithDate:[NSDate date]];
    //是否公布按钮
    UIButton *isPublishButton = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH-CALENDARBUTTONWIDTH+1, 0, CALENDARBUTTONWIDTH-1, CALENDARBUTTONHEIGHT)];
    isPublishButton.backgroundColor = GOLD;
    [isPublishButton setTitle:@"未公布" forState:UIControlStateNormal];
    [isPublishButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    isPublishButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [self.view addSubview:isPublishButton];
    [self createTableView];//初始化表格视图
    [self initCustomAlert];//初始化自定义弹窗
}
#pragma mark ****** 右上角在线解套
-(void)createOnline{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"在线解套" style:UIBarButtonItemStyleDone target:self action:@selector(onLine)];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:15.0f],NSFontAttributeName, nil] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
}
#pragma mark ****** 在线解套
-(void)onLine{
    
    OnlineReleaseViewController* vc = [[OnlineReleaseViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [BasePushViewController customPushViewController:self.navigationController WithTargetViewController:vc];
}

#pragma mark 初始化自定义弹窗
- (void)initCustomAlert{
    if (_dateAlert == nil) {
        _dateAlert = [UIAlertController alertControllerWithTitle:@"请选择日期" message:@"\n\n\n\n\n\n\n\n"  preferredStyle:UIAlertControllerStyleAlert];
        //添加日历控件
        UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 50, 270, 150)];
        datePicker.datePickerMode = UIDatePickerModeDate;
        [datePicker setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
        datePicker.timeZone = [NSTimeZone timeZoneWithName:@"Asia/beijing"];
        if (self.selectedDate!=nil) {
            [datePicker setDate:self.selectedDate animated:YES];
        }
        [_dateAlert.view addSubview:datePicker];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [self sureActionForDatePicker:[datePicker date]];
        }];
        [_dateAlert addAction:sureAction];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [_dateAlert addAction:cancelAction];
    }
}
#pragma mark 初始化表格
- (void)createTableView{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_dateScrollView.frame), WIDTH, HEIGHT-_dateScrollView.frame.size.height-49-64) style:UITableViewStylePlain];
    _tableView.backgroundColor=[UIColor colorWithRed:243/255.0 green:244/255.0 blue:245/255.0 alpha:1.0];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.bounces=YES;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorColor=[UIColor grayColor];
    [self.view addSubview:_tableView];
    
}
#pragma mark tableView的代理方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* cellId = @"cell";
    CalendarCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell==nil) {
        cell=[[CalendarCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
#pragma mark tableView的代理返回cell高度和个数
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
#pragma mark 日历按钮点击事件
- (void)calendarClick:(UIButton *)sender{
    [self presentViewController:_dateAlert animated:YES completion:nil];
}

#pragma mark 点击日历控件"确定"事件
- (void)sureActionForDatePicker:(NSDate *)date{
    //根据日历控件选中的日期重新加载日期选项卡
    [self.dayArray removeAllObjects];
    [self.weekArray removeAllObjects];
    for (DateView *aView in self.dateScrollView.subviews) {
        [aView removeFromSuperview];
    }
    [self.viewArray removeAllObjects];
    self.dayArray = [self getDayArrayFromDate:date];
    self.weekArray = [self getWeekArrayFromDate:date];
    [self createScrollViewWithDate:date];
    self.selectedDate = date;
}

#pragma mark 获取指定日期的NSDateComponents对象
- (NSDateComponents *)getDateComponents:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth|NSCalendarUnitDay;
    NSDateComponents *components = [calendar components:unitFlags fromDate:date];
    return components;
}
#pragma mark 获取指定日期所对应的当月天数
- (NSInteger)getDaysFromDate:(NSDate *)date{
    NSDateComponents *components = [self getDateComponents:date];
    NSInteger year = [components year];
    NSInteger month = [components month];
    switch (month) {
        case 2:
            return ((year%4==0&&year%100!=0)||year%400==0) ? 29 : 28;   break;
        case 4: case 6: case 9: case 11:
            return 30;  break;
        default:
            return 31;  break;
    }
}
- (NSMutableArray *)getDayArrayFromDate:(NSDate *)date{
    NSInteger  daysOfMonth = [self getDaysFromDate:date];
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 1 ; i <= daysOfMonth; i++ ) {
        [array addObject:[NSString stringWithFormat:@"%d",i]];
    }
    return array;
}
#pragma mark 获取本月的星期数组
- (NSMutableArray *)getWeekArrayFromDate:(NSDate *)date{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.day = 1;
    components.month = [[self getDateComponents:date] month];
    components.year = [[self getDateComponents:date] year];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *calendarDate = [calendar dateFromComponents:components];
    NSDateComponents *weekdayComponents = [calendar components:NSCalendarUnitWeekday fromDate:calendarDate];
    NSInteger firstWeekDayOfCurrentMonth = [weekdayComponents weekday]-1;
    NSArray *weekDayArray = @[@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"];
    NSMutableArray *array = [NSMutableArray array];
    for (int i =1 ; i<= self.dayArray.count; i++) {
        int weekDay = (firstWeekDayOfCurrentMonth + (i-1))%7;
        [array addObject:[weekDayArray objectAtIndex:weekDay]];
    }
    return array;
}

#pragma mark 创建日期选项卡
- (void)createScrollViewWithDate:(NSDate *)date{
    if (self.dateScrollView!=nil) {
        [self.dateScrollView removeFromSuperview];
        self.dateScrollView = nil;
    }
    self.dateScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(CALENDARBUTTONWIDTH, 0, WIDTH-CALENDARBUTTONWIDTH*2, CALENDARBUTTONHEIGHT)];
    self.dateScrollView.contentSize = CGSizeMake((CALENDARITEMWIDTH+1)*self.dayArray.count, 40);
    self.dateScrollView.backgroundColor = [UIColor whiteColor];
    self.dateScrollView.showsHorizontalScrollIndicator = NO;
    self.dateScrollView.delegate = self;
    self.dateScrollView.bounces = NO;
    [self.view addSubview:self.dateScrollView];
    for (int i = 0; i< self.dayArray.count; i++) {
        DateView *aView = [[DateView alloc] initWithFrame:CGRectMake(1+i*(CALENDARITEMWIDTH+1), 0, CALENDARITEMWIDTH, CALENDARBUTTONHEIGHT) calendarItemSize:CGSizeMake(CALENDARITEMWIDTH, CALENDARBUTTONHEIGHT)];
        aView.backgroundColor = GRAY;
        aView.tag = i+1;
        [self.dateScrollView addSubview:aView];
        aView.weekDayLabel.text = [self.weekArray objectAtIndex:i];
        aView.dayLabel.text = [self.dayArray objectAtIndex:i];
        //添加点击事件让UIView能点击
        UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewClick:)];
        [aView addGestureRecognizer:tapGesture];
        [self.viewArray addObject:aView];
    }
    //默认当天被选中
    NSDateComponents *components = [self getDateComponents:date];
    NSInteger day = [components day];
    DateView *currentView = (DateView *)[self.viewArray objectAtIndex:day-1];
    currentView.backgroundColor = GOLD;
    currentView.weekDayLabel.textColor = [UIColor whiteColor];
    currentView.dayLabel.textColor = [UIColor whiteColor];
    if (day>3&&day<self.self.dayArray.count-3) {
        self.dateScrollView.contentOffset = CGPointMake(1+(day -3)*(CALENDARITEMWIDTH+1), 0);
    }else if (day<=3) {
        self.dateScrollView.contentOffset = CGPointMake(1, 0);
    }else {
        self.dateScrollView.contentOffset = CGPointMake(1+(self.dayArray.count-5)*(CALENDARITEMWIDTH+1), 0);
    }
}

#pragma mark 日历选项卡点击事件
- (void)viewClick:(UITapGestureRecognizer *)sender{
    for (DateView *aView in self.viewArray) {
        aView.backgroundColor = GRAY;
        aView.weekDayLabel.textColor = GOLD;
        aView.dayLabel.textColor = GOLD;
    }
    DateView *aView= (DateView *)sender.view;
    aView.backgroundColor = GOLD;
    aView.weekDayLabel.textColor = [UIColor whiteColor];
    aView.dayLabel.textColor = [UIColor whiteColor];
    //让选中的View居中
    if ((self.dateScrollView.contentOffset.x>1&&self.dateScrollView.contentOffset.x<1+(self.dayArray.count-5)*(CALENDARITEMWIDTH+1))||sender.view.tag ==4||sender.view.tag ==5 || sender.view.tag ==self.dayArray.count-4||sender.view.tag == self.dayArray.count-3) {
        [self.dateScrollView setContentOffset:CGPointMake(1+(sender.view.tag -3)*(CALENDARITEMWIDTH+1), 0) animated:YES];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //防止UIScrollView往最左边或最右边偏移时出界
    if (self.dateScrollView.contentOffset.x<1){
        [self.dateScrollView setContentOffset:CGPointMake(1, 0)];
    }else if (self.dateScrollView.contentOffset.x>1+(self.dayArray.count-5)*(CALENDARITEMWIDTH+1)){
        [self.dateScrollView setContentOffset:CGPointMake(1+(self.dayArray.count-5)*(CALENDARITEMWIDTH+1), 0)];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end