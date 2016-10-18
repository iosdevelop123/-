//
//  ItemTableViewCell.m
//  MarKet
//
//  Created by Secret Wang on 16/3/16.
//  Copyright © 2016年 Secret. All rights reserved.
//

#import "ItemTableViewCell.h"
#define SIZE [[UIScreen mainScreen] bounds].size
@implementation ItemTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
        [self createView];
    }
    return self;
}
-(void)createView{
    _nameLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SIZE.width/3, 40)];
    _nameLable.textAlignment = NSTextAlignmentCenter;
    _nameLable.font = [UIFont systemFontOfSize:14.0f];
    _nameLable.textColor = [UIColor whiteColor];
    _nameLable.text = @"品种";
    _nameLable.numberOfLines = 0;
    _nameLable.adjustsFontSizeToFitWidth = YES ;
    [self.contentView addSubview:_nameLable];
    
    _lable1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_nameLable.frame), 0, SIZE.width/3, 40)];
    _lable1.textAlignment = NSTextAlignmentCenter;
    _lable1.font = [UIFont systemFontOfSize:14.0f];
    _lable1.text = @"最新";
    _lable1.textColor = [UIColor whiteColor];
    _lable1.numberOfLines = 0;
    _lable1.adjustsFontSizeToFitWidth = YES ;
    [self.contentView addSubview:_lable1];
    
    _lable2 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_lable1.frame), 0, SIZE.width/3, 40)];
    _lable2.textAlignment = NSTextAlignmentCenter;
    _lable2.font = [UIFont systemFontOfSize:14.0f];
    _lable2.text = @"涨跌";
    _lable2.textColor = [UIColor whiteColor];
    _lable2.numberOfLines = 0;
    _lable2.adjustsFontSizeToFitWidth = YES ;
    [self.contentView addSubview:_lable2];
}
-(void)configData:(MoreDetailModel *)model{
    _nameLable.text = model.string1;
    _lable1.text = model.string2;
    _lable2.text = model.string3;
}
@end