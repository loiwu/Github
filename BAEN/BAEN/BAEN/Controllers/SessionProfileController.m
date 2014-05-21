//
//  SessionProfileController.m
//  BAEN
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import "UIActionSheet+Context.h"

#import "SessionProfileController.h"
#import "LoginController.h"
#import "HackerNewsLoginController.h"
#import "NavigationController.h"
#import "PlacardButton.h"
#import "SubmissionListController.h"

#import "AppDelegate.h"

@implementation SessionProfileController

- (BOOL)showSessionListButton {
    return [[NETSessionController sessionController] numberOfSessions] == 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)table {
    return [super numberOfSectionsInTableView:tableView] + ([self showSessionListButton] ? 1 : 0);
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return [super tableView:table numberOfRowsInSection:section] + 1;
    } else if (section == 2) {
        return 1;
    } else {
        return [super tableView:table numberOfRowsInSection:section];
    }
}

- (UITableViewCell *)tableView:(UITableView *)table cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath section] == 1 && [indexPath row] == [tableView numberOfRowsInSection:[indexPath section]] - 1) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        
        [[cell textLabel] setText:@"Saved"];
        
        return [cell autorelease];
    } else if ([indexPath section] == 2) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        [[cell textLabel] setTextAlignment:NSTextAlignmentCenter];
        [[cell textLabel] setText:@"Accounts"];
        
        return [cell autorelease];
    } else {
        return [super tableView:table cellForRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)table didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath section] == 1 && [indexPath row] == [tableView numberOfRowsInSection:[indexPath section]] - 1) {
        NETEntryList *list = [NETEntryList session:[source session] entryListWithIdentifier:kNETEntryListIdentifierSaved user:(NETUser *) source];
        
        SubmissionListController *controller = [[SubmissionListController alloc] initWithSource:list];
        [controller setTitle:@"Saved"];
        [[self navigation] pushController:[controller autorelease] animated:YES];
    } else if ([indexPath section] == 2) {
        [[self navigation] requestSessions];
    } else {
        [super tableView:table didSelectRowAtIndexPath:indexPath];
    }
}

AUTOROTATION_FOR_PAD_ONLY

@end
