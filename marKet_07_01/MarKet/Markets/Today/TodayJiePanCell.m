//
//  TodayJiePanCell.m
//  MarKet
//
//  Created by Secret Wang on 16/4/11.
//  Copyright © 2016年 Secret. All rights reserved.
//

#import "TodayJiePanCell.h"

#define WIDTH [[UIScreen mainScreen] bounds].size.width
@implementation TodayJiePanCell
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor=[UIColor whiteColor];
        [self createView];
    }
    return self;
}
#pragma mark ****** 创建视图
-(void)createView{
    //背景视图
    UIView *backgroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 60)];
    backgroundView.backgroundColor=[UIColor colorWithRed:247/255.0 green:248/255.0 blue:249/255.0 alpha:1.0];
    [self.contentView addSubview:backgroundView];
    //今日说盘
    _JiePanLabel=[[UILabel alloc]initWithFrame:CGRectMake(45, 15, 100, 10)];
    _JiePanLabel.font=[UIFont systemFontOfSize:12.0];
    _JiePanLabel.text=@"【今日解说】";
    _JiePanLabel.textColor=[UIColor colorWithRed:199/255.0 green:131/255.0 blue:119/255.0 alpha:1.0];
    [backgroundView addSubview:_JiePanLabel];
    //时间
    _TimeLabel=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_JiePanLabel.frame)+5, _JiePanLabel.frame.origin.y, 80, 12)];
    _TimeLabel.font=[UIFont systemFontOfSize:12.0];
    _TimeLabel.text=@"2016-03-02";
    _TimeLabel.textColor=[UIColor colorWithRed:199/255.0 green:131/255.0 blue:119/255.0 alpha:1.0];
    [backgroundView addSubview:_TimeLabel];
    //播放器图片
    _PlayerImgv=[[UIImageView alloc]initWithFrame:CGRectMake(15, 20, 20, 20)];
    [_PlayerImgv setImage:[UIImage imageNamed:@"bctb"]];
    [backgroundView addSubview:_PlayerImgv];
    //今日说盘信息
    _DetailLabel=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_PlayerImgv.frame)+15, CGRectGetMaxY(_JiePanLabel.frame)+5, WIDTH-30, 15)];
    _DetailLabel.font=[UIFont systemFontOfSize:15.0];
    _DetailLabel.textColor=[UIColor blackColor];
    _DetailLabel.text=@"API大幅利空，EIA前预期行情震荡回落";
    _DetailLabel.numberOfLines=0;
    [backgroundView addSubview:_DetailLabel];
}


-(void)configModel:(TodayModel *)model
{
    _TimeLabel.text = model.data;
    _DetailLabel.text = model.title;
    _Id = model.Id;
}

@end
