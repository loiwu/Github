//
//  SessionListController.m
//  BAEN
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import "SessionListController.h"
#import "MainTabBarController.h"
#import "BarButtonItem.h"
#import "AppDelegate.h"
#import "BAENLoginController.h"
#import "ModalNavigationController.h"

@implementation SessionListController
@synthesize automaticDisplaySession;

#pragma mark - Lifecycle

- (id)init {
    if ((self = [super init])) {
        [self setTitle:@"Accounts"];
    }
    
    return self;
}

- (void)loadView {
    [super loadView];
    
    tableView = [[UITableView alloc] initWithFrame:[[self view] bounds]];
    [tableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [tableView setDelegate:self];
    [tableView setDataSource:self];
    [tableView setRowHeight:64.0f];
    [[self view] addSubview:tableView];
    
    addBarButtonItem = [[BarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addSessionFromBarButtonItem:)];
    editBarButtonItem = [[BarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editFromBarButtonItem:)];
    doneBarButtonItem = [[BarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneFromBarButtonItem:)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[self navigationItem] setRightBarButtonItem:addBarButtonItem];
    [[self navigationItem] setLeftBarButtonItem:editBarButtonItem];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSIndexPath *selectedIndexPath = [tableView indexPathForSelectedRow];
    NETSession *session = nil;
    
    if (selectedIndexPath != nil) {
        session = [self sessionAtIndexPath:selectedIndexPath];
    }
    
    [self reloadSessions];
    [tableView reloadData];
    
    if (selectedIndexPath != nil) {
        NSIndexPath *newIndexPath = [self indexPathForSession:session];
        
        if (newIndexPath != nil) {
            [tableView selectRowAtIndexPath:newIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
            [tableView deselectRowAtIndexPath:newIndexPath animated:YES];
        }
    }
    
    if (!animated) {
        [self pushAutomaticDisplaySesssionAnimated:animated];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (animated) {
        [self pushAutomaticDisplaySesssionAnimated:animated];
    }
    
    [[NETSessionController sessionController] setRecentSession:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    if ([tableView isEditing]) {
        [tableView setEditing:NO animated:NO];
        [[self navigationItem] setLeftBarButtonItem:editBarButtonItem];
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    /*if ([self respondsToSelector:@selector(topLayoutGuide)] && [self respondsToSelector:@selector(bottomLayoutGuide)]) {
     UIEdgeInsets insets = UIEdgeInsetsMake([[self topLayoutGuide] length], 0, [[self bottomLayoutGuide] length], 0);
     [tableView setScrollIndicatorInsets:insets];
     [tableView setContentInset:insets];
     }*/
}

- (void)viewDidUnload {
    [super viewDidUnload];
    
    [tableView release];
    tableView = nil;
    [sessions release];
    sessions = nil;
    [editBarButtonItem release];
    editBarButtonItem = nil;
    [doneBarButtonItem release];
    doneBarButtonItem = nil;
    [addBarButtonItem release];
    addBarButtonItem = nil;
}

- (void)dealloc {
    [tableView release];
    [sessions release];
    [automaticDisplaySession release];
    
    [super dealloc];
}

#pragma mark - Sessions

- (void)reloadSessions {
    [sessions release];
    sessions = [[[NETSessionController sessionController] sessions] retain];
}

- (void)pushMainControllerForSession:(NETSession *)session animated:(BOOL)animated {
    [[NETSessionController sessionController] setRecentSession:session];
    
    NSIndexPath *indexPath = [self indexPathForSession:session];
    if (indexPath != nil) {
        [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    
    MainTabBarController *tabBarController = [[MainTabBarController alloc] initWithSession:session];
    
    BOOL hideBackButton = [session isAnonymous] || ([sessions count] == 1);
    [[tabBarController navigationItem] setHidesBackButton:hideBackButton];
    
    [[self navigation] pushController:tabBarController animated:animated];
    [tabBarController release];
}

- (void)pushAnonymousSessionIfNecessaryAnimated:(BOOL)animated {
    if ([sessions count] == 0) {
        NETAnonymousSession *anonymousSession = [[NETAnonymousSession alloc] init];
        [self pushMainControllerForSession:anonymousSession animated:animated];
        [anonymousSession release];
    }
}

- (void)pushAutomaticDisplaySesssionAnimated:(BOOL)animated {
    if (automaticDisplaySession != nil) {
        [self pushMainControllerForSession:automaticDisplaySession animated:animated];
        [automaticDisplaySession release];
        automaticDisplaySession = nil;
    } else {
        [self pushAnonymousSessionIfNecessaryAnimated:animated];
    }
}

#pragma mark - Bar Button Items

- (void)editFromBarButtonItem:(BarButtonItem *)barButtonItem {
    [tableView setEditing:YES animated:YES];
    [[self navigationItem] setLeftBarButtonItem:doneBarButtonItem animated:YES];
}

- (void)doneFromBarButtonItem:(BarButtonItem *)barButtonItem {
    [tableView setEditing:NO animated:YES];
    [[self navigationItem] setLeftBarButtonItem:editBarButtonItem animated:YES];
}

- (void)navigationController:(NavigationController *)navigationController didLoginWithSession:(NETSession *)session {
    if ([navigationController topViewController] != self) {
        [self setAutomaticDisplaySession:session];
        [[self navigation] popToController:self animated:YES];
    } else {
        [self pushMainControllerForSession:session animated:YES];
    }
}

- (void)navigationControllerRequestedSessions:(NavigationController *)navigationController {
    [[self navigation] popToController:self animated:YES];
}

- (void)addSessionFromBarButtonItem:(BarButtonItem *)barButtonItem {
    [[self navigation] requestLogin];
}

#pragma mark - Table View

- (NETSession *)sessionAtIndexPath:(NSIndexPath *)indexPath {
    return [sessions objectAtIndex:[indexPath row]];
}

- (NSIndexPath *)indexPathForSession:(NETSession *)session {
    NSInteger index = [sessions indexOfObject:session];
    
    if (index == NSNotFound) {
        return nil;
    } else {
        return [NSIndexPath indexPathForRow:index inSection:0];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [sessions count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView_ cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier"];
    if (cell == nil) cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellIdentifier"] autorelease];
    
    NETSession *session = [self sessionAtIndexPath:indexPath];
    [[cell textLabel] setText:[[session user] identifier]];
    
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NETSession *session = [self sessionAtIndexPath:indexPath];
    [self pushMainControllerForSession:session animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView_ moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    NETSession *session = [self sessionAtIndexPath:sourceIndexPath];
    [[NETSessionController sessionController] moveSession:session toIndex:[destinationIndexPath row]];
    [self reloadSessions];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView_ commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [tableView beginUpdates];
        
        NETSession *session = [self sessionAtIndexPath:indexPath];
        [[NETSessionController sessionController] removeSession:session];
        [self reloadSessions];
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        [tableView endUpdates];
        
        [self pushAnonymousSessionIfNecessaryAnimated:YES];
    }
}

@end

