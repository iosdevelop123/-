//
//  ProfitSkillCell.h
//  MarKet
//
//  Created by Secret Wang on 16/3/22.
//  Copyright © 2016年 Secret. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfitSkillModel.h"

@interface ProfitSkillCell : UITableViewCell
@property (strong,nonatomic) UILabel* skill;
@property (strong,nonatomic) UILabel* dateLable;
@property (strong,nonatomic) UILabel* titleLable;
@property (strong,nonatomic) UILabel* antistopLabel;
@property (strong,nonatomic) UILabel* wordLable;
@property(copy,nonatomic) NSString* idString;

-(void)configModel:(ProfitSkillModel*)model;
@end