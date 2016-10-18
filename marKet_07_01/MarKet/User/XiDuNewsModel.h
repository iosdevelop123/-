//
//  XiDuNewsModel.h
//  MarKet
//
//  Created by Aaron Lee on 16/4/18.
//  Copyright © 2016年 Secret. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XiDuNewsModel : NSObject
@property (copy,nonatomic) NSString *Senddate;//日期
@property (copy,nonatomic) NSString *Title;//详细信息
@property (copy,nonatomic) NSString *Keywords;//关键词内容
@property(nonatomic,copy) NSString* Id;
@end
