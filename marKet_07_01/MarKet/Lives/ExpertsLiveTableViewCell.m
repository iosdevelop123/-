//
//  ExpertsLiveTableViewCell.m
//  Market
//
//  Created by pan on 16/3/4.
//  Copyright © 2016年 dayu. All rights reserved.
//

#import "ExpertsLiveTableViewCell.h"
@implementation ExpertsLiveTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor colorWithRed:205/255.0 green:206/255.0 blue:207/255.0 alpha:1.0];
        _headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 60, 60)];
        _headImageView.layer.cornerRadius = 30;
        _headImageView.layer.masksToBounds = YES;
        [self.contentView addSubview:_headImageView];
        
        _nickNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 73, 60, 13)];
        _nickNameLabel.textAlignment = NSTextAlignmentCenter;
        _nickNameLabel.textColor = [UIColor colorWithRed:147/255.0 green:101/255.0 blue:44/255.0 alpha:1.0];
        _nickNameLabel.font = [UIFont systemFontOfSize:13.0];
        [self.contentView addSubview:_nickNameLabel];
        
        _contentTextLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 10,self.contentView.bounds.size.width-40, 60)];
        _contentTextLabel.backgroundColor = [UIColor whiteColor];
        _contentTextLabel.textColor = [UIColor grayColor];
        _contentTextLabel.layer.cornerRadius = 7;
        _contentTextLabel.layer.masksToBounds = YES;
        [self.contentView addSubview:_contentTextLabel];
        
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
@end