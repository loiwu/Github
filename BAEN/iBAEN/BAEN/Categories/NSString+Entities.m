//
//  NSString+Entities.m
//  BAEN
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import "NSString+Entities.h"


@implementation NSString (Entities)

- (NSString *)stringByDecodingHTMLEntities {
    NSUInteger myLength = [self length];
    NSUInteger ampIndex = [self rangeOfString:@"&" options:NSLiteralSearch].location;
    
    if (ampIndex == NSNotFound) return self;
    
    NSMutableString *result = [NSMutableString stringWithCapacity:(myLength * 1.25f)];
    
    // First iteration doesn't need to scan to & since we did that already, but for code simplicity's sake we'll do it again with the scanner.
    NSScanner *scanner = [NSScanner scannerWithString:self];
    [scanner setCharactersToBeSkipped:nil];
    
    NSCharacterSet *boundaryCharacterSet = [NSCharacterSet characterSetWithCharactersInString:@" \t\n\r;"];
    
    do {
        NSString *nonEntityString;
        if ([scanner scanUpToString:@"&" intoString:&nonEntityString]) {
            [result appendString:nonEntityString];
        }
        
        if ([scanner isAtEnd]) goto finish;
        
        if ([scanner scanString:@"&amp;" intoString:NULL]) {
            [result appendString:@"&"];
        } else if ([scanner scanString:@"&apos;" intoString:NULL]) {
            [result appendString:@"'"];
        } else if ([scanner scanString:@"&quot;" intoString:NULL]) {
            [result appendString:@"\""];
        } else if ([scanner scanString:@"&lt;" intoString:NULL]) {
            [result appendString:@"<"];
        } else if ([scanner scanString:@"&gt;" intoString:NULL]) {
            [result appendString:@">"];
        } else if ([scanner scanString:@"&#" intoString:NULL]) {
            BOOL gotNumber;
            unsigned charCode;
            NSString *xForHex = @"";
            
            // Is it hex or decimal?
            if ([scanner scanString:@"x" intoString:&xForHex]) {
                gotNumber = [scanner scanHexInt:&charCode];
            }
            else {
                gotNumber = [scanner scanInt:(int*)&charCode];
            }
            
            if (gotNumber) {
                [result appendFormat:@"%u", charCode];
                [scanner scanString:@";" intoString:NULL];
            } else {
                NSString *unknownEntity = nil;
                [scanner scanUpToCharactersFromSet:boundaryCharacterSet intoString:&unknownEntity];
                [result appendFormat:@"&#%@%@", xForHex, unknownEntity];
            }
        } else {
            NSString *amp;
            
            [scanner scanString:@"&" intoString:&amp];      //an isolated & symbol
            [result appendString:amp];
        }
    } while (![scanner isAtEnd]);
    
finish:
    return result;
}

@end
