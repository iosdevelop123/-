 //
//  DayInvestmentCell.m
//  MarKet
//
//  Created by Secret Wang on 16/3/11.
//  Copyright © 2016年 Secret. All rights reserved.
//

#import "DayInvestmentCell.h"
#define SIZE [[UIScreen mainScreen] bounds].size
@implementation DayInvestmentCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createView];
    }
    return self;
}
-(void)createView{
    _zhuanjiaLable = [[UILabel alloc]initWithFrame:CGRectMake(25, 20, 80, 20)];
    _zhuanjiaLable.text = @"专家策略";
    _zhuanjiaLable.font = [UIFont systemFontOfSize:14.0f];
    _zhuanjiaLable.textAlignment = NSTextAlignmentCenter;
    _zhuanjiaLable.textColor = [UIColor whiteColor];
    _zhuanjiaLable.layer.cornerRadius = 4;
    _zhuanjiaLable.layer.masksToBounds = YES;
    _zhuanjiaLable.layer.backgroundColor = [UIColor colorWithRed:0.73 green:0.51 blue:0.06 alpha:1].CGColor;
    [self.contentView addSubview:_zhuanjiaLable];
    
    _dateLable = [[UILabel alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(_zhuanjiaLable.frame), 40, 20)];
    _dateLable.text = @"03-10";
    _dateLable.textColor = [UIColor redColor];
    _dateLable.textAlignment = NSTextAlignmentCenter;
    _dateLable.font = [UIFont systemFontOfSize:13.0f];
    [self.contentView addSubview:_dateLable];
    
    _timeLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_dateLable.frame), _dateLable.frame.origin.y, 40, 20)];
    _timeLable.text = @"24:24";
    _timeLable.textColor = [UIColor redColor];
    _timeLable.textAlignment = NSTextAlignmentCenter;
    _timeLable.font = [UIFont systemFontOfSize:13.0f];
    [self.contentView addSubview:_timeLable];
    
    UIView* rightBgView = [[UIView alloc]initWithFrame:CGRectMake(130, 1, SIZE.width-130, 78)];
//    rightBgView.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1];
    [self.contentView addSubview:rightBgView];
    
    _titleLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, rightBgView.frame.size.width-20, 40)];
    _titleLable.text = @"油价双底构筑，上行势如破竹";
    [rightBgView addSubview:_titleLable];
    
    _editorLabler = [[UILabel alloc]initWithFrame:CGRectMake(_titleLable.frame.origin.x, CGRectGetMaxY(_titleLable.frame), 40, 20)];
    _editorLabler.font = [UIFont systemFontOfSize:12.0f];
    _editorLabler.text = @"编者语:";
    _editorLabler.textColor = [UIColor redColor];
    [rightBgView addSubview:_editorLabler];
    
    _textLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_editorLabler.frame), _editorLabler.frame.origin.y, rightBgView.frame.size.width-60, 20)];
    _textLable.text = @"油价已从2月低位反弹逾85%";
    _textLable.font = [UIFont systemFontOfSize:12.0f];
    [rightBgView addSubview:_textLable];
}
-(void)configModel:(DaysInvestmentModel *)model{
    _titleLable.text = model.titleString;
    _dateLable.text = model.dateString;
    _timeLable.text = model.timeString;
    _textLable.text = model.textString;
    _Id = model.IdString;
}
@end