//
//  CommentTableCell.h
//  BAEN
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import "TableViewCell.h"
#import "EntryActionsView.h"
#import "BodyTextView.h"

@protocol CommentTableCellDelegate;

@class NETEntry;
@interface CommentTableCell : TableViewCell <BodyTextViewDelegate> {
    NETEntry *comment;
    NSInteger indentationLevel;
    
    BOOL userHighlighted;
    BodyTextView *bodyTextView;
    
    __weak id<CommentTableCellDelegate> delegate;
    
    BOOL expanded;
    EntryActionsView *toolbarView;
    
    UITapGestureRecognizer *tapRecognizer;
    UITapGestureRecognizer *doubleTapRecognizer;
}

@property (nonatomic, assign) id<CommentTableCellDelegate> delegate;
@property (nonatomic, retain) NETEntry *comment;
@property (nonatomic, assign) NSInteger indentationLevel;
@property (nonatomic, assign) BOOL expanded;

+ (CGFloat)heightForEntry:(NETEntry *)entry withWidth:(CGFloat)width expanded:(BOOL)expanded indentationLevel:(NSInteger)indentationLevel;

- (id)initWithReuseIdentifier:(NSString *)identifier;

@end

@protocol CommentTableCellDelegate <EntryActionsViewDelegate>
@optional

- (void)commentTableCellTapped:(CommentTableCell *)cell;
- (void)commentTableCellTappedUser:(CommentTableCell *)cell;
- (void)commentTableCellDoubleTapped:(CommentTableCell *)cell;
- (void)commentTableCell:(CommentTableCell *)cell selectedURL:(NSURL *)url;

@end


