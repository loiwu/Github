//
//  CommentListController.m
//  BAEN
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import <NETKit/NETKit.h>

#import "UIActionSheet+Context.h"
#import "UINavigationItem+MultipleItems.h"
#import "EmptyView.h"

#import "CommentListController.h"
#import "CommentTableCell.h"
#import "DetailsHeaderView.h"
#import "EntryActionsView.h"
#import "ProfileController.h"
#import "NavigationController.h"
#import "EntryReplyComposeController.h"
#import "BrowserController.h"
#import "BAENLoginController.h"

#import "AppDelegate.h"
#import "ModalNavigationController.h"

@interface CommentListController ()

- (void)setupHeader;
- (void)clearSavedAction;
- (void)clearSavedCompletion;

@end

@implementation CommentListController

#pragma mark - Lifecycle

- (void)finishedLoading {
    [self setupHeader];
    
    [super finishedLoading];
}

- (void)loadView {
    [super loadView];
    
    [[self view] setBackgroundColor:[UIColor whiteColor]];
    [[self view] setClipsToBounds:YES];
    
    [emptyView setText:@"No Comments"];
    [statusView setBackgroundColor:[UIColor clearColor]];
    
    [self setupHeader];
    
    if ([source isKindOfClass:[NETEntry class]]) {
        entryActionsView = [[EntryActionsView alloc] initWithFrame:CGRectZero];
        [entryActionsView sizeToFit];
        
        [entryActionsView setDelegate:self];
        [entryActionsView setEntry:(NETEntry *) source];
        [entryActionsView setEnabled:[(NETEntry *) source isComment] forItem:kEntryActionsViewItemDownvote];
        [[self view] addSubview:entryActionsView];
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            [entryActionsView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin];
            
            CGRect actionsFrame = [entryActionsView frame];
            actionsFrame.origin.y = [[self view] frame].size.height - actionsFrame.size.height;
            actionsFrame.size.width = [[self view] frame].size.width;
            [entryActionsView setFrame:actionsFrame];
            
            CGRect tableFrame = [tableView frame];
            tableFrame.size.height = [[self view] bounds].size.height - actionsFrame.size.height;
            [tableView setFrame:tableFrame];
        } else {
            CGRect actionsFrame = [entryActionsView frame];
            actionsFrame.size.width = 280.0f;
            [entryActionsView setFrame:actionsFrame];
        }
    }
    
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [tableView setSeparatorColor:[UIColor whiteColor]];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        [[self navigationItem] removeRightBarButtonItem:entryActionsViewItem];
    }
    
    expandedCell = nil;
    [entryActionsView release];
    entryActionsView = nil;
    [entryActionsViewItem release];
    entryActionsViewItem = nil;
    [detailsHeaderView release];
    detailsHeaderView = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([source isKindOfClass:[NETEntry class]]) {
        if ([(NETEntry *) source isSubmission]) [self setTitle:@"Submission"];
        if ([(NETEntry *) source isComment]) [self setTitle:@"Replies"];
    } else {
        [self setTitle:@"Comments"];
    }
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        entryActionsViewItem = [[BarButtonItem alloc] initWithCustomView:entryActionsView];
        [[self navigationItem] addRightBarButtonItem:entryActionsViewItem atPosition:UINavigationItemPositionLeft];
        [[self navigationItem] setTitle:nil];
    }
    
    // reload here so the code below has access to the loaded table cells
    // to properly re-expand the saved expanded cell from before the unload
    [tableView reloadData];
    
    // retore expanded cell after memory warning
    if (expandedEntry != nil) {
        NSIndexPath *indexPath = [self indexPathOfEntry:expandedEntry];
        
        if (indexPath != nil) {
            // expand the old expanded cell
            CommentTableCell *cell = (CommentTableCell *) [tableView cellForRowAtIndexPath:indexPath];
            [self setExpandedEntry:expandedEntry cell:cell];
        } else {
            // could not find entry, maybe it disappeared
            expandedEntry = nil;
            expandedCell = nil;
        }
    }
    
    [tableView setSeparatorColor:[UIColor whiteColor]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        if (![[NSUserDefaults standardUserDefaults] boolForKey:@"disable-colorful"]) {
            [entryActionsView setStyle:kEntryActionsViewStyleColorful];
        } else {
            [entryActionsView setStyle:kEntryActionsViewStyleDefault];
        }
    } else if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        if (![[NSUserDefaults standardUserDefaults] boolForKey:@"disable-colorful"]) {
            [entryActionsView setStyle:kEntryActionsViewStyleTransparentLight];
        } else {
            [entryActionsView setStyle:kEntryActionsViewStyleTransparentDark];
        }
    }
    
    [tableView setSeparatorColor:[UIColor whiteColor]];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [self setupHeader];
    
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
}

