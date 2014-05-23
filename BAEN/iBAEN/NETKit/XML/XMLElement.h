//
//  XMLElement.h
//  NETKit
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <libxml/tree.h>
#import <libxml/parser.h>
#import <libxml/HTMLparser.h>
#import <libxml/xpath.h>
#import <libxml/xpathInternals.h>

@class XMLDocument;
@interface XMLElement : NSObject {
    xmlNodePtr node;
    XMLDocument *document;
    
    NSArray *cachedChildren;
    NSDictionary *cachedAttributes;
    NSString *cachedContent;
}

- (id)initWithNode:(xmlNodePtr)node_ inDocument:(XMLDocument *)document_;
- (NSString *)content;
- (NSString *)tagName;
- (NSArray *)children;
- (NSDictionary *)attributes;
- (NSString *)attributeWithName:(NSString *)name;
- (BOOL)isTextNode;
- (xmlNodePtr)node;

- (NSArray *)elementsMatchingPath:(NSString *)xpath;
- (XMLElement *)firstElementMatchingPath:(NSString *)xpath;

@end
