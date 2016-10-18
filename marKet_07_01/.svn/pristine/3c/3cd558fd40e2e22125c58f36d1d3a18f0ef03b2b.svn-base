//
//  BaseWebRequest.m
//  MarKet
//
//  Created by dayu on 16/4/20.
//  Copyright © 2016年 Secret. All rights reserved.
//

#import "BaseWebRequest.h"

@implementation BaseWebRequest
- (void)webRequestWithAPI:(NSString *)api CompletionHandler:(void (^)(NSURLResponse *response, id responseObject, NSError *error))completionHandler{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    if (_manager == nil) {  _manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration]; }
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:api]];
    NSURLSessionDataTask *dataTask = [_manager dataTaskWithRequest:request completionHandler:completionHandler];
    [dataTask resume];
}

@end
