//
//  MainTabBarController.h
//  BAEN
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import "BarButtonItem.h"

#import "LoginController.h"
#import "TabBarController.h"

@class EntryListController, SessionProfileController, MoreController, SearchController, NETSession;

@interface MainTabBarController : UITabBarController <UIActionSheetDelegate, UITabBarControllerDelegate> {
    NETSession *session;
    
    EntryListController *home;
    EntryListController *latest;
	SearchController *search;
    SessionProfileController *profile;
    MoreController *more;
    
    BarButtonItem *composeItem;
}

- (id)initWithSession:(NETSession *)session_;

@end

