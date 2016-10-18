//
//  ImportantNewsModel.h
//  MarKet
//
//  Created by Aaron Lee on 16/7/21.
//  Copyright © 2016年 Secret. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImportantNewsModel : NSObject
@property (copy,nonatomic) NSString *DetailLabel;//详细信息
@property (copy,nonatomic) NSString *PicStr;//图片字符串
@property (copy,nonatomic) NSString *timestamp;//时间戳
@property (copy,nonatomic) NSString *TimeStr;//时间字符串
@property(nonatomic,copy) NSString* Id;
@end
