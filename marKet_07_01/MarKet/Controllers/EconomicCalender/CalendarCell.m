//
//  CalendarCell.m
//  MarKet
//
//  Created by Aaron Lee on 16/3/11.
//  Copyright © 2016年 Secret. All rights reserved.
//

#import "CalendarCell.h"
#define WIDTH [[UIScreen mainScreen] bounds].size.width
@implementation CalendarCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor=[UIColor whiteColor];
        //日期
        _DateLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 5, 80, 10)];
        _DateLabel.font=[UIFont systemFontOfSize:14.0];
        _DateLabel.text=@"2016-03-07";
        _DateLabel.textColor=[UIColor blackColor];
        [self.contentView addSubview:_DateLabel];
        //图片
        _Imgv=[[UIImageView alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(_DateLabel.frame)+20, 50, 30)];
        _Imgv.backgroundColor=[UIColor blueColor];
        [self.contentView addSubview:_Imgv];
        //详细信息
        _DetailLabel=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_Imgv.frame)+10, CGRectGetMaxY(_DateLabel.frame)+5, WIDTH-110, 35)];
        _DetailLabel.font=[UIFont systemFontOfSize:13.0];
        _DetailLabel.text=@"美国2月22日当周货币供给M1";
        _DetailLabel.numberOfLines=0;
        [self.contentView addSubview:_DetailLabel];
        //前值
        _AdvanceLabel=[[UILabel alloc]initWithFrame:CGRectMake(_DetailLabel.frame.origin.x, CGRectGetMaxY(_DetailLabel.frame), _DetailLabel.frame.size.width/6, 20)];
        _AdvanceLabel.font=[UIFont systemFontOfSize:11.0];
        _AdvanceLabel.text=@"前值";
        [self.contentView addSubview:_AdvanceLabel];
        //前值数值
        _AdvanceNumLabel=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_AdvanceLabel.frame), CGRectGetMaxY(_DetailLabel.frame), _DetailLabel.frame.size.width/6, 20)];
        _AdvanceNumLabel.font=[UIFont systemFontOfSize:10.0];
        _AdvanceNumLabel.text=@"653";
        [self.contentView addSubview:_AdvanceNumLabel];
        //预期
        _ExpectLabel=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_AdvanceNumLabel.frame), CGRectGetMaxY(_DetailLabel.frame),  _DetailLabel.frame.size.width/6, 20)];
        _ExpectLabel.font=[UIFont systemFontOfSize:11.0];
        _ExpectLabel.text=@"预期";
        [self.contentView addSubview:_ExpectLabel];
        //预期数值
        _ExpectNumLabel=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_ExpectLabel.frame), CGRectGetMaxY(_DetailLabel.frame), _DetailLabel.frame.size.width/6, 20)];
        _ExpectNumLabel.font=[UIFont systemFontOfSize:10.0];
        _ExpectNumLabel.text=@"---";
        [self.contentView addSubview:_ExpectNumLabel];
        //实际
        _ActualLabel=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_ExpectNumLabel.frame), CGRectGetMaxY(_DetailLabel.frame), _DetailLabel.frame.size.width/6, 20)];
        _ActualLabel.font=[UIFont systemFontOfSize:13.0];
        _ActualLabel.text=@"实际";
        [self.contentView addSubview:_ActualLabel];
        //实际数值
        _ActualNumLabel=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_ActualLabel.frame), CGRectGetMaxY(_DetailLabel.frame), _DetailLabel.frame.size.width/6, 20)];
        _ActualNumLabel.font=[UIFont systemFontOfSize:13.0];
        _ActualNumLabel.text=@"---";
        [self.contentView addSubview:_ActualNumLabel];
    }
    return self;
}
#pragma mark 刷新cell
- (void)Refresh{
    
}
#pragma mark 绘制cell的边框
- (void)drawRect:(CGRect)rect{
    //创建路径并获取句柄
    CGMutablePathRef path = CGPathCreateMutable();
    //指定矩形
    CGRect rectangle=CGRectMake(10, 20, WIDTH-20, 55);
    //将矩形添加到路径中
    CGPathAddRect(path,NULL,rectangle);
    //获取上下文
    CGContextRef currentContext=UIGraphicsGetCurrentContext();
    //将路径添加到上下文
    CGContextAddPath(currentContext, path);
    //设置矩形填充色
    [[UIColor whiteColor]setFill];
    //矩形边框颜色
    [[UIColor colorWithRed:197/255.0 green:164/255.0 blue:103/255.0 alpha:1.0]setStroke];
    //边框宽度
    CGContextSetLineWidth(currentContext,2.0);
    CGContextClosePath(currentContext);
    CGContextDrawPath(currentContext, kCGPathFillStroke);
}
@end