- (void)dealloc {
    [self clearSavedAction];
    [self clearSavedCompletion];
    
    [detailsHeaderView release];
    [entryActionsView release];
    [entryActionsViewItem release];
    
    [super dealloc];
}

#pragma mark - Table Cells

- (void)addChildrenOfEntry:(NETEntry *)entry toEntryArray:(NSMutableArray *)array includeChildren:(BOOL)includeChildren {
    // only show children of comments that are fully loaded
    includeChildren = includeChildren && [entry isLoaded] && [entry isKindOfClass:[NETEntry class]];
    
    for (NETEntry *child in [entry entries]) {
        [array addObject:child];
        
        if (includeChildren) {
            [self addChildrenOfEntry:child toEntryArray:array includeChildren:includeChildren];
        }
    }
}

- (void)loadEntries {
    NSMutableArray *children = [NSMutableArray array];
    [self addChildrenOfEntry:(NETEntry *) source toEntryArray:children includeChildren:YES];
    
    [entries release];
    entries = [children copy];
}

// XXX: this is really really slow :(
- (NSInteger)depthOfEntry:(NETEntry *)entry {
    NSInteger depth = 0;
    
    NETEntry *parent = [entry parent];
    
    // parent can be nil if we the parent is unknown. this is usually because it
    // is a child of an entry list, not of an entry itself, so we don't know.
    if (parent == nil) return 0;
    
    while (parent != source && parent != nil) {
        depth += 1;
        parent = [parent parent];
    }
    
    // don't show it at some crazy indentation level if this happens
    if (parent == nil) return 0;
    
    return depth;
}

- (CGFloat)cellHeightForEntry:(NETEntry *)entry {
    CGFloat height = [CommentTableCell heightForEntry:entry withWidth:[[self view] bounds].size.width expanded:(entry == expandedEntry) indentationLevel:[self depthOfEntry:entry]];
    
    return height;
}

+ (Class)cellClass {
    return [CommentTableCell class];
}

- (void)configureCell:(CommentTableCell *)cell forEntry:(NETEntry *)entry {
    [cell setDelegate:self];
    [cell setClipsToBounds:YES];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell setIndentationLevel:[self depthOfEntry:entry]];
    [cell setComment:entry];
    [cell setExpanded:(entry == expandedEntry)];
}

- (void)setExpandedEntry:(NETEntry *)entry cell:(CommentTableCell *)cell {
    [tableView beginUpdates];
    [expandedCell setExpanded:NO];
    expandedEntry = entry;
    expandedCell = cell;
    [expandedCell setExpanded:YES];
    [tableView endUpdates];
}

#pragma mark - View Layout

- (void)addStatusView:(UIView *)view {
    CGRect statusFrame = [statusView frame];
    statusFrame.size.height = [tableView bounds].size.height - suggestedHeaderHeight;
    if (statusFrame.size.height < 64.0f) statusFrame.size.height = 64.0f;
    [statusView setFrame:statusFrame];
    
    if (view != nil) {
        [tableView setTableFooterView:statusView];
    }
    
    [super addStatusView:view];
}

- (void)removeStatusView:(UIView *)view {
    [super removeStatusView:view];
    
    if ([statusViews count] == 0) {
        [statusView setFrame:CGRectZero];
        [tableView setTableFooterView:statusView];
    }
}

