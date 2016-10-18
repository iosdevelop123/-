//
//  NewsTool.m
//  MarKet
//
//  Created by Aaron Lee on 16/3/31.
//  Copyright © 2016年 Secret. All rights reserved.
//

#import "NewsTool.h"
//新闻详细信息关键字
#define KDETAILINFOTITLE @"title"
#define KDETAILINFOCONTENT @"content"
#define KDETAILINFODATE @"pub_date"
#define KDETAILINFOCOMMENTCOUNT @"reply_count"
static NewsTool *instance=nil;
@implementation NewsTool
#pragma 单例模式定义
+(NewsTool *)Instance
{
    @synchronized (self) {
        if (instance==nil) {
            instance=[[self alloc]init];
        }
    }
    return instance;
}

#pragma mark - 我的收藏相关

//获取收藏内容
+ (NSArray *)getAllInfo
{
    NSString *plistPath=[[NSBundle mainBundle]pathForResource:@"NewsPlist" ofType:@"plist"];
    NSMutableDictionary *favoriteNewDic=[[NSMutableDictionary alloc]initWithContentsOfFile:plistPath];
    return [favoriteNewDic allValues];
}

//判断新闻是否已经收藏
+ (BOOL)judgeNewsId: (NSNumber *)newsId
{
    NSString *plistPath=[[NSBundle mainBundle]pathForResource:@"NewsPlist" ofType:@"plist"];
    NSDictionary *favoriteNewDic = [[NSDictionary alloc] initWithContentsOfFile: plistPath];
    NSArray *newsIdArray = [favoriteNewDic allKeys];
    for (NSString *objectId in newsIdArray)
    {
        if ([objectId intValue] == [newsId intValue])
        {
            return YES;
        }
    }
    return NO;
}

//删除收藏的新闻
+ (BOOL)deleteFavoriteNewsById: (NSNumber *)newsId
{
    NSString *strId = [newsId stringValue];
    if (strId != nil && ![strId  isEqual: @""])
    {
        NSString *plistPath=[[NSBundle mainBundle]pathForResource:@"NewsPlist" ofType:@"plist"];
        NSMutableDictionary *favoriteNewDic = [[NSMutableDictionary alloc] initWithContentsOfFile: plistPath];        
        [favoriteNewDic removeObjectForKey: strId];
        BOOL result = [favoriteNewDic writeToFile: plistPath atomically: YES];
        return result;
    }
    else
    {
        return NO;
    }
}

//将新闻添加到我的收藏
+ (BOOL)addNewsToFavorite: (NSDictionary *)newsInfo content: (NSString *)newsContent date: (NSString *)date
{
    NSString *newsId = [[NSString alloc] initWithString: [[newsInfo objectForKey: @"newsId"] stringValue]];
    
    if (newsId != nil && ![newsId  isEqual: @""])
    {
        NSString *plistPath=[[NSBundle mainBundle]pathForResource:@"NewsPlist" ofType:@"plist"];
        NSString *imgPath = [NSHomeDirectory() stringByAppendingPathComponent: @"Documents/favorite/imgCache/"];
        NSFileManager *fileManage = [NSFileManager defaultManager];
        if (![fileManage fileExistsAtPath: imgPath])
        {
            [fileManage createDirectoryAtPath: imgPath withIntermediateDirectories: YES attributes:nil error:nil];
        }
        if (![fileManage fileExistsAtPath: plistPath])
        {
            [fileManage createFileAtPath: plistPath contents: nil attributes: nil];
        }
        
        NSMutableDictionary *favoriteNewDic = [[NSMutableDictionary alloc] initWithContentsOfFile: plistPath];
        if (favoriteNewDic == nil)
        {
            favoriteNewDic = [[NSMutableDictionary alloc] init];
        }
        
        NSMutableDictionary *newsDic = [[NSMutableDictionary alloc] init];
        [newsDic setObject: [newsInfo objectForKey: @"post_id"] forKey: @"id"];
        [newsDic setObject: [newsInfo objectForKey: @"post_url"] forKey: @"post_url"];
        [newsDic setObject: [newsInfo objectForKey: @"preview"] forKey: @"preview"];
        [newsDic setObject: [newsInfo objectForKey: @"title"] forKey: @"title"];
        [newsDic setObject:  date forKey: @"pub_date"];
        [newsDic setObject:  newsContent forKey: @"content"];
        
//      NSString *imgOldPath = [[XDDataCenter sharedCenter] getCacheImagePath: [newsInfo objectForKey: KINFOCELLIMG]];
        NSString *imgOldPath=[newsInfo objectForKey:@"picture"];
        if (imgOldPath && ![imgOldPath isEqualToString: @""])
        {
            NSString *imgName = [imgOldPath lastPathComponent];
            NSString *imgNewPath = [[NSString alloc] initWithFormat: @"%@/%@", imgPath, imgName];
            [fileManage copyItemAtPath: imgOldPath toPath: imgNewPath error: nil];
            [newsDic setObject: imgNewPath forKey: @"picture"];
        }
        else{
            [newsDic setObject: @"" forKey: @"picture"];
        }
        
        [favoriteNewDic setObject: newsDic forKey: newsId];

        BOOL result = [favoriteNewDic writeToFile: plistPath atomically: YES];
        
        return result;
    }
    else
    {
        return NO;
    }
}

@end
