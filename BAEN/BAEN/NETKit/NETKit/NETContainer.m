//
//  NETContainer.m
//  NETKit
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import "NETContainer.h"
#import "NETAPIRequest.h"
#import "NETEntry.h"

#import "NSURL+Parameters.h"

@implementation NETContainer
@synthesize entries, moreToken;

- (void)loadFromDictionary:(NSDictionary *)dictionary complete:(BOOL)complete {
    [self setMoreToken:[dictionary objectForKey:@"more"]];
    
    [super loadFromDictionary:dictionary complete:complete];
}

- (void)loadMoreFromDictionary:(NSDictionary *)dictionary complete:(BOOL)complete {
    pendingMoreEntries = [[self entries] retain];
    [self loadFromDictionary:dictionary complete:complete];
    [pendingMoreEntries release];
    pendingMoreEntries = nil;
}

- (BOOL)isLoadingMore {
    return [self hasLoadingState:kNETContainerLoadingStateLoadingMore];
}

- (void)beginLoadingMore {
    if ([self isLoadingMore] || moreToken == nil || ![self isLoaded]) return;
    
    [self addLoadingState:kNETContainerLoadingStateLoadingMore];
    
    NSURL *moreURL = [NSURL URLWithString:moreToken];
    
    NSString *path = [moreURL path];
    if ([path hasPrefix:@"/"]) path = [path substringFromIndex:[@"/" length]];
    NSDictionary *parameters = [moreURL parameterDictionary];
    if (parameters == nil) parameters = [NSDictionary dictionary];
    
    moreRequest = [[NETAPIRequest alloc] initWithSession:session target:self action:@selector(moreRequest:completedWithResponse:error:)];
    [moreRequest performRequestWithPath:path parameters:parameters];
}

- (void)cancelLoadingMore {
    [self clearLoadingState:kNETContainerLoadingStateLoadingMore];
    [moreRequest cancelRequest];
    [moreRequest release];
    moreRequest = nil;
}

- (void)beginLoadingWithState:(NETObjectLoadingState)state_ {
    [self cancelLoadingMore];
    [super beginLoadingWithState:state_];
}

- (void)moreRequest:(NETAPIRequest *)request completedWithResponse:(NSDictionary *)response error:(NSError *)error {
    [self clearLoadingState:kNETContainerLoadingStateLoadingMore];
    [moreRequest release];
    moreRequest = nil;
    
    if (error == nil) {
        [self loadMoreFromDictionary:response complete:YES];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kNETObjectFinishedLoadingNotification object:self];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:kNETObjectFailedLoadingNotification object:self];
    }
}

@end

