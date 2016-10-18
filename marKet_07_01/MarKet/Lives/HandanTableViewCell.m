//
//  HandanTableViewCell.m
//  MarKet
//
//  Created by Secret Wang on 16/5/9.
//  Copyright © 2016年 Secret. All rights reserved.
//

#import "HandanTableViewCell.h"

@implementation HandanTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.backView.layer.borderColor = [UIColor colorWithRed:0.78 green:0.62 blue:0.36 alpha:1.00].CGColor;
    _TypeLable.transform=CGAffineTransformMakeRotation(-M_PI/4);
    _type.transform=CGAffineTransformMakeRotation(-M_PI/4);
    _open.transform=CGAffineTransformMakeRotation(-M_PI/4);
    _sell.transform=CGAffineTransformMakeRotation(-M_PI/4);
    _OpenPriceLable.transform=CGAffineTransformMakeRotation(-M_PI/4);
    _ClosingPriceLable.transform=CGAffineTransformMakeRotation(-M_PI/4);
    // Configure the view for the selected state
}
-(void)configModel:(HandanModel *)model{
    _IdLabele.text = [NSString stringWithFormat:@"%@",model.Id];
    _OpenTimeLabel.text = model.OpenTime;
    _PositionLable.text =[NSString stringWithFormat:@"%@", model.Position];
    _TypeLable.text = model.Type;
    _OpenPriceLable.text =[NSString stringWithFormat:@"%@", model.OpenPrice];
    _StopLossPriceLable.text = [NSString stringWithFormat:@"%@",model.StopLossPrice];
    _StopGainPriceLable.text =[NSString stringWithFormat:@"%@",model.StopGainPrice];
    _GainPercentLable.text =[NSString stringWithFormat:@"%@",model.GainPercent];
    _ClosingPriceLable.text =[NSString stringWithFormat:@"%@",model.ClosingPrice];
    _ClosingTimeLable.text = model.ClosingTime;
}
@end
