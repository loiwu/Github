//
//  NETSessionAuthenticator.m
//  NETKit
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import "NETKit.h"
#import "NETSessionAuthenticator.h"
#import "NETNetworkActivityController.h"

#import "XMLDocument.h"

#import "NSDictionary+Parameters.h"

@implementation NETSessionAuthenticator
@synthesize delegate;

- (void)dealloc {
    if (connection != nil) [connection cancel];
    [connection release];
    [username release];
    [password release];
    
    [super dealloc];
}

- (id)initWithUsername:(NSString *)username_ password:(NSString *)password_ {
    if ((self = [super init])) {
        password = [password_ copy];
        username = [username_ copy];
    }
    
    return self;
}

- (void)_failAuthentication {
    if ([delegate respondsToSelector:@selector(sessionAuthenticatorDidRecieveFailure:)]) {
        [delegate sessionAuthenticatorDidRecieveFailure:self];
    }
}

- (void)_completeAuthenticationWithToken:(NETSessionToken)token {
    if ([delegate respondsToSelector:@selector(sessionAuthenticator:didRecieveToken:)]) {
        [delegate sessionAuthenticator:self didRecieveToken:token];
    }
}

- (void)_clearConnection {
    if (connection != nil) {
        [NETNetworkActivityController networkActivityEnded];
        [connection release];
        connection = nil;
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [self _failAuthentication];
    [self _clearConnection];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [self _failAuthentication];
    [self _clearConnection];
}

- (NSURLRequest *)connection:(NSURLConnection *)connection_ willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)response {
    if (response == nil) {
        // not from a server redirect
        return request;
    }
    
    if (response != nil && [response isKindOfClass:[NSHTTPURLResponse class]]) {
        NSHTTPURLResponse *http = (NSHTTPURLResponse *) response;
        
        NSArray *cookies = [NSHTTPCookie cookiesWithResponseHeaderFields:[http allHeaderFields] forURL:[http URL]];
        for (NSHTTPCookie *cookie in cookies) {
            if ([[cookie name] isEqual:@"user"]) {
                [self _completeAuthenticationWithToken:(NETSessionToken) [cookie value]];
                
                [connection cancel];
                [self _clearConnection];
                
                return nil;
            }
        }
    }
    
    [self _failAuthentication];
    [connection cancel];
    [self _clearConnection];
    
    return nil;
}

- (NSString *)_generateLoginPageURL {
    NSData *data = [NSData dataWithContentsOfURL:kNETWebsiteURL];
    XMLDocument *document = [[[XMLDocument alloc] initWithHTMLData:data] autorelease];
    if (document == nil) return nil;
    
    XMLElement *element = [document firstElementMatchingPath:@"//span[@class='pagetop']//a[text()='login']"];
    return [element attributeWithName:@"href"];
}

- (NSString *)_loginTokenFromLoginDocument:(XMLDocument *)loginDocument {
    XMLElement *element = [loginDocument firstElementMatchingPath:@"//form//input[@name='fnid']"];
    return [element attributeWithName:@"value"];
}

- (NSString *)_loginURLFromLoginDocument:(XMLDocument *)loginDocument {
    XMLElement *element = [loginDocument firstElementMatchingPath:@"//form"];
    return [element attributeWithName:@"action"];
}

- (void)_sendAuthenticationRequest:(NSURLRequest *)request {
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];
    [NETNetworkActivityController networkActivityBegan];
}

- (void)_performAuthentication {
    NSString *loginurl = nil;
    NSString *formfnid = nil;
    NSString *submiturl = nil;
    
    loginurl = [self _generateLoginPageURL];
    
    if (loginurl != nil) {
        NSURL *url = [[NSURL URLWithString:loginurl relativeToURL:kNETWebsiteURL] absoluteURL];
        NSData *data = [NSData dataWithContentsOfURL:url];
        XMLDocument *document = [[XMLDocument alloc] initWithHTMLData:data];
        
        if (document != nil) {
            formfnid = [self _loginTokenFromLoginDocument:document];
            submiturl = [self _loginURLFromLoginDocument:document];
        }
        
        [document release];
    }
    
    if (loginurl == nil || formfnid == nil || submiturl == nil) {
        [self performSelectorOnMainThread:@selector(_failAuthentication) withObject:nil waitUntilDone:YES];
        return;
    }
    
    NSDictionary *query = [NSDictionary dictionaryWithObjectsAndKeys:
                           formfnid, @"fnid",
                           username, @"u",
                           password, @"p",
                           nil];
    
    NSURL *submitURL = [[NSURL URLWithString:submiturl relativeToURL:kNETWebsiteURL] absoluteURL];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:submitURL];
    [request setHTTPMethod:@"POST"];
    [request setHTTPShouldHandleCookies:NO];
    
    // Take the slice [1:] so avoid the question mark that doesn't make sense in POST requests.
    // XXX: is that an issue with this category in general?
    [request setHTTPBody:[[[query queryString] substringFromIndex:1] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // The NSURLRequest object must be created on the main thread, or else it
    // will be destroyed when this thread exits (now), which is not what we want.
    [self performSelectorOnMainThread:@selector(_sendAuthenticationRequest:) withObject:request waitUntilDone:YES];
}

- (void)_authenticateWrapper {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    [self _performAuthentication];
    [pool release];
}

- (void)beginAuthenticationRequest {
    [NSThread detachNewThreadSelector:@selector(_authenticateWrapper) toTarget:self withObject:nil];
}

@end
