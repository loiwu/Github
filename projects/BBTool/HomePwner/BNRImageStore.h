//
//  BNRImageStore.h
//  HomePwner
//
//  Created by John Gallagher on 1/7/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRImageStore : NSObject //<>Creating BNRItemStore

//Notice that it is a class method and prefixed with a + instead of a -
+ (instancetype)sharedStore; //to get the single instance of BNRItemStore

- (void)setImage:(UIImage *)image forKey:(NSString *)key;
- (UIImage *)imageForKey:(NSString *)key;
- (void)deleteImageForKey:(NSString *)key;

@end
