//
//  CommentListController.h
//  BAEN
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import "EntryListController.h"
#import "ComposeController.h"
#import "EntryActionsView.h"
#import "DetailsHeaderView.h"
#import "LoginController.h"
#import "CommentTableCell.h"
#import "BarButtonItem.h"

@interface CommentListController : EntryListController <EntryActionsViewDelegate, DetailsHeaderViewDelegate, LoginControllerDelegate, ComposeControllerDelegate, CommentTableCellDelegate> {
    CGFloat suggestedHeaderHeight;
    DetailsHeaderView *detailsHeaderView;
    
    EntryActionsView *entryActionsView;
    BarButtonItem *entryActionsViewItem;
    
    void (^savedAction)();
    void (^savedCompletion)(int);
    BOOL shouldCompleteOnAppear;
    
    NETEntry *expandedEntry;
    CommentTableCell *expandedCell;
}

@end

