//
//  ERTNews.h
//  
//
//  Created by Sergey Yefanov on 15.08.15.
//
//

#import <Foundation/Foundation.h>

@interface ERTNews : NSObject

@property (nonatomic) NSString * title;
@property (nonatomic) NSString * url;
@property (nonatomic) NSString * image;
@property (nonatomic) NSString * summary;
@property (nonatomic) NSNumber * likeCount;
@property (nonatomic) NSString * time;
@property (nonatomic) NSString * internalId;

@end
