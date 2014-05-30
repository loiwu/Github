//
//  ComposeController.h
//  BAEN
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import <NETKit/NETKit.h>

#import "BarButtonItem.h"
#import "ActivityIndicatorItem.h"

@protocol ComposeControllerDelegate;
@class PlaceholderTextView;

@interface ComposeController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate, UITextViewDelegate, UITextFieldDelegate> {
    NETSession *session;
    
    UITableView *tableView;
    NSArray *entryCells;
    PlaceholderTextView *textView;
    BarButtonItem *cancelItem;
    BarButtonItem *completeItem;
    ActivityIndicatorItem *loadingItem;
    BOOL keyboardVisible;
    __weak id<ComposeControllerDelegate> delegate;
}

@property (nonatomic, assign) id<ComposeControllerDelegate> delegate;

- (id)initWithSession:(NETSession *)session_;

- (UITableViewCell *)generateTextFieldCell;
- (UITextField *)generateTextFieldForCell:(UITableViewCell *)cell;
- (UIResponder *)initialFirstResponder;

- (void)sendComplete;
- (void)sendFailed;
- (void)performSubmission;
- (BOOL)ableToSubmit;
- (void)textDidChange:(NSNotification *)notification;

@end

@protocol ComposeControllerDelegate <NSObject>
@optional

- (void)composeControllerDidSubmit:(ComposeController *)controller;
- (void)composeControllerDidCancel:(ComposeController *)controller;

@end

