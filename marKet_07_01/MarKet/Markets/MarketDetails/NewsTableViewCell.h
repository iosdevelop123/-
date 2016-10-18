//
//  NewsTableViewCell.h
//  MarKet
//
//  Created by Secret Wang on 16/3/21.
//  Copyright © 2016年 Secret. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"

@interface NewsTableViewCell : UITableViewCell
@property (strong,nonatomic) UILabel* dateLbale;
@property (strong,nonatomic) UILabel* timeLable;
@property (strong,nonatomic) UIImageView* picImage;
@property (strong,nonatomic) UILabel* titleLable;
-(void)configModel:(NewsModel*)model;
@end