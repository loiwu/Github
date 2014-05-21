//
//  NETShared.h
//  NETKit
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import "NSURL+Parameters.h"
#import "NSObject+PerformSelector.h"
#import "NSString+RemoveSuffix.h"


#define NETKIT_RENDERING_ENABLED


#define kNETWebsiteHost @"news.ycombinator.com"
#define kNETFAQURL [NSURL URLWithString:@"http://ycombinator.com/newsfaq.html"]
#define kNETWebsiteURL [NSURL URLWithString:[NSString stringWithFormat:@"https://%@/", kNETWebsiteHost]]


#define kNETSearchBaseURL @"http://api.thriftdb.com/api.hnsearch.com/items/_search?%@"
#define kNETSearchParamsInteresting @"limit=100&filter[fields][type][]=submission&weights[title]=8&weights[text]=2&weights[domain]=3&weights[username]=3&weights[type]=0&boosts[fields][points]=3&boosts[fields][num_comments]=3&boosts[functions][recip(ms(NOW,create_ts),3.16e-11,1,1)]=2.0&q=%@"
#define kNETSearchParamsRecent @"sortby=create_ts%%20desc&limit=100&filter[fields][type][]=submission&weights[title]=8&weights[text]=2&weights[domain]=3&weights[username]=3&weights[type]=0&boosts[fields][points]=3&boosts[fields][num_comments]=3&boosts[functions][recip(ms(NOW,create_ts),3.16e-11,1,1)]=2.0&q=%@"
typedef enum {
    kNETSearchTypeInteresting,
    kNETSearchTypeRecent
} NETSearchType;


typedef enum {
    kNETVoteDirectionDown,
    kNETVoteDirectionUp
} NETVoteDirection;


typedef NSString *NETSessionToken;

typedef NSString *NETMoreToken;

