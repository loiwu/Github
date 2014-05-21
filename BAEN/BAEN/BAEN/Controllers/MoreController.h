//
//  MoreController.h
//  BAEN
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import "OrangeTableView.h"

@interface MoreController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    NETSession *session;
    
    OrangeTableView *tableView;
}

- (id)initWithSession:(NETSession *)session_;

@end
