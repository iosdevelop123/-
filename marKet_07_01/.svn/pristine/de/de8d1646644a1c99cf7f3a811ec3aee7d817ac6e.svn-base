//
//  ImportantNewsCell.m
//  Market
//
//  Created by Aaron Lee on 16/3/7.
//  Copyright © 2016年 dayu. All rights reserved.
//

#import "ImportantNewsCell.h"
#import "UIImageView+WebCache.h"
#define WIDTH [[UIScreen mainScreen] bounds].size.width
@implementation ImportantNewsCell
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor=[UIColor colorWithRed:243/255.0 green:244/255.0 blue:245/255.0 alpha:1.0];
        //图片
        _Imgv=[[UIImageView alloc]initWithFrame:CGRectMake(16, 25, 70, 40)];
        _Imgv.layer.cornerRadius=3.5;
        [_Imgv setImage:[UIImage imageNamed:@"newImg"]];
        [self.contentView  addSubview:_Imgv];
        //详细信息
        _DetailLabel=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_Imgv.frame)+5, 20, WIDTH-110, 40)];
        _DetailLabel.font=[UIFont systemFontOfSize:14.0];
        _DetailLabel.text=@"【策略分析（160307）】大盘分化权重护主。全球动荡金银逞...";
        _DetailLabel.numberOfLines=0;
        [self.contentView  addSubview:_DetailLabel];
        //时间
        _TimeLabel=[[UILabel alloc]initWithFrame:CGRectMake(15, 6, 150, 10)];
        _TimeLabel.font=[UIFont systemFontOfSize:12.0];
        _TimeLabel.text=@"09:08:43";
        _TimeLabel.textColor=[UIColor blackColor];
        [self.contentView  addSubview:_TimeLabel];
    }
    return self;
}

#pragma mark 刷新cell
- (void)refresh:(ImportantNewsModel *)model{
    //刷新图片
    [_Imgv sd_setImageWithURL:[NSURL URLWithString:model.PicStr] placeholderImage:[UIImage imageNamed:@"newImg"]];
    //刷新详情
    _DetailLabel.text=model.DetailLabel;
    //刷新时间
    _TimeLabel.text=model.TimeStr;
}
#pragma mark 绘制cell的边框
- (void)drawRect:(CGRect)rect{
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    // 简便起见，这里把圆角半径设置10
    CGFloat radius = 10;
    
    // 获取CGContext，注意UIKit里用的是一个专门的函数
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 移动到初始点
    CGContextMoveToPoint(context, 20, 20);
    
    // 绘制第1条线和第1个1/4圆弧
    CGContextAddLineToPoint(context, width-20, 20);
    //CGContextRef不解释了，x,y为圆点坐标，startAngle为开始的弧度，endAngle为 结束的弧度，clockwise 0为顺时针/1为逆时针。
    CGContextAddArc(context, width-20, 30, radius, -0.5 * M_PI, 0.0, 0);
    
    // 绘制第2条线和第2个1/4圆弧
    CGContextAddLineToPoint(context, width-10, height-20);
    CGContextAddArc(context, width-20, height-20, radius, 0.0, 0.5 * M_PI, 0);
    
    // 绘制第3条线和第3个1/4圆弧
    CGContextAddLineToPoint(context, 20, height-10);
    CGContextAddArc(context, 20, height-20, radius, 0.5 * M_PI, M_PI, 0);
    
    // 绘制第4条线和第4个1/4圆弧
    CGContextAddLineToPoint(context, 10, 30);
    CGContextAddArc(context, 20, 30, radius, M_PI, 1.5 * M_PI, 0);
    
    //矩形边框颜色
    [[UIColor colorWithRed:197/255.0 green:164/255.0 blue:103/255.0 alpha:1.0]setStroke];
    //边框宽度
    CGContextSetLineWidth(context,1.0);
    // 闭合路径
    CGContextClosePath(context);
    // 填充半透明黑色
    CGContextSetRGBFillColor(context, 0.0, 0.5, 0.0, 0.5);
    //设置矩形填充色
    [[UIColor whiteColor]setFill];
    CGContextDrawPath(context, kCGPathFillStroke);
}
@end