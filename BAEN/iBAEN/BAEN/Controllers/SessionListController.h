//
//  SessionListController.h
//  BAEN
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import <NETKit/NETKit.h>

#import "NavigationController.h"

@interface SessionListController : UIViewController <UITableViewDelegate, UITableViewDataSource, NavigationControllerLoginDelegate> {
    NSArray *sessions;
    NETSession *automaticDisplaySession;
    
    UITableView *tableView;
    BarButtonItem *editBarButtonItem;
    BarButtonItem *doneBarButtonItem;
    BarButtonItem *addBarButtonItem;
}

@property (nonatomic, retain) NETSession *automaticDisplaySession;

@end

