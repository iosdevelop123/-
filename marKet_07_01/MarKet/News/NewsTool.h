//
//  NewsTool.h
//  MarKet
//
//  Created by Aaron Lee on 16/3/31.
//  Copyright © 2016年 Secret. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsTool : NSObject
+(NewsTool *)Instance;
//获取收藏内容
+ (NSArray *)getAllInfo;

//判断新闻是否已经收藏
+ (BOOL)judgeNewsId: (NSNumber *)newsId;

//删除收藏的新闻
+ (BOOL)deleteFavoriteNewsById: (NSNumber *)newsId;

//将新闻添加到收藏
+ (BOOL)addNewsToFavorite: (NSDictionary *)newsInfo content: (NSString *)newsContent date: (NSString *)date;

@end
