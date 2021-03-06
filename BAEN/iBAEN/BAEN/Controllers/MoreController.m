//
//  MoreController.m
//  BAEN
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import <NETKit/NETKit.h>

#import "MoreController.h"
#import "ProfileController.h"
#import "ProfileHeaderView.h"
#import "SubmissionListController.h"
#import "CommentListController.h"
#import "BrowserController.h"

#import "AppDelegate.h"

@implementation MoreController

- (id)initWithSession:(NETSession *)session_ {
    if ((self = [super init])) {
        session = [session_ retain];
    }
    
    return self;
}

- (void)dealloc {
    [tableView release];
    [session release];
    
    [super dealloc];
}

- (void)loadView {
    [super loadView];
    
    tableView = [[ColorfulTableView alloc] initWithFrame:[[self view] bounds]];
    [tableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [tableView setDelegate:self];
    [tableView setDataSource:self];
    [[self view] addSubview:tableView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"More"];
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
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [tableView setColorful:![[NSUserDefaults standardUserDefaults] boolForKey:@"disable-colorful"]];
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)table {
    return 3;
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0: return 4;
        case 1: return 2;
        case 2: return 3;
        default: return 0;
    }
}

- (CGFloat)tableView:(UITableView *)table heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 44.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    if ([indexPath section] == 0) {
        if ([indexPath row] == 0) {
            [[cell textLabel] setText:@"Best Submissions"];
        } else if ([indexPath row] == 1) {
            [[cell textLabel] setText:@"Active Discussions"];
        } else if ([indexPath row] == 2) {
            [[cell textLabel] setText:@"Classic View"];
        } else if ([indexPath row] == 3) {
            [[cell textLabel] setText:@"Ask NET"];
        }
    } else if ([indexPath section] == 1) {
        if ([indexPath row] == 0) {
            [[cell textLabel] setText:@"Best Comments"];
        } else if ([indexPath row] == 1) {
            [[cell textLabel] setText:@"New Comments"];
        }
    } else if ([indexPath section] == 2) {
        if ([indexPath row] == 0) {
            [[cell textLabel] setText:@"About BAEN"];
        } else if ([indexPath row] == 1) {
            [[cell textLabel] setText:@"BAEN homepage"];
        } else if ([indexPath row] == 2) {
            [[cell textLabel] setText:@"Facebook BAEN"];
        }
    }
    
    return [cell autorelease];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"Submissions";
    } else if (section == 1) {
        return @"Comments";
    } else if (section == 2) {
        return @"Other";
    }
    
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    if (section == 2) {
        return [NSString stringWithFormat:@"newsBAEN version %@.\n\nFor more information on any of ourservices, please call 1-800-943-8883 (925-484-0395) or email us at info@bayequest.com\n\nIf you want to promote the equine industry, we want to partner with you.", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] ?: [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]];
    }
    
    return nil;
}

- (void)tableView:(UITableView *)table didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NETEntryListIdentifier type = nil;
    NSString *title = nil;
    Class controllerClass = nil;
    
    if ([indexPath section] == 0) {
        if ([indexPath row] == 0) {
            type = kNETEntryListIdentifierBestSubmissions;
            title = @"Best Submissions";
            controllerClass = [SubmissionListController class];
        } else if ([indexPath row] == 1) {
            type = kNETEntryListIdentifierActiveSubmissions;
            title = @"Active";
            controllerClass = [SubmissionListController class];
        } else if ([indexPath row] == 2) {
            type = kNETEntryListIdentifierClassicSubmissions;
            title = @"Classic";
            controllerClass = [SubmissionListController class];
        } else if ([indexPath row] == 3) {
            type = kNETEntryListIdentifierAskSubmissions;
            title = @"Ask NET";
            controllerClass = [SubmissionListController class];
        }
    } else if ([indexPath section] == 1) {
        if ([indexPath row] == 0) {
            type = kNETEntryListIdentifierBestComments;
            title = @"Best Comments";
            controllerClass = [CommentListController class];
        } else if ([indexPath row] == 1) {
            type = kNETEntryListIdentifierNewComments;
            title = @"New Comments";
            controllerClass = [CommentListController class];
        }
    } else if ([indexPath section] == 2) {
        if ([indexPath row] == 0) {
            BrowserController *controller = [[BrowserController alloc] initWithURL:kNETFAQURL]; //NETShared.h
            [[self navigation] pushController:[controller autorelease] animated:YES];
            return;
        } else if ([indexPath row] == 1) {
            BrowserController *controller = [[BrowserController alloc] initWithURL:[NSURL URLWithString:@"http://www.bayequest.info/"]];
            [[self navigation] pushController:[controller autorelease] animated:YES];
            return;
        } else if ([indexPath row] == 2) {
            BrowserController *controller = [[BrowserController alloc] initWithURL:[NSURL URLWithString:@"https://m.facebook.com/pages/Bay-Area-Equestrian-Network/317340896573?ref=ts"]];
            [[self navigation] pushController:[controller autorelease] animated:YES];
            return;
        }
    }
    
    NETEntryList *list = [NETEntryList session:session entryListWithIdentifier:type];
    UIViewController *controller = [[controllerClass alloc] initWithSource:list];
    [controller setTitle:title];
    
    if (controllerClass == [SubmissionListController class]) {
        [[self navigation] pushController:[controller autorelease] animated:YES];
    } else {
        [[self navigation] pushController:[controller autorelease] animated:YES];
    }
}

AUTOROTATION_FOR_PAD_ONLY

@end
