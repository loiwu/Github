//
//  NSDictionary+Parameters.m
//  NETKit
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import "NSDictionary+Parameters.h"
#import "NSString+URLEncoding.h"

@implementation NSDictionary (Parameters)

- (NSString *)queryString {
    NSMutableArray *parameters = [NSMutableArray array];
    for (NSString *key in [self allKeys]) {
        NSString *escapedk = [key stringByURLEncodingString];
        NSString *v = [[self objectForKey:key] isKindOfClass:[NSString class]] ? [self objectForKey:key] : [[self objectForKey:key] stringValue];
        NSString *escapedv = [v stringByURLEncodingString];
        [parameters addObject:[NSString stringWithFormat:@"%@=%@", escapedk, escapedv]];
    }
    
    NSString *query = [parameters count] > 0 ? @"?" : @"";
    query = [query stringByAppendingString:[parameters componentsJoinedByString:@"&"]];
    return query;
}

@end
