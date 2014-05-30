//
//  SearchController.h
//  BAEN
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import <NETKit/NETAPISearch.h>

@class EmptyView;
@class ColorfulToolbar;
@class LoadingIndicatorView;

@interface SearchController : UIViewController <UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate> {
    NETSession *session;
    NETAPISearch *searchAPI;
    NSMutableArray *entries;
    
    UISearchBar *searchBar;
    ColorfulToolbar *coloredView;
    UISegmentedControl *facetControl;
    
	UITableView *tableView;
	EmptyView *emptyView;
    LoadingIndicatorView *indicator;
	BOOL searchPerformed;
}

- (id)initWithSession:(NETSession *)session_;

@end
