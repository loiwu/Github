//
//  NETAPISubmission.m
//  NETKit
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import "NETKit.h"
#import "NETAPISubmission.h"
#import "NETNetworkActivityController.h"

#import "XMLDocument.h"

#import "NSDictionary+Parameters.h"

@implementation NETAPISubmission
@synthesize submission;

- (void)dealloc {
    [submission release];
    
    [super dealloc];
}

- (id)initWithSession:(NETSession *)session_ submission:(NETSubmission *)submission_ {
    if ((self = [super init])) {
        session = session_;
        submission = [submission_ retain];
        loadingState = kNETAPISubmissionLoadingStateReady;
    }
    
    return self;
}

- (void)_completedSuccessfully:(BOOL)successfully withError:(NSError *)error {
    loadingState = kNETAPISubmissionLoadingStateReady;
    
    if ([submission respondsToSelector:@selector(submissionCompletedSuccessfully:withError:)])
        [submission submissionCompletedSuccessfully:successfully withError:error];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection_ {
    [NETNetworkActivityController networkActivityEnded];
    
    NSString *result = [[[NSString alloc] initWithData:received encoding:NSUTF8StringEncoding] autorelease];
    [received release];
    received = nil;
    [connection release];
    connection = nil;
    
    if (loadingState == kNETAPISubmissionLoadingStateFormTokens) {
        loadingState = kNETAPISubmissionLoadingStateFormSubmit;
        
        XMLDocument *document = [[XMLDocument alloc] initWithHTMLData:[result dataUsingEncoding:NSUTF8StringEncoding]];
        [document autorelease];
        
        NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
        [session addCookiesToRequest:request];
        
        if ([submission type] == kNETSubmissionTypeSubmission) {
            XMLElement *element = [document firstElementMatchingPath:@"//input[@name='fnid']"];
            
            NSDictionary *query = [NSDictionary dictionaryWithObjectsAndKeys:
                                   [element attributeWithName:@"value"], @"fnid",
                                   [submission title] ?: @"", @"t",
                                   [[submission destination] absoluteString] ?: @"", @"u",
                                   [submission body] ?: @"", @"x",
                                   nil];
            
            [request setURL:[[NSURL URLWithString:@"/r" relativeToURL:kNETWebsiteURL] absoluteURL]];
            [request setHTTPMethod:@"POST"];
            [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
            [request setHTTPBody:[[[query queryString] substringFromIndex:1] dataUsingEncoding:NSUTF8StringEncoding]];
        } else if ([submission type] == kNETSubmissionTypeVote) {
            NSString *dir = [submission direction] == kNETVoteDirectionUp ? @"up" : @"down";
            NSString *query = [NSString stringWithFormat:@"//a[@id='%@_%@']", dir, [[submission target] identifier]];
            XMLElement *element = [document firstElementMatchingPath:query];
            
            if (element == nil) {
                NSError *error = [NSError errorWithDomain:@"" code:0 userInfo:[NSDictionary dictionaryWithObject:@"Voting not allowed." forKey:NSLocalizedDescriptionKey]];
                [self _completedSuccessfully:NO withError:error];
                return;
            } else {
                NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@/%@", kNETWebsiteHost, [element attributeWithName:@"href"]]];
                [request setURL:url];
            }
        } else if ([submission type] == kNETSubmissionTypeReply) {
            XMLElement *element = [document firstElementMatchingPath:@"//input[@name='fnid']"];
            
            if (element == nil) {
                NSError *error = [NSError errorWithDomain:@"" code:0 userInfo:[NSDictionary dictionaryWithObject:@"Replying not allowed." forKey:NSLocalizedDescriptionKey]];
                [self _completedSuccessfully:NO withError:error];
                return;
            } else {
                NSDictionary *query = [NSDictionary dictionaryWithObjectsAndKeys:
                                       [element attributeWithName:@"value"], @"fnid",
                                       [submission body], @"text",
                                       nil];
                
                [request setURL:[[NSURL URLWithString:@"/r" relativeToURL:kNETWebsiteURL] absoluteURL]];
                [request setHTTPMethod:@"POST"];
                [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
                [request setHTTPBody:[[[query queryString] substringFromIndex:1] dataUsingEncoding:NSUTF8StringEncoding]];
            }
        } else if ([submission type] == kNETSubmissionTypeFlag) {
            XMLElement *element = [document firstElementMatchingPath:@"//a[text()='flag' and starts-with(@href,'/r?fnid=')]"];
            
            if (element == nil) {
                NSError *error = [NSError errorWithDomain:@"" code:0 userInfo:[NSDictionary dictionaryWithObject:@"Flagging not allowed." forKey:NSLocalizedDescriptionKey]];
                [self _completedSuccessfully:NO withError:error];
                return;
            } else {
                NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@%@", kNETWebsiteHost, [element attributeWithName:@"href"]]];
                [request setURL:url];
            }
        }
        
        connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        [connection start];
        
        [NETNetworkActivityController networkActivityBegan];
    } else if (loadingState == kNETAPISubmissionLoadingStateFormSubmit) {
        [self _completedSuccessfully:YES withError:nil];
    }
}

- (void)connection:(NSURLConnection *)connection_ didFailWithError:(NSError *)error {
    [NETNetworkActivityController networkActivityEnded];
    
    [received release];
    received = nil;
    
    [self _completedSuccessfully:NO withError:error];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [received appendData:data];
}

- (void)performSubmission {
    received = [[NSMutableData alloc] init];
    
    loadingState = kNETAPISubmissionLoadingStateFormTokens;
    
    NSURL *url = nil;
    
    if ([submission type] == kNETSubmissionTypeSubmission) {
        NSString *base = [NSString stringWithFormat:@"http://%@/%@", kNETWebsiteHost, @"submit"];
        url = [NSURL URLWithString:base];
    } else {
        url = [[submission target] URL];
    }
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [session addCookiesToRequest:request];
    
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];
    
    [NETNetworkActivityController networkActivityBegan];
}

- (BOOL)isLoading {
    return loadingState != kNETAPISubmissionLoadingStateReady;
}

@end

