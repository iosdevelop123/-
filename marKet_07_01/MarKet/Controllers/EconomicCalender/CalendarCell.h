//
//  CalendarCell.h
//  MarKet
//
//  Created by Aaron Lee on 16/3/11.
//  Copyright © 2016年 Secret. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalendarCell : UITableViewCell
@property (strong,nonatomic) UILabel *DateLabel;//日期
@property (strong,nonatomic) UIImageView *Imgv;//图片
@property (strong,nonatomic) UILabel *DetailLabel;//详细信息
@property (strong,nonatomic) UILabel *AdvanceLabel;//前值
@property (strong,nonatomic) UILabel *AdvanceNumLabel;//前值数值
@property (strong,nonatomic) UILabel *ExpectLabel;//预期
@property (strong,nonatomic) UILabel *ExpectNumLabel;//预期数值
@property (strong,nonatomic) UILabel *ActualLabel;//实际
@property (strong,nonatomic) UILabel *ActualNumLabel;//实际数值
- (void)Refresh;
@end
