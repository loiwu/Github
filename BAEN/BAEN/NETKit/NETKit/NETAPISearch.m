//
//  NETAPISearch.m
//  NETKit
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import "NETAPISearch.h"
#import "NETKit.h"
#import "NSDate+TimeAgo.h"

@class NETEntry;

@interface NETAPISearch () <NSURLConnectionDelegate, NSURLConnectionDataDelegate>
@end

@implementation NETAPISearch

@synthesize entries;
@synthesize responseData;
@synthesize searchType;
@synthesize session;
@synthesize dateFormatter;

- (id)initWithSession:(NETSession *)session_ {
	if (self = [super init]) {
		session = session_;
		[self setSearchType:kNETSearchTypeInteresting];
	}
	
	return self;
}

#pragma mark NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	[responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	if (responseData == nil) {
		responseData = [[NSMutableData alloc] init];
	}
	
	[responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	[connection release];
	[responseData release];
	responseData = nil;
	
	NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
	[notificationCenter postNotificationName:@"searchDone" object:nil userInfo:nil];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	[connection release];
    
	[self handleResponse];
}

- (void)handleResponse {
	id responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:NULL];
	NSArray *rawResults = [[NSArray alloc] initWithArray:[responseJSON objectForKey:@"results"]];
    
	self.entries = [NSMutableArray array];
    
	for (NSDictionary *result in rawResults) {
		NSDictionary *item = [self itemFromRaw:[result objectForKey:@"item"]];
		NETEntry *entry = [NETEntry session:session entryWithIdentifier:[item objectForKey:@"identifier"]];
        
		[entry loadFromDictionary:item complete:NO];
		[entries addObject:entry];
	}
	
	[rawResults release];
	rawResults = nil;
	[responseData release];
	responseData = nil;
    
	NSDictionary *dictToBePassed = [NSDictionary dictionaryWithObject:entries forKey:@"array"];
	NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
	[notificationCenter postNotificationName:@"searchDone" object:nil userInfo:dictToBePassed];
}

- (NSDictionary *)itemFromRaw:(NSDictionary *)rawDictionary {
	NSMutableDictionary *item = [NSMutableDictionary dictionary];
	NSNumber *points = nil;
	NSNumber *comments = nil;
	NSString *title = nil;
	NSString *user = nil;
	NSNumber *identifier = nil;
	NSString *body = nil;
	NSString *date = nil;
	NSString *url = nil;
    
	points = [rawDictionary valueForKey:@"points"];
	comments = [rawDictionary valueForKey:@"num_comments"];
	title = [rawDictionary valueForKey:@"title"];
	user = [rawDictionary valueForKey:@"username"];
	identifier = [rawDictionary valueForKey:@"id"];
	body = [rawDictionary valueForKey:@"text"];
	date = [rawDictionary valueForKey:@"create_ts"];
	url = [rawDictionary valueForKey:@"url"];
    
	if (self.dateFormatter == nil) {
		self.dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
		[dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
	}
	NSDate *parsedDate = [dateFormatter dateFromString:date];
	NSString *timeAgo = [parsedDate timeAgoInWords];
	
	if ((NSNull *)user != [NSNull null]) [item setObject:user forKey:@"user"];
	if ((NSNull *)points != [NSNull null]) [item setObject:points forKey:@"points"];
	if ((NSNull *)title != [NSNull null]) [item setObject:title forKey:@"title"];
	if ((NSNull *)comments != [NSNull null]) [item setObject:comments forKey:@"numchildren"];
	if ((NSNull *)url != [NSNull null]) [item setObject:url forKey:@"url"];
	if ((NSNull *)timeAgo != [NSNull null]) [item setObject:timeAgo forKey:@"date"];
	if ((NSNull *)body != [NSNull null]) [item setObject:body forKey:@"body"];
	if ((NSNull *)identifier != [NSNull null]) [item setObject:identifier forKey:@"identifier"];
	return item;
}

- (void)performSearch:(NSString *)searchQuery {
	NSString *paramsString = nil;
	NSString *encodedQuery = [searchQuery stringByURLEncodingString];
	if (searchType == kNETSearchTypeInteresting) {
		paramsString = [NSString stringWithFormat:kNETSearchParamsInteresting, encodedQuery];
	} else {
		paramsString = [NSString stringWithFormat:kNETSearchParamsRecent, encodedQuery];
	}
    
	NSString *urlString = [NSString stringWithFormat:kNETSearchBaseURL, paramsString];
	NSURL *url = [NSURL URLWithString:urlString];
    
	NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
	NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	[connection start];
	[request release];
    
	searchQuery = nil;
}

- (void)dealloc {
	[responseData release];
	[entries release];
	[dateFormatter release];
    
	[super dealloc];
}

@end

