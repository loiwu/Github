//
//  NETUser.m
//  NETKit
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import "NSURL+Parameters.h"

#import "NETKit.h"
#import "NETUser.h"

@implementation NETUser
@synthesize karma, average, created, about;

#ifdef NETKIT_RENDERING_ENABLED
@synthesize renderer;

- (NETObjectBodyRenderer *)renderer {
    if (renderer != nil) return renderer;
    
    renderer = [[NETObjectBodyRenderer alloc] initWithObject:self];
    return renderer;
}
#endif

+ (id)identifierForURL:(NSURL *)url_ {
    if (![self isValidURL:url_]) return NO;
    
    NSDictionary *parameters = [url_ parameterDictionary];
    return [parameters objectForKey:@"id"];
}

+ (NSString *)pathForURLWithIdentifier:(id)identifier_ infoDictionary:(NSDictionary *)info {
    return @"user";
}

+ (NSDictionary *)parametersForURLWithIdentifier:(id)identifier_ infoDictionary:(NSDictionary *)info {
    if (identifier_ != nil) return [NSDictionary dictionaryWithObject:identifier_ forKey:@"id"];
    else return [NSDictionary dictionary];
}

+ (id)session:(NETSession *)session userWithIdentifier:(id)identifier_ {
    return [self session:session objectWithIdentifier:identifier_];
}

- (void)loadFromDictionary:(NSDictionary *)dictionary complete:(BOOL)complete {
    [self setAbout:[dictionary objectForKey:@"about"]];
    [self setKarma:[[dictionary objectForKey:@"karma"] intValue]];
    [self setAverage:[[dictionary objectForKey:@"average"] floatValue]];
    [self setCreated:[[dictionary objectForKey:@"created"] stringByRemovingSuffix:@" ago"]];
    
    [super loadFromDictionary:dictionary complete:complete];
}

@end

