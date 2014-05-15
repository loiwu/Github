//
//  BNRCoursesViewController.h
//  Nerdfeed
//
//  Created by John Gallagher on 1/9/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

// the BNRCoursesViewController,  which made the request, will populate its table view with the titles of the courses

#import <UIKit/UIKit.h>

@class BNRWebViewController;

@interface BNRCoursesViewController : UITableViewController // change superclass to UITableViewController

@property (nonatomic, strong) BNRWebViewController *webViewController;

@end
