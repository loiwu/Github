//
//  NETSession+Following.h
//  BAEN
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import <NETKit/NETKit.h>

#ifdef ENABLE_TIMELINE

#define kNETSessionUserFollowedUsersChangedNotification @"NETSessionUserFollowedUsersChanged"

@interface NETSession (Following)

@property (nonatomic, readonly) NSSet *usersFollowed;

- (void)followUser:(NETUser *)user;
- (void)unfollowUser:(NETUser *)user;

@end

#endif
