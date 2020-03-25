//
//  Extend_Description.m
//  100Data
//
//  Created by Lee on 14-3-14.
//  Copyright (c) 2014年 Djc. All rights reserved.
//

#import "Extend_Description.h"

@implementation NSDictionary (Extend_Description)

@end

@implementation NSArray (Extend_Description)
- (NSString *)description
{
    NSData *data = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
    NSString *query = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return query;
}
@end

