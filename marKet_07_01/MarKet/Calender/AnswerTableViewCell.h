//
//  AnswerTableViewCell.h
//  MarKet
//
//  Created by Secret Wang on 16/5/16.
//  Copyright © 2016年 Secret. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnswerModel.h"

@interface AnswerTableViewCell : UITableViewCell

@property (strong,nonatomic) UILabel* qn;
@property (strong,nonatomic) UILabel* q;
@property (strong,nonatomic) UILabel* an;
@property (strong,nonatomic) UILabel* a;
@property (strong,nonatomic) UILabel* aTime;
@property (strong,nonatomic) UILabel* maohao;

@property (strong,nonatomic) UIImageView* aimage;

-(void)configModel:(AnswerModel*)model;
@end
