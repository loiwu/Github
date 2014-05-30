//
//  UIActionSheet+Context.m
//  BAEN
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import <objc/runtime.h>

#import "UIActionSheet+Context.h"

@implementation UIActionSheet (Context)
static NSString *UIActionSheetNameKey = @"UIActionSheetSheetContextKey";

- (void)setSheetContext:(NSString *)name {
    objc_setAssociatedObject(self, &UIActionSheetNameKey, name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)sheetContext {
    return objc_getAssociatedObject(self, &UIActionSheetNameKey);
}

@end
