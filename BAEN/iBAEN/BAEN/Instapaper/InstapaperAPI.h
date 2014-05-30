//
//  InstapaperAPI.h
//  BAEN
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import <NETKit/NSString+URLEncoding.h>

#define kInstapaperAPIRootURL [NSURL URLWithString:@"https://www.instapaper.com/api/"]
#define kInstapaperAPIAuthenticationURL [NSURL URLWithString:[[kInstapaperAPIRootURL absoluteString] stringByAppendingString:@"authenticate"]]
#define kInstapaperAPIAddItemURL [NSURL URLWithString:[[kInstapaperAPIRootURL absoluteString] stringByAppendingString:@"add"]]
