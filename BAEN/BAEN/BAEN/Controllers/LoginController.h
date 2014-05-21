//
//  LoginController.h
//  BAEN
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import "BarButtonItem.h"
#import "ActivityIndicatorItem.h"

@protocol LoginControllerDelegate;

@interface LoginController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate> {
    UIImageView *backgroundImageView;
    UIView *centeringAlignmentView;
    UIView *tableContainerView;
    UITableView *tableView;
    
    UITableViewCell *usernameCell;
    UITextField *usernameField;
    UITableViewCell *passwordCell;
    UITextField *passwordField;
    UITableViewCell *loadingCell;
    
    BarButtonItem *cancelItem;
    BarButtonItem *completeItem;
    ActivityIndicatorItem *loadingItem;
    
    __weak id<LoginControllerDelegate> delegate;
    
    UILabel *topLabel;
    UILabel *bottomLabel;
	
	BOOL isAuthenticating;
}

@property (nonatomic, assign) id<LoginControllerDelegate> delegate;

- (void)finish;
- (void)authenticate;

- (void)fail;
- (void)succeed;
- (void)cancel;

@end

@protocol LoginControllerDelegate<NSObject>
@optional

- (void)loginControllerDidLogin:(LoginController *)controller;
- (void)loginControllerDidCancel:(LoginController *)controller;

@end
