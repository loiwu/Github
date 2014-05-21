//
//  NETAPIRequest.m
//  NETKit
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import "NETKit.h"
#import "NETAPIRequest.h"

#import "NSDictionary+Parameters.h"

#import "NETNetworkActivityController.h"

@implementation NETAPIRequest

- (NETAPIRequest *)initWithSession:(NETSession *)session_ target:(id)target_ action:(SEL)action_ {
    if ((self = [super init])) {
        session = session_;
        target = target_;
        action = action_;
    }
    
    return self;
}

- (void)connection:(NSURLConnection *)connection_ didReceiveData:(NSData *)data {
    [received appendData:data];
}

- (void)connection:(NSURLConnection *)connection_ didFailWithError:(NSError *)error {
    [NETNetworkActivityController networkActivityEnded];
    [connection release];
    connection = nil;
    
    [target performSelector:action withObject:self withObject:nil withObject:error];
}

- (void)completeSuccessfullyWithResult:(NSDictionary *)result {
    [target performSelector:action withObject:self withObject:result withObject:nil];
}

- (void)completeUnsuccessfullyWithError:(NSError *)error {
    [target performSelector:action withObject:self withObject:nil withObject:error];
}

- (void)parseInBackground {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    NSString *resp = [[NSString alloc] initWithData:received encoding:NSUTF8StringEncoding];
    
    NSDictionary *result = nil;
    
    if ([resp length] > 0) {
        NETAPIRequestParser *parser = [[NETAPIRequestParser alloc] init];
        
        @try {
            if (![parser stringIsProcrastinationError:resp] && ![parser stringIsExpiredError:resp]) {
                result = [parser parseWithString:resp];
            }
        } @catch (NSException *e) {
            NSLog(@"NETAPIRequest: Exception parsing page at /%@ with reason \"%@\".", path, [e reason]);
        }
        
        [parser release];
    }
    
    if (result != nil) {
        [self performSelectorOnMainThread:@selector(completeSuccessfullyWithResult:) withObject:result waitUntilDone:YES];
    } else {
        NSError *error = [NSError errorWithDomain:@"error" code:100 userInfo:[NSDictionary dictionaryWithObject:@"Error scraping." forKey:NSLocalizedDescriptionKey]];
        [self performSelectorOnMainThread:@selector(completeUnsuccessfullyWithError:) withObject:error waitUntilDone:YES];
    }
    
    [resp release];
    [received release];
    received = nil;
    
    [pool release];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection_ {
    [NETNetworkActivityController networkActivityEnded];
    [connection release];
    connection = nil;
    
    [self performSelectorInBackground:@selector(parseInBackground) withObject:nil];
}

- (void)performRequestWithPath:(NSString *)path_ parameters:(NSDictionary *)parameters {
    path = [path_ copy];
    received = [[NSMutableData alloc] init];
    
    NSString *combined = [path stringByAppendingString:[parameters queryString]];
    NSURL *url = [NSURL URLWithString:combined relativeToURL:kNETWebsiteURL];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [session addCookiesToRequest:request];
    
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];
    
    [NETNetworkActivityController networkActivityBegan];
}

- (BOOL)isLoading {
    return connection != nil;
}

- (void)cancelRequest {
    if (connection != nil) {
        [NETNetworkActivityController networkActivityEnded];
        [connection cancel];
        [connection release];
        connection = nil;
    }
}

- (void)dealloc {
    [connection release];
    [received release];
    [path release];
    
    [super dealloc];
}

@end
