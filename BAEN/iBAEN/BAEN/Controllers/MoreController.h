//
//  MoreController.h
//  BAEN
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import "ColorfulTableView.h"

@interface MoreController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    NETSession *session;
    
    ColorfulTableView *tableView;
}

- (id)initWithSession:(NETSession *)session_;

@end
