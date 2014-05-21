//
//  SubmissionTableCell.h
//  BAEN
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import "TableViewCell.h"

@class NETEntry;
@interface SubmissionTableCell : TableViewCell {
    NETEntry *submission;
}

@property (nonatomic, retain) NETEntry *submission;

+ (CGFloat)heightForEntry:(NETEntry *)entry withWidth:(CGFloat)width;
- (id)initWithReuseIdentifier:(NSString *)identifier;

@end

