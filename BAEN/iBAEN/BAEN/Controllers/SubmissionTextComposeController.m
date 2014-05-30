//
//  SubmissionTextComposeController.m
//  BAEN
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import "SubmissionTextComposeController.h"
#import "PlaceholderTextView.h"

@implementation SubmissionTextComposeController

- (BOOL)includeMultilineEditor {
    return YES;
}

- (NSString *)multilinePlaceholder {
    return @"Post Body";
}

- (NSString *)title {
    return @"Submit Text";
}

- (NSArray *)inputEntryCells {
    UITableViewCell *cell = [self generateTextFieldCell];
    [[cell textLabel] setText:@"Title:"];
    titleField = [self generateTextFieldForCell:cell];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
    [cell addSubview:titleField];
    
    return [NSArray arrayWithObject:cell];
}

- (UIResponder *)initialFirstResponder {
    return titleField;
}

- (void)submissionSucceededWithNotification:(NSNotification *)notification {
    [self sendComplete];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNETSubmissionFailureNotification object:[notification object]];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNETSubmissionSuccessNotification object:[notification object]];
}

- (void)submissionFailedWithNotification:(NSNotification *)notification {
    [self sendFailed];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNETSubmissionFailureNotification object:[notification object]];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNETSubmissionSuccessNotification object:[notification object]];
}

- (void)performSubmission {
    if (![self ableToSubmit]) {
        [self sendFailed];
    } else {
        NETSubmission *submission = [[NETSubmission alloc] initWithSubmissionType:kNETSubmissionTypeSubmission];
        [submission setTitle:[titleField text]];
        [submission setBody:[textView text]];
        [session performSubmission:submission];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(submissionSucceededWithNotification:) name:kNETSubmissionSuccessNotification object:submission];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(submissionFailedWithNotification:) name:kNETSubmissionFailureNotification object:submission];
        
        [submission release];
    }
}

- (BOOL)ableToSubmit {
    return !([[titleField text] length] == 0 || [[textView text] length] == 0);
}

- (void)viewDidUnload {
    [super viewDidUnload];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
    
    titleField = nil;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNETSubmissionFailureNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNETSubmissionSuccessNotification object:nil];
    
    [super dealloc];
}

AUTOROTATION_FOR_PAD_ONLY

@end

