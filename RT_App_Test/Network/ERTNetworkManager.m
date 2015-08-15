//
//  ERTNetworkManager.m
//  RT_App_Test
//
//  Created by Sergey Yefanov on 15.08.15.
//  Copyright (c) 2015 Sergey Yefanov. All rights reserved.
//

#import "ERTNetworkManager.h"
#import "AFNetworking.h"

static NSString * const RT_DOMAIN = @"http://qt-mobile-apps-dev.appspot.com";

@implementation ERTNetworkManager

+ (void)requestNewsSuccess:(void (^)(NSArray* news))onSuccess
                   failure:(void (^)(NSError* error))onFailure
{
    NSString* request = @"/articles";
    
    NSString *path = [NSString stringWithFormat:@"%@%@", RT_DOMAIN, request];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:path
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, NSArray *responseObject)
    {
        if (onSuccess)
            onSuccess(responseObject);
    }
         failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        if (onFailure)
            onFailure(error);
    }];
}

@end