- (void)setupHeader {
    if (![self isViewLoaded]) return;
    
    // Only show it if the source is at least partially loaded.
    if (![source isKindOfClass:[NETEntry class]] || [(NETEntry *) source submitter] == nil) return;
    
    [pullToRefreshView setBackgroundColor:[UIColor whiteColor]];
    [pullToRefreshView setTextShadowColor:[UIColor whiteColor]];
    
    [detailsHeaderView release];
    detailsHeaderView = nil;
    
    detailsHeaderView = [[DetailsHeaderView alloc] initWithEntry:(NETEntry *) source widthWidth:[[self view] bounds].size.width];
    [detailsHeaderView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin];
    [detailsHeaderView setDelegate:self];
    [tableView setTableHeaderView:detailsHeaderView];
    
    suggestedHeaderHeight = [detailsHeaderView bounds].size.height;
}

#pragma mark - Delegates

- (void)detailsHeaderView:(DetailsHeaderView *)header selectedURL:(NSURL *)url {
    BrowserController *controller = [[BrowserController alloc] initWithURL:url];
    [[self navigation] pushController:[controller autorelease] animated:YES];
}

- (void)commentTableCell:(CommentTableCell *)cell selectedURL:(NSURL *)url {
    BrowserController *controller = [[BrowserController alloc] initWithURL:url];
    [[self navigation] pushController:[controller autorelease] animated:YES];
}

- (void)commentTableCellTapped:(CommentTableCell *)cell {
    if (expandedEntry != [cell comment]) {
        [self setExpandedEntry:[cell comment] cell:cell];
    } else {
        [self setExpandedEntry:nil cell:nil];
    }
}

- (void)commentTableCellTappedUser:(CommentTableCell *)cell {
    [self showProfileForEntry:[cell comment]];
}

- (void)commentTableCellDoubleTapped:(CommentTableCell *)cell {
    NETEntry *entry = [self entryAtIndexPath:[tableView indexPathForCell:cell]];
    CommentListController *controller = [[CommentListController alloc] initWithSource:entry];
    [[self navigation] pushController:[controller autorelease] animated:YES];
}

#pragma mark - Actions

- (void)flagFailed {
    UIAlertView *alert = [[UIAlertView alloc] init];
    [alert setTitle:@"Error Flagging"];
    [alert setMessage:@"Unable to submit your vote. Make sure you can flag items and haven't already."];
    [alert addButtonWithTitle:@"Continue"];
    [alert show];
    [alert release];
}

- (void)voteFailed {
    UIAlertView *alert = [[UIAlertView alloc] init];
    [alert setTitle:@"Error Voting"];
    [alert setMessage:@"Unable to submit your vote. Make sure you can vote and haven't already."];
    [alert addButtonWithTitle:@"Continue"];
    [alert show];
    [alert release];
}

- (void)performUpvoteForEntry:(NETEntry *)entry fromEntryActionsView:(EntryActionsView *)eav {
    NETSubmission *submission = [[NETSubmission alloc] initWithSubmissionType:kNETSubmissionTypeVote];
    [submission setDirection:kNETVoteDirectionUp];
    [submission setTarget:entry];
    
    __block id successToken = nil;
    successToken = [[NSNotificationCenter defaultCenter] addObserverForName:kNETSubmissionSuccessNotification object:submission queue:nil usingBlock:^(NSNotification *block) {
        [entry beginLoading];
        [eav stopLoadingItem:kEntryActionsViewItemUpvote];
        
        [[NSNotificationCenter defaultCenter] removeObserver:successToken];
    }];
    
    __block id failureToken = nil;
    failureToken = [[NSNotificationCenter defaultCenter] addObserverForName:kNETSubmissionFailureNotification object:submission queue:nil usingBlock:^(NSNotification *block) {
        [self voteFailed];
        [eav stopLoadingItem:kEntryActionsViewItemUpvote];
        
        [[NSNotificationCenter defaultCenter] removeObserver:failureToken];
    }];
    
    [[source session] performSubmission:submission];
    [submission release];
    
    [eav beginLoadingItem:kEntryActionsViewItemUpvote];
}

