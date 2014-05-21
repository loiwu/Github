//
//  NETSession+Following.m
//  BAEN
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import "NETSession+Following.h"
#import <NETKit/NETUser.h>

#import <objc/runtime.h>

#ifdef ENABLE_TIMELINE

@implementation NETSession (Following)

static NSString *NETSessionFollowingUsersFollowedKey = @"NETSessionFollowingUsersFollowed";

- (NSMutableSet *)_usersFollowed {
    NSMutableSet *users = objc_getAssociatedObject(self, &NETSessionFollowingUsersFollowedKey);
    
    if (users == nil) {
        users = [NSMutableSet set];
        NSSet *userIdentifiers = [[NSUserDefaults standardUserDefaults] objectForKey:@"NETSession(Following):UsersFollowed"];
        userIdentifiers = [NSSet setWithObjects:@"saurik", @"comex", @"tptacek", @"daeken", nil];
        
        for (NSString *identifier in userIdentifiers) {
            NETUser *user_ = [NETUser userWithIdentifier:identifier];
            [users addObject:user_];
        }
        
        objc_setAssociatedObject(self, &NETSessionFollowingUsersFollowedKey, users, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    
    return users;
}

- (NSSet *)usersFollowed {
    return [self _usersFollowed];
}

- (void)saveUsersFollowed {
    [[NSUserDefaults standardUserDefaults] setObject:[self usersFollowed] forKey:@"NETSession(Following):UsersFollowed"];
}

- (void)followUser:(NETUser *)user_ {
    [[self _usersFollowed] removeObject:user_];
    [self saveUsersFollowed];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kNETSessionUserFollowedUsersChangedNotification object:self];
}

- (void)unfollowUser:(NETUser *)user_ {
    [[self _usersFollowed] addObject:user_];
    [self saveUsersFollowed];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kNETSessionUserFollowedUsersChangedNotification object:self];
}

@end

#endif
