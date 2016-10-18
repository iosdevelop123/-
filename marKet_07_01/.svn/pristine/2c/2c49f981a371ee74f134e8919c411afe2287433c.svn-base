//
//  AnswerTableViewCell.m
//  MarKet
//
//  Created by Secret Wang on 16/5/16.
//  Copyright © 2016年 Secret. All rights reserved.
//

#import "AnswerTableViewCell.h"
#define SIZE [[UIScreen mainScreen] bounds].size
@implementation AnswerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return self;
}
-(void)initUI{
    UIImageView* qimage = [[UIImageView alloc]initWithFrame:CGRectMake(5, 35, 30, 30)];
    qimage.image = [UIImage imageNamed:@"a"];
    [self.contentView addSubview:qimage];
    
    _aTime = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SIZE.width, 40)];
    _aTime.text = @"2016-12-23 00:00:00";
    _aTime.textAlignment = NSTextAlignmentCenter;
    _aTime.font = [UIFont systemFontOfSize:14.0f];
    [self.contentView addSubview:_aTime];
    
    _qn = [[UILabel alloc]initWithFrame:CGRectMake(40, 30, 200, 40)];
    _qn.font = [UIFont systemFontOfSize:14.0f];
    _qn.text = @"盛夏的果实";
    _qn.textColor = [UIColor colorWithRed:0.36 green:0.62 blue:0.91 alpha:1.00];
    [self.contentView addSubview:_qn];
    
    _q = [[UILabel alloc]initWithFrame:CGRectMake(40, 70, SIZE.width-60, 40)];
    _q.font = [UIFont systemFontOfSize:14.0f];
    _q.numberOfLines = 0;
    _q.text = @"今天下午全市多云到阴有阵雨或雷雨";
    [self.contentView addSubview:_q];
    
    _aimage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 105, 30, 30)];
    _aimage.image = [UIImage imageNamed:@"da"];
//    _aimage.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:_aimage];
    
    _an = [[UILabel alloc]initWithFrame:CGRectMake(40, 100, 200, 40)];
    _an.text = @"VIP投资顾问";
    _an.textColor = [UIColor colorWithRed:0.36 green:0.62 blue:0.91 alpha:1.00];
    _an.font = [UIFont systemFontOfSize:14.0f];
    [self.contentView addSubview:_an];
    
    _a = [[UILabel alloc]initWithFrame:CGRectMake(40, CGRectGetMaxY(_an.frame), SIZE.width-60, 40)];
    _a.text = @"天下午全市多云到阴有阵雨或雷雨";
    _a.font = [UIFont systemFontOfSize:16.0f];
    _a.numberOfLines = 0;
    [self.contentView addSubview:_a];
}


-(void)configModel:(AnswerModel *)model{
    _aTime.text = model.qt;
    _qn.text = model.qn;
    
    _q.text = model.q;
    CGSize size = [self frameWithLabel:_q String:_q.text];
    _q.frame = CGRectMake(40, _q.frame.origin.y, SIZE.width-60, size.height);
    
    _an.text = model.an;
    _an.frame = CGRectMake(40, CGRectGetMaxY(_q.frame), 200, 40);
    _aimage.frame = CGRectMake(5, _an.frame.origin.y+5, 30, 30) ;
    
    _a.text = model.a;
    CGSize Ansize = [self frameWithLabel:_a String:_a.text];
    _a.frame = CGRectMake(40, CGRectGetMaxY(_an.frame), SIZE.width-50, Ansize.height);
    
    CGRect frame = self.frame;
    frame.size.height = _q.frame.size.height + 20 +50 + 40 + _a.frame.size.height;
    self.frame = frame;
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
