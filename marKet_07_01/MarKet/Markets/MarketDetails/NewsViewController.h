//
//  NewsViewController.h
//  MarKet
//
//  Created by Secret Wang on 16/3/21.
//  Copyright © 2016年 Secret. All rights reserved.
//
#import <UIKit/UIKit.h>
@interface NewsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(copy,nonatomic) void(^callBackToMainView)();
@end