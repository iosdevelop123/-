//
//  XiDuNewsCell.m
//  MarKet
//
//  Created by Aaron Lee on 16/4/18.
//  Copyright © 2016年 Secret. All rights reserved.
//

#import "XiDuNewsCell.h"
#define WIDTH [[UIScreen mainScreen] bounds].size.width
@implementation XiDuNewsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)Refresh:(XiDuNewsModel *)model{
    //刷新发布时间
    _DateLabel.text=model.Senddate;
    //刷新详情描述
    _TitleLabel.text=model.Title;
    //刷新关键词
    _KeywordsDetail.text=model.Keywords;
    //
    _Id=model.Id;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor=[UIColor whiteColor];
        //西都新闻
        _XiDuLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 5, 80, 10)];
        _XiDuLabel.font=[UIFont systemFontOfSize:13.0];
        _XiDuLabel.text=@"【西都新闻】";
        _XiDuLabel.textColor=[UIColor redColor];
        [self.contentView addSubview:_XiDuLabel];
        //日期
        _DateLabel=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_XiDuLabel.frame)+5, 5, 140, 10)];
        _DateLabel.font=[UIFont systemFontOfSize:12.0];
        _DateLabel.textColor=[UIColor redColor];
        [self.contentView addSubview:_DateLabel];
        //详细信息
        _TitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_DateLabel.frame)+5, WIDTH-20, 20)];
        _TitleLabel.font=[UIFont systemFontOfSize:15.0];
        [self.contentView addSubview:_TitleLabel];
        //关键字
        _KeywordsLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_TitleLabel.frame)+5, 40, 15)];
        _KeywordsLabel.font=[UIFont systemFontOfSize:12.0];
        _KeywordsLabel.text=@"关键词:";
        _KeywordsLabel.textColor=[UIColor redColor];
        [self.contentView addSubview:_KeywordsLabel];
        //关键字内容
        _KeywordsDetail=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_KeywordsLabel.frame)+5, CGRectGetMaxY(_TitleLabel.frame)+5, WIDTH-60, 15)];
        _KeywordsDetail.font=[UIFont systemFontOfSize:12.0];
        [self.contentView addSubview:_KeywordsDetail];
    }
    return self;
}

@end
