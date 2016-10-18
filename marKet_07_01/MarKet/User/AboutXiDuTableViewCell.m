//
//  AboutXiDuTableViewCell.m
//  MarKet
//
//  Created by Aaron Lee on 16/3/17.
//  Copyright © 2016年 Secret. All rights reserved.
//

#import "AboutXiDuTableViewCell.h"
#define WIDTH CGRectGetWidth([UIScreen mainScreen].bounds)
@implementation AboutXiDuTableViewCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor=[UIColor whiteColor];
        _IconImgv=[[UIImageView alloc]initWithFrame:CGRectMake(10, 7, 36, 36)];
        _IconImgv.layer.cornerRadius=18;
        [self.contentView addSubview:_IconImgv];
        
        _TitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_IconImgv.frame)+20, 17.5, 80, 15)];
        _TitleLabel.font=[UIFont systemFontOfSize:15.0];
        [self.contentView addSubview:_TitleLabel];
    }
    return self;
}
@end