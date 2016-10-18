//
//  BaseWebRequest.h
//  MarKet
//
//  Created by dayu on 16/4/20.
//  Copyright © 2016年 Secret. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@interface BaseWebRequest : NSObject
@property (strong,nonatomic) AFURLSessionManager *manager;
- (void)webRequestWithAPI:(NSString *)api CompletionHandler:(void (^)(NSURLResponse *response, id responseObject, NSError *error))completionHandler;
@end
