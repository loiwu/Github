//
//  EntryActionsView.h
//  BAEN
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import "ActivityIndicatorItem.h"
#import "BarButtonItem.h"
#import "ColorfulToolbar.h"

typedef enum {
    kEntryActionsViewItemUpvote,
    kEntryActionsViewItemReply,
    kEntryActionsViewItemFlag,
    kEntryActionsViewItemDownvote,
    kEntryActionsViewItemActions
} EntryActionsViewItem;

typedef enum {
    kEntryActionsViewStyleDefault,
    kEntryActionsViewStyleColorful,
    kEntryActionsViewStyleTransparentLight,
    kEntryActionsViewStyleTransparentDark,
    kEntryActionsViewStyleLight
} EntryActionsViewStyle;

@protocol EntryActionsViewDelegate;
@class NETEntry;
@interface EntryActionsView : ColorfulToolbar {
    NETEntry *entry;
    __weak id<EntryActionsViewDelegate> delegate;
    
    NSInteger upvoteLoading;
    BOOL upvoteDisabled;
    NSInteger replyLoading;
    BOOL replyDisabled;
    NSInteger flagLoading;
    BOOL flagDisabled;
    NSInteger downvoteLoading;
    BOOL downvoteDisabled;
    NSInteger actionsLoading;
    BOOL actionsDisabled;
    
    EntryActionsViewStyle style;
    UIActivityIndicatorViewStyle indicatorStyle;
}

@property (nonatomic, retain) NETEntry *entry;
@property (nonatomic, assign) id<EntryActionsViewDelegate> delegate;
@property (nonatomic, assign) EntryActionsViewStyle style;

- (void)setEnabled:(BOOL)enabled forItem:(EntryActionsViewItem)item;
- (BOOL)itemIsEnabled:(EntryActionsViewItem)item;
- (void)beginLoadingItem:(EntryActionsViewItem)item;
- (void)stopLoadingItem:(EntryActionsViewItem)item;
- (BOOL)itemIsLoading:(EntryActionsViewItem)item;
- (BarButtonItem *)barButtonItemForItem:(EntryActionsViewItem)item;

@end

@protocol EntryActionsViewDelegate<NSObject>

- (void)entryActionsView:(EntryActionsView *)eav didSelectItem:(EntryActionsViewItem)item;

@end
