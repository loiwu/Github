//
//  LoadMoreCell.h
//  BAEN
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import "TableViewCell.h"
#import "LoadMoreButton.h"

@interface LoadMoreCell : TableViewCell {
    LoadMoreButton *button;
}

@property (nonatomic, readonly, retain) LoadMoreButton *button;

@end

