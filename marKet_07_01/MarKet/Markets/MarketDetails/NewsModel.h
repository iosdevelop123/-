//
//  NewsModel.h
//  MarKet
//
//  Created by Secret Wang on 16/3/21.
//  Copyright © 2016年 Secret. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsModel : NSObject
@property (strong,nonatomic) NSString*dateString;
@property (strong,nonatomic) NSString*timeString;
@property (strong,nonatomic) NSString*imageString;
@property (strong,nonatomic) NSString*titleString;
@end