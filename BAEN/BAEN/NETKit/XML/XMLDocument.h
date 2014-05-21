//
//  XMLDocument.h
//  NETKit
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import <libxml/tree.h>
#import <libxml/parser.h>
#import <libxml/HTMLparser.h>
#import <libxml/xpath.h>
#import <libxml/xpathInternals.h>

#import "XMLElement.h"

@interface XMLDocument : NSObject {
    xmlDocPtr document;
}

- (id)initWithHTMLData:(NSData *)data_;
- (id)initWithXMLData:(NSData *)data_;
- (NSArray *)elementsMatchingPath:(NSString *)query relativeToElement:(XMLElement *)element;
- (NSArray *)elementsMatchingPath:(NSString *)xpath;
- (XMLElement *)firstElementMatchingPath:(NSString *)xpath;
- (xmlDocPtr)document;

@end
