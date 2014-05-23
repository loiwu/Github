//
//  NETSessionController.m
//  NETKit
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import "NETSessionController.h"
#import "NETSession.h"
#import "NETAnonymousSession.h"
#import "NETObjectCache.h"

NSString *kNETSessionControllerSessionsChangedNotification = @"NETSessionControllerSessionsChangedNotification";

@implementation NETSessionController
@synthesize recentSession;

+ (id)sessionController {
    static NETSessionController *sessionController = nil;
    
    static dispatch_once_t sessionControllerToken;
    dispatch_once(&sessionControllerToken, ^{
        sessionController = [[NETSessionController alloc] init];
    });
    
    return sessionController;
}

- (id)init {
    if ((self = [super init])) {
        sessions = [[NSMutableArray alloc] init];
        
        // FIXME: This should use the Keychain, not NSUserDefaults.
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        
        NSArray *allSessionsArray = [userDefaults objectForKey:@"NETKit:NETSessionController:Sessions"];
        NSString *recentIdentifier = [userDefaults objectForKey:@"NETKit:NETSessionController:RecentSession"];
        
        for (NSDictionary *sessionDictionary in allSessionsArray) {
            NETSession *session = [[NETSession alloc] initWithSessionDictionary:sessionDictionary];
            [sessions addObject:session];
            [session release];
            
            if ([recentIdentifier isEqualToString:[session identifier]]) {
                [self setRecentSession:session];
            }
        }
        
        NETSessionToken token = (NETSessionToken) [userDefaults objectForKey:@"NETKit:SessionToken"];
        NSString *password = [userDefaults objectForKey:@"NETKit:SessionPassword"];
        NSString *name = [userDefaults objectForKey:@"NETKit:SessionName"];
        
        if (token != nil && password != nil && name != nil) {
            // Restore old-style single-account sessions.
            NETSession *session = [[NETSession alloc] initWithUsername:name password:password token:token];
            [self addSession:session];
            [self setRecentSession:session];
            [session release];
            
            [userDefaults removeObjectForKey:@"NETKit:SessionToken"];
            [userDefaults removeObjectForKey:@"NETKit:SessionPassword"];
            [userDefaults removeObjectForKey:@"NETKit:SessionName"];
        }
    }
    
    return self;
}

- (NSArray *)sessions {
    return [[sessions copy] autorelease];
}

- (void)refresh {
    for (NETSession *session in sessions) {
        [session reloadToken];
    }
}

- (NSInteger)numberOfSessions {
    return [sessions count];
}

- (void)setRecentSession:(NETSession *)recentSession_ {
    // This wouldn't even make sense.
    if ([recentSession_ isAnonymous]) return;
    
    [recentSession release];
    recentSession = [recentSession_ retain];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:[recentSession identifier] forKey:@"NETKit:NETSessionController:RecentSession"];
    [userDefaults synchronize];
}

- (void)saveSessions {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *allSessionsArray = [NSMutableArray array];
    
    for (NETSession *session in sessions) {
        NSDictionary *sessionDictionary = [session sessionDictionary];
        [allSessionsArray addObject:sessionDictionary];
    }
    
    [userDefaults setObject:allSessionsArray forKey:@"NETKit:NETSessionController:Sessions"];
    [userDefaults synchronize];
}

- (void)addSession:(NETSession *)session {
    NSAssert(![session isAnonymous], @"Sessions must not be anonymous.");
    
    [sessions addObject:session];
    [self saveSessions];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kNETSessionControllerSessionsChangedNotification object:self];
}

- (void)removeSession:(NETSession *)session {
    [[session cache] clearPersistentCache];
    
    [sessions removeObject:session];
    [self saveSessions];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kNETSessionControllerSessionsChangedNotification object:self];
}

- (void)moveSession:(NETSession *)session toIndex:(NSInteger)index {
    NSInteger from = [sessions indexOfObject:session];
    
    [session retain];
    [sessions removeObjectAtIndex:from];
    
    if (index >= [sessions count]) {
        [sessions addObject:session];
    } else {
        [sessions insertObject:session atIndex:index];
    }
    
    [session release];
    
    [self saveSessions];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kNETSessionControllerSessionsChangedNotification object:self];
}

@end
