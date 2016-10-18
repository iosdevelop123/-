//
//  VarietiesView.m
//  Market
//
//  Created by Secret Wang on 16/3/4.
//  Copyright © 2016年 dayu. All rights reserved.
//

#import "VarietiesView.h"

@implementation VarietiesView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createVIew];
    }
    return self;
}
-(void)createVIew{
    _nameLable = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, self.frame.size.width-10, 20)];
    _nameLable.text = @"天猫有";
    _nameLable.textColor = [UIColor colorWithRed:0.86 green:0.86 blue:0.87 alpha:1];
    _nameLable.font = [UIFont systemFontOfSize:14.0f];
    [self addSubview:_nameLable];
    
    _priceLable = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_nameLable.frame), self.frame.size.width, 30)];
    _priceLable.text = @"123.456";
    _priceLable.font = [UIFont systemFontOfSize:22.0f];
    _priceLable.textColor = [UIColor colorWithRed:0.81 green:0 blue:0 alpha:1];
    _priceLable.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_priceLable];
    
    _zhishu = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width-40, CGRectGetMaxY(_priceLable.frame), 40, 20)];
    _zhishu.text = @"22.22%";
    _zhishu.textColor = [UIColor colorWithRed:0.45 green:0.08 blue:0.04 alpha:1];
    _zhishu.font = [UIFont systemFontOfSize:10.5f];
    [self addSubview:_zhishu];
    
    _changePrice = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width-80, _zhishu.frame.origin.y, 40, 20)];
    _changePrice.text = @"22.22";
    _changePrice.textAlignment = NSTextAlignmentCenter;
    _changePrice.textColor = [UIColor colorWithRed:0.45 green:0.08 blue:0.04 alpha:1];
    _changePrice.font = [UIFont systemFontOfSize:10.5f];
    [self addSubview:_changePrice];
    
    UIImageView* jiantou = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width-85, _changePrice.frame.origin.y+5, 5, 10)];
    jiantou.image = [UIImage imageNamed:@"redArrow"];
    [self addSubview:jiantou];
    
}
-(void)config:(VarietyModel *)model{
    _nameLable.text = model.nameString;
    _priceLable.text = model.profitString;
    _changePrice.text = model.changeProfitString;
    _zhishu.text = model.zhishuSting;
}
@end