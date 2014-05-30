//
//  ProfileController.h
//  BAEN
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import "LoadingController.h"
#import "ColorfulTableView.h"
#import "BodyTextView.h"

@class ProfileHeaderView;
@interface ProfileController : LoadingController <UITableViewDelegate, UITableViewDataSource, BodyTextViewDelegate> {
    ColorfulTableView *tableView;
    ProfileHeaderView *header;
}

@end
