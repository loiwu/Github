//
//  NETTimeline.m
//  BAEN
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import "NETTimeline.h"
#import "NETSession+Following.h"

#ifdef ENABLE_TIMELINE

@interface NETTimeline ()

@property (nonatomic, retain) NETSession *session;

@end

@implementation NETTimeline
@synthesize session;

+ (NETTimeline *)timelineForSession:(NETSession *)session {
    NETTimeline *timeline = [self entryListWithIdentifier:kNETEntryListIdentifierTimeline];
    [timeline setSession:session];
    return timeline;
}

- (NSURL *)URL {
    return nil;
}

- (id)init {
    if ((self = [super init])) {
        loadingUsers = [[NSMutableSet alloc] init];
        loadedUsers = [[NSMutableSet alloc] init];
    }
    
    return self;
}

- (void)dealloc {
    [loadingUsers release];
    [loadedUsers release];
    [session release];
    
    [super dealloc];
}

- (void)userFinishedLoadingWithNotification:(NSNotification *)notification {
    NETEntryList *list = (NETEntryList *) [notification object];
    [loadingUsers removeObject:list];
    [loadedUsers addObject:list];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNETObjectFinishedLoadingNotification object:list];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNETObjectFailedLoadingNotification object:list];
    
    if ([loadingUsers count] == 0) {
        NSMutableArray *comments = [NSMutableArray array];
        
        for (NETEntryList *list in loadedUsers) {
            [comments addObjectsFromArray:[list entries]];
        }
        
        [self setEntries:[comments sortedArrayUsingSelector:@selector(posted)]];
        
        [loadingUsers removeAllObjects];
        [loadedUsers removeAllObjects];
        
        [self setIsLoaded:YES];
    }
}

- (void)userFailedLoadingWithNotification:(NSNotification *)notification {
    NETEntryList *list = (NETEntryList *) [notification object];
    [loadingUsers removeObject:list];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNETObjectFinishedLoadingNotification object:list];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNETObjectFailedLoadingNotification object:list];
    
    [self cancelLoading];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kNETObjectFailedLoadingNotification object:self];
}

- (void)cancelLoading {
    for (NETEntryList *list in loadingUsers) {
        [list cancelLoading];
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:kNETObjectFinishedLoadingNotification object:list];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:kNETObjectFailedLoadingNotification object:list];
    }
    
    [loadingUsers removeAllObjects];
    [loadedUsers removeAllObjects];
}

- (void)beginLoadingWithState:(NETObjectLoadingState)state_ {
    [self addLoadingState:state_];
    
    if ([[session usersFollowed] count] == 0) {
        [self setIsLoaded:YES];
        
        return;
    }
    
    for (NETUser *user_ in [session usersFollowed]) {
        NETEntryList *list = [NETEntryList entryListWithIdentifier:kNETEntryListIdentifierUserComments user:user_];
        [loadingUsers addObject:list];
        
        // In case this ends loading before this method finishes executing, have
        // this run on the next iteration of the runloop, just to be safe.
        [list beginLoading];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userFinishedLoadingWithNotification:) name:kNETObjectFinishedLoadingNotification object:list];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userFailedLoadingWithNotification:) name:kNETObjectFailedLoadingNotification object:list];
    }
}

- (void)setSession:(NETSession *)session_ {
    [session autorelease];
    session = [session_ retain];
}

@end

#endif
