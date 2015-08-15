//
//  ERTNetworkManager.m
//  RT_App_Test
//
//  Created by Sergey Yefanov on 15.08.15.
//  Copyright (c) 2015 Sergey Yefanov. All rights reserved.
//

#import "ERTNetworkManager.h"
#import "RestKit.h"
#import "ERTNews.h"

static NSString * const RT_DOMAIN = @"http://qt-mobile-apps-dev.appspot.com";

@implementation ERTNetworkManager

+ (void)initRestKit
{
    RKObjectMapping* newsMapping = [RKObjectMapping mappingForClass:[ERTNews class]];
    [newsMapping addAttributeMappingsFromDictionary:@{
                                                      @"title":   @"title",
                                                      @"url" : @"url",
                                                      @"image" : @"image",
                                                      @"summary" : @"summary",
                                                      @"like_count" : @"likeCount",
                                                      @"time" : @"time",
                                                      @"id" : @"internalId"
                                                      }];
    
    NSURL* baseURL = [NSURL URLWithString:RT_DOMAIN];
    AFHTTPClient* client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    [RKObjectManager setSharedManager:[[RKObjectManager alloc] initWithHTTPClient:client]];
    
    RKResponseDescriptor* descriptor = [RKResponseDescriptor responseDescriptorWithMapping:newsMapping
                                                                                           method:RKRequestMethodGET
                                                                                      pathPattern:@"/articles"
                                                                                          keyPath:nil
                                                                                      statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [[RKObjectManager sharedManager] addResponseDescriptor:descriptor];
}

+ (void)requestNewsSuccess:(void (^)(NSArray* news))onSuccess
                   failure:(void (^)(NSError* error))onFailure
{
    NSString* path = @"/articles";
    
    [[RKObjectManager sharedManager] getObjectsAtPath:path
                                           parameters:nil
                                              success:^(RKObjectRequestOperation* operation, RKMappingResult* mappingResult)
     {
         if (onSuccess)
             onSuccess(mappingResult.array);
     }
                                              failure:^(RKObjectRequestOperation* operation, NSError* error)
     {
         if (onFailure)
             onFailure(error);
     }];
    
}

@end
