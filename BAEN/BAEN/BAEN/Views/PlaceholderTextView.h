//
//  PlaceholderTextView.h
//  BAEN
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

// For some unknown reason, UITextView doesn't have a "placeholder"
// property like UITextField does. I have no idea why Apple didn't
// include that, but this adds it using UILabel and a bunch of
// probably-broken logic.

@interface PlaceholderTextView : UITextView {
    UILabel *placeholderLabel;
    NSString *placeholder;
}

@property (nonatomic, copy) NSString *placeholder;

@end

