//
//  UIActionSheet+Context.h
//  BAEN
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

// The idea of this is that there is a private "context" property on
// UIActionSheet (as well as UIAlertView), and it's actually quite
// essential: while a "tag" might work as well, it's not anywhere near
// as clean (to me).
//
// Since we can't name it the same as Apple's "context" property, I've
// called it "sheetContext" (for lack of a better name), and simulated
// the ivar using objc_setAssociatedObject().

@interface UIActionSheet (Context)

- (void)setSheetContext:(NSString *)context;
- (NSString *)sheetContext;

@end
