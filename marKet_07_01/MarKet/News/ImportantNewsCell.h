//
//  ImportantNewsCell.h
//  MarKet
//
//  Created by Aaron Lee on 16/3/11.
//  Copyright © 2016年 Secret. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImportantNewsModel.h"
@interface ImportantNewsCell : UITableViewCell
@property (strong,nonatomic) UIImageView *Imgv;//图片
@property (strong,nonatomic) UILabel *DetailLabel;//详细信息
@property (strong,nonatomic) UILabel *TimeLabel;//时间
- (void)refresh:(ImportantNewsModel *)model;
@end