- (void)performDownvoteForEntry:(NETEntry *)entry fromEntryActionsView:(EntryActionsView *)eav {
    NETSubmission *submission = [[NETSubmission alloc] initWithSubmissionType:kNETSubmissionTypeVote];
    [submission setDirection:kNETVoteDirectionDown];
    [submission setTarget:entry];
    
    __block id successToken = nil;
    successToken = [[NSNotificationCenter defaultCenter] addObserverForName:kNETSubmissionSuccessNotification object:submission queue:nil usingBlock:^(NSNotification *block) {
        [entry beginLoading];
        [eav stopLoadingItem:kEntryActionsViewItemDownvote];
        
        [[NSNotificationCenter defaultCenter] removeObserver:successToken];
    }];
    
    __block id failureToken = nil;
    failureToken = [[NSNotificationCenter defaultCenter] addObserverForName:kNETSubmissionFailureNotification object:submission queue:nil usingBlock:^(NSNotification *block) {
        [self voteFailed];
        [eav stopLoadingItem:kEntryActionsViewItemDownvote];
        
        [[NSNotificationCenter defaultCenter] removeObserver:failureToken];
    }];
    
    [[source session] performSubmission:submission];
    [submission release];
    
    [eav beginLoadingItem:kEntryActionsViewItemDownvote];
}

- (void)performFlagForEntry:(NETEntry *)entry fromEntryActionsView:(EntryActionsView *)eav {
    NETSubmission *submission = [[NETSubmission alloc] initWithSubmissionType:kNETSubmissionTypeFlag];
    [submission setTarget:entry];
    
    __block id successToken = nil;
    successToken = [[NSNotificationCenter defaultCenter] addObserverForName:kNETSubmissionSuccessNotification object:submission queue:nil usingBlock:^(NSNotification *block) {
        [entry beginLoading];
        [eav stopLoadingItem:kEntryActionsViewItemFlag];
        
        [[NSNotificationCenter defaultCenter] removeObserver:successToken];
    }];
    
    __block id failureToken = nil;
    failureToken = [[NSNotificationCenter defaultCenter] addObserverForName:kNETSubmissionFailureNotification object:submission queue:nil usingBlock:^(NSNotification *block) {
        [self flagFailed];
        [eav stopLoadingItem:kEntryActionsViewItemFlag];
        
        [[NSNotificationCenter defaultCenter] removeObserver:failureToken];
    }];
    
    [[source session] performSubmission:submission];
    
    [submission release];
    
    [eav beginLoadingItem:kEntryActionsViewItemFlag];
}

- (void)showProfileForEntry:(NETEntry *)entry {
    ProfileController *controller = [[ProfileController alloc] initWithSource:[entry submitter]];
    [controller setTitle:@"Profile"];
    [controller autorelease];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [[self navigation] pushController:controller animated:YES];
    } else if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        ModalNavigationController *navigation = [[ModalNavigationController alloc] initWithRootViewController:controller];
        [self presentViewController:navigation animated:YES completion:NULL];
        [navigation release];
    }
}

- (void)composeControllerDidCancel:(EntryReplyComposeController *)controller {
    return;
}

- (void)composeControllerDidSubmit:(EntryReplyComposeController *)controller {
    [[controller entry] beginLoading];
}

- (void)clearSavedCompletion {
    [savedCompletion release];
    savedCompletion = nil;
}

- (void)clearSavedAction {
    [savedAction release];
    savedAction = nil;
}

- (void)actionSheet:(UIActionSheet *)sheet clickedButtonAtIndex:(NSInteger)index {
    if ([[sheet sheetContext] isEqual:@"entry-action"]) {
        if (index != [sheet cancelButtonIndex]) {
            // The 2 is subtracted to cancel out the cancel button, and then
            // to account for the zero-indexed buttons, but the count from one.
            savedCompletion([sheet numberOfButtons] - 1 - index - 1);
        } else {
            [self clearSavedCompletion];
        }
    } else {
        if ([[[self class] superclass] instancesRespondToSelector:@selector(actionSheet:clickedButtonAtIndex:)]) {
            [super actionSheet:sheet clickedButtonAtIndex:index];
        }
    }
}

- (void)loginControllerDidLogin:(LoginController *)controller {
    [self dismissViewControllerAnimated:YES completion:^{
        savedAction();
    }];
}

- (void)loginControllerDidCancel:(LoginController *)controller {
    [self dismissViewControllerAnimated:YES completion:NULL];
    
    [self clearSavedAction];
    [self clearSavedCompletion];
}

