//
//  NAnswerTableViewCell.m
//  MarKet
//
//  Created by Secret Wang on 16/5/12.
//  Copyright © 2016年 Secret. All rights reserved.
//

#import "NAnswerTableViewCell.h"

#define SIZE [UIScreen mainScreen].bounds.size
@implementation NAnswerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}
#pragma mark ****** 创建界面
-(void)createUI{
    UIImageView* qimage = [[UIImageView alloc]initWithFrame:CGRectMake(5, 35, 30, 30)];
    qimage.image = [UIImage imageNamed:@"q"];
//    qimage.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:qimage];
    
    _qn = [[UILabel alloc]initWithFrame:CGRectMake(40, 30, 120, 40)];
    _qn.text = @"盛夏的果实";
    _qn.font = [UIFont systemFontOfSize:14.0f];
    [self.contentView addSubview:_qn];
    
    _q = [[UILabel alloc]initWithFrame:CGRectMake(40, 70, SIZE.width-50, 40)];
    _q.text = @"今天下午全市多云到阴有阵雨或雷雨";
    _q.numberOfLines = 0;
    _q.font = [UIFont systemFontOfSize:14.0f];
    [self.contentView addSubview:_q];
    
    _qtime = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SIZE.width, 40)];
    _qtime.text = @"2016-22-22  00:00:00";
    _qtime.font = [UIFont systemFontOfSize:14.0f];
    _qtime.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_qtime];
}
-(void)configModel:(NAnswerModel *)model
{
    _qn.text = model.qn;
    _q.text = model.q;
    CGSize qsize = [self frameWithLabel:_q String:_q.text];
    _q.frame = CGRectMake(40, _q.frame.origin.y, SIZE.width-50, qsize.height);

    _qtime.text = model.qtime;
    CGRect qframe = _q.frame;
    qframe.size.height = _q.frame.size.height + 50+20;
    
    self.frame = qframe;
}
-(CGSize)frameWithLabel:(UILabel*)lable String:(NSString*)str{
    CGSize size = [str boundingRectWithSize:CGSizeMake(lable.frame.size.width, CGFLOAT_MAX)
                                    options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                 attributes:[NSDictionary dictionaryWithObjectsAndKeys:lable.font,NSFontAttributeName, nil]
                                    context:nil].size;
    return size;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
