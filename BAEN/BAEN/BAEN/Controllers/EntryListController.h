//
//  EntryListController.h
//  BAEN
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import "LoadingController.h"
#import "PullToRefreshView.h"
#import "LoadMoreCell.h"

@class EmptyView;

@interface EntryListController : LoadingController <UITableViewDelegate, UITableViewDataSource, PullToRefreshViewDelegate> {
    UITableViewController *tableViewController;
    UITableView *tableView;
    EmptyView *emptyView;
    
    LoadMoreCell *moreCell;
    PullToRefreshView *pullToRefreshView;
    UIRefreshControl *refreshControl;
    
    NSArray *entries;
}

- (NETEntry *)entryAtIndexPath:(NSIndexPath *)indexPath;
- (NSIndexPath *)indexPathOfEntry:(NETEntry *)entry;

+ (Class)cellClass;
- (CGFloat)cellHeightForEntry:(NETEntry *)entry;
- (void)configureCell:(UITableViewCell *)cell forEntry:(NETEntry *)entry;
- (void)cellSelected:(UITableViewCell *)cell forEntry:(NETEntry *)entry;
- (void)deselectWithAnimation:(BOOL)animated;

@end
