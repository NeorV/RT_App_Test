//
//  NSDate+RT.h
//  RT_App_Test
//
//  Created by Sergey Yefanov on 15.08.15.
//  Copyright (c) 2015 Sergey Yefanov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (RT)

+ (NSDate *)rtStyleToDate:(NSString *)rtStyleDate;
+ (NSString *)rtStyleToString:(NSString *)rtStyleDate;
- (NSString*)rtDateString;

@end
