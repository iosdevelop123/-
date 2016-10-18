//
//  NAnswerTableViewCell.h
//  MarKet
//
//  Created by Secret Wang on 16/5/12.
//  Copyright © 2016年 Secret. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NAnswerModel.h"

@interface NAnswerTableViewCell : UITableViewCell
@property (strong,nonatomic) UILabel* qn;
@property (strong,nonatomic) UILabel* q;
@property (strong,nonatomic) UILabel* qtime;

-(void)configModel:(NAnswerModel*)model;

@end
