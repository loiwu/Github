//
//  InstapaperSession.h
//  BAEN
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import "InstapaperAPI.h"

@interface InstapaperSession : NSObject {
    NSString *username;
    NSString *password;
}

+ (id)currentSession;
+ (void)setCurrentSession:(id)session;
+ (void)logoutIfNecessary;

@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *password;

- (BOOL)canAddItems;

@end

