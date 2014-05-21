//
//  PingController.h
//  BAEN
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

@protocol PingControllerDelegate;

@interface PingController : NSObject {
    NSMutableData *received;
    NSURL *moreInfoURL;
    BOOL locked;
    
    id<PingControllerDelegate> delegate;
}

@property (nonatomic, assign) id<PingControllerDelegate> delegate;
@property (nonatomic, assign) BOOL locked;

- (void)ping;

@end

@protocol PingControllerDelegate <NSObject>
@optional

- (void)pingController:(PingController *)pingController failedWithError:(NSError *)error;
- (void)pingControllerCompletedWithoutAction:(PingController *)pingController;
- (void)pingController:(PingController *)pingController completedAcceptingURL:(NSURL *)url;


@end
