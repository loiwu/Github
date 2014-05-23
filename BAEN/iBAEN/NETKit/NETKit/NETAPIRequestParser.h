//
//  NETAPIRequestParser.h
//  NETKit
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import "NETKit.h"

@interface NETAPIRequestParser : NSObject

- (NSDictionary *)parseWithString:(NSString *)string;
- (BOOL)stringIsProcrastinationError:(NSString *)string;
- (BOOL)stringIsExpiredError:(NSString *)string;

@end