- (void)entryActionsView:(EntryActionsView *)eav didSelectItem:(EntryActionsViewItem)item {
    NETEntry *entry = [eav entry];
    
    __block __typeof__(self) this = self;
    
    savedCompletion = [^(NSInteger index) {
        if (item == kEntryActionsViewItemReply) {
            EntryReplyComposeController *compose = [[EntryReplyComposeController alloc] initWithEntry:entry];
            [compose setDelegate:this];
            
            NavigationController *navigation = [[NavigationController alloc] initWithRootViewController:compose];
            [[this navigationController] presentViewController:navigation animated:YES completion:NULL];
            [navigation release];
        } else if (item == kEntryActionsViewItemUpvote) {
            [this performUpvoteForEntry:entry fromEntryActionsView:eav];
        } else if (item == kEntryActionsViewItemFlag) {
            [this performFlagForEntry:entry fromEntryActionsView:eav];
        } else if (item == kEntryActionsViewItemDownvote) {
            [this performDownvoteForEntry:entry fromEntryActionsView:eav];
        } else if (item == kEntryActionsViewItemActions) {
            if (index == 0) {
                [self showProfileForEntry:entry];
            } else if (index == 1) {
                CommentListController *controller = [[CommentListController alloc] initWithSource:[entry parent]];
                [[this navigationController] pushController:[controller autorelease] animated:YES];
            } else if (index == 2) {
                CommentListController *controller = [[CommentListController alloc] initWithSource:[entry submission]];
                [[this navigationController] pushController:[controller autorelease] animated:YES];
            }
        }
        
        [this clearSavedCompletion];
    } copy];
    
    savedAction = [^{
        if (item == kEntryActionsViewItemUpvote || item == kEntryActionsViewItemDownvote) {
            NSNumber *confirm = [[NSUserDefaults standardUserDefaults] objectForKey:@"interface-confirm-votes"];
            
            if (confirm != nil && [confirm boolValue]) {
                UIActionSheet *sheet = [[UIActionSheet alloc] init];
                [sheet addButtonWithTitle:@"Vote"];
                [sheet addButtonWithTitle:@"Cancel"];
                [sheet setCancelButtonIndex:1];
                [sheet setDelegate:this];
                [sheet setSheetContext:@"entry-action"];
                
                [sheet showFromBarButtonItemInWindow:[eav barButtonItemForItem:item] animated:YES];
                [sheet release];
            } else {
                savedCompletion(0);
            }
        } else if (item == kEntryActionsViewItemFlag) {
            UIActionSheet *sheet = [[UIActionSheet alloc] init];
            [sheet addButtonWithTitle:@"Flag"];
            [sheet addButtonWithTitle:@"Cancel"];
            [sheet setDestructiveButtonIndex:0];
            [sheet setCancelButtonIndex:1];
            [sheet setDelegate:this];
            [sheet setSheetContext:@"entry-action"];
            
            [sheet showFromBarButtonItemInWindow:[eav barButtonItemForItem:item] animated:YES];
            [sheet release];
        } else if (item == kEntryActionsViewItemActions) {
            UIActionSheet *sheet = [[UIActionSheet alloc] init];
            if ([entry submission]) [sheet addButtonWithTitle:@"Submission"];
            if ([entry parent]) [sheet addButtonWithTitle:@"Parent"];
            [sheet addButtonWithTitle:@"Submitter"];
            [sheet addButtonWithTitle:@"Cancel"];
            [sheet setCancelButtonIndex:([sheet numberOfButtons] - 1)];
            [sheet setDelegate:this];
            [sheet setSheetContext:@"entry-action"];
            
            [sheet showFromBarButtonItemInWindow:[eav barButtonItemForItem:item] animated:YES];
            [sheet release];
        } else if (item == kEntryActionsViewItemReply) {
            savedCompletion(0);
        }
        
        [this clearSavedAction];
    } copy];
    
    if (![[source session] isAnonymous] || item == kEntryActionsViewItemActions) {
        savedAction();
    } else {
        [[self navigation] requestLogin];
    }
}

- (NSString *)sourceTitle {
    if ([source isKindOfClass:[NETEntry class]]) {
        if ([(NETEntry *) source isSubmission]) {
            NSString *title = [(NETEntry *) source title];
            return title;
        } else {
            NSString *name = [[(NETEntry *) source submitter] identifier];
            return [NSString stringWithFormat:@"Comment by %@", name];
        }
    } else {
        return [self title];
    }
    
}

AUTOROTATION_FOR_PAD_ONLY

@end

