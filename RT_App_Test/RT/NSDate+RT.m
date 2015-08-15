//
//  NSDate+RT.m
//  RT_App_Test
//
//  Created by Sergey Yefanov on 15.08.15.
//  Copyright (c) 2015 Sergey Yefanov. All rights reserved.
//

#import "NSDate+RT.h"

@implementation NSDate (RT)

+ (NSDate *)rtStyleToDate:(NSString *)rtStyleDate
{
    NSString *year = [rtStyleDate substringWithRange:NSMakeRange(0, 4)];
    NSString *month = [rtStyleDate substringWithRange:NSMakeRange(4, 2)];
    NSString *day = [rtStyleDate substringWithRange:NSMakeRange(6, 2)];
    NSString *hour = [rtStyleDate substringWithRange:NSMakeRange(9, 2)];
    NSString *minute = [rtStyleDate substringWithRange:NSMakeRange(11, 2)];
    NSString *second = [rtStyleDate substringWithRange:NSMakeRange(13, 2)];
    
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setYear:year.integerValue];
    [dateComponents setMonth:month.integerValue];
    [dateComponents setDay:day.integerValue];
    [dateComponents setHour:hour.integerValue];
    [dateComponents setMinute:minute.integerValue];
    [dateComponents setSecond:second.integerValue];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *configuredDate = [calendar dateFromComponents:dateComponents];
    return configuredDate;
}

+ (NSString *)rtStyleToString:(NSString *)rtStyleDate
{
    NSDate *date = [self rtStyleToDate:rtStyleDate];
    return [date rtDateString];
}

- (NSString*)rtDateString
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"dd MMM yyyy hh:mm:ss"];
    formatter.locale = [NSLocale localeWithLocaleIdentifier:@"ru"];
    NSString *stringFromDate = [formatter stringFromDate:self];
    return stringFromDate;
}

@end
