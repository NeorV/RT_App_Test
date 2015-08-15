//
//  ERTNetworkManager.h
//  RT_App_Test
//
//  Created by Sergey Yefanov on 15.08.15.
//  Copyright (c) 2015 Sergey Yefanov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ERTNetworkManager : NSObject

+ (void)requestNewsSuccess:(void (^)(NSArray* news))onSuccess
                   failure:(void (^)(NSError* error))onFailure;

@end
