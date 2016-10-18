//
//  NewsTableViewCell.m
//  MarKet
//
//  Created by Secret Wang on 16/3/21.
//  Copyright © 2016年 Secret. All rights reserved.
//

#import "NewsTableViewCell.h"
#import "UIImageView+WebCache.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width

@implementation NewsTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createView];
    }
    return self;
}
-(void)createView{
    _dateLbale = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 80, 18)];
    _dateLbale.font = [UIFont systemFontOfSize:12.0f];
    _dateLbale.text = @"2016-03-23";
    [self.contentView addSubview:_dateLbale];
    
    _timeLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_dateLbale.frame), 10, 80, 18)];
    _timeLable.font = [UIFont systemFontOfSize:12.0f];
    _timeLable.text = @"24:08:44";
    [self.contentView addSubview:_timeLable];
    
    UIView* bgView = [[UIView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_dateLbale.frame), WIDTH-20, 72)];
    bgView.backgroundColor = [UIColor colorWithRed:0.98 green:0.96 blue:0.93 alpha:1.00];
    //    bgView.backgroundColor = [UIColor redColor];
    bgView.layer.cornerRadius = 4;
    bgView.layer.masksToBounds = YES;
    bgView.layer.borderWidth = 1;
    bgView.layer.borderColor = [UIColor colorWithRed:0.84 green:0.70 blue:0.46 alpha:1.00].CGColor;
    [self.contentView addSubview:bgView];
    
    _picImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 70, 50)];
    _picImage.backgroundColor = [UIColor redColor];
    _picImage.layer.cornerRadius = 3;
    _picImage.layer.masksToBounds = YES;
    [bgView addSubview:_picImage];
    
    _titleLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_picImage.frame)+10, _picImage.frame.origin.y, WIDTH-100, 50)];
    _titleLable.text = @"库存意外利多，美油王者归来";
    _titleLable.numberOfLines = 2;
    [bgView addSubview:_titleLable];
}

-(void)configModel:(NewsModel *)model{
    _dateLbale.text = model.dateString;
    _timeLable.text = model.timeString;
    [_picImage sd_setImageWithURL:[NSURL URLWithString:model.imageString] placeholderImage:[UIImage imageNamed:@""]];
    _titleLable.text = model.titleString;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
@end