//
//  ProfitSkillCell.m
//  MarKet
//
//  Created by Secret Wang on 16/3/22.
//  Copyright © 2016年 Secret. All rights reserved.
//

#import "ProfitSkillCell.h"

#define SIZE [UIScreen mainScreen].bounds.size
@implementation ProfitSkillCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createView];
    }
    return self;
}
-(void)createView{
    _skill = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 60, 15)];
    _skill.text = @"[盈利技巧]";
    _skill.font = [UIFont systemFontOfSize:12.0f];
    _skill.textColor = [UIColor redColor];
    [self.contentView addSubview:_skill];
    
    _dateLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_skill.frame), 10, 120, 15)];
    _dateLable.font = [UIFont systemFontOfSize:12.0f];
    _dateLable.textColor = [UIColor redColor];
    _dateLable.text = @"2016-02-22";
    [self.contentView addSubview:_dateLable];
    
    _titleLable = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(_skill.frame), SIZE.width-20, 30)];
    _titleLable.text = @"沙特或利用OPEC会议加强团结";
    _titleLable.font = [UIFont systemFontOfSize:16.0f];
    [self.contentView addSubview:_titleLable];
    
    _antistopLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(_titleLable.frame), 40, 15)];
    _antistopLabel.text = @"关键词:";
//    _antistopLabel.backgroundColor = [UIColor blueColor];
    _antistopLabel.textColor = [UIColor redColor];
    _antistopLabel.font = [UIFont systemFontOfSize:12.0f];
    [self.contentView addSubview:_antistopLabel];
    
    _wordLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_antistopLabel.frame), _antistopLabel.frame.origin.y, SIZE.width-80, 15)];
    _wordLable.font = [UIFont systemFontOfSize:12.0f];
    _wordLable.text = @"沙特,利用,OPEC,会议，知情人";
    [self.contentView addSubview:_wordLable];
}

-(void)configModel:(ProfitSkillModel *)model{
    _dateLable.text = model.dateString;
    _titleLable.text = model.titleString;
//    _antistopLabel.text = model.antistopString;
    _wordLable.text = model.Keywords;
    _idString = model.Id;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
@end