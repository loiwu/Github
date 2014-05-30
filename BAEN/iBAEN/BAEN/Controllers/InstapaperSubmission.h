//
//  InstapaperSubmission.h
//  BAEN
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

@class LoadingController;

@interface InstapaperSubmission : NSObject {
    NSURL *url;
    BOOL presented;
    void (^loginCompletion)(BOOL);
}

@property (nonatomic, copy) void (^loginCompletion)(BOOL);

- (id)initWithURL:(NSURL *)url;
- (UIViewController *)submitFromController:(UIViewController *)controller;

@end

