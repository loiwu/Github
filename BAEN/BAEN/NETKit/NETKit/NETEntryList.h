//
//  NETEntryList.h
//  NETKit
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import "NETShared.h"
#import "NETContainer.h"
#import "NETUser.h"

typedef NSString *NETEntryListIdentifier;

#define kNETEntryListIdentifierSubmissions @"news"
#define kNETEntryListIdentifierNewSubmissions @"newest"
#define kNETEntryListIdentifierBestSubmissions @"best"
#define kNETEntryListIdentifierActiveSubmissions @"active"
#define kNETEntryListIdentifierClassicSubmissions @"classic"
#define kNETEntryListIdentifierAskSubmissions @"ask"
#define kNETEntryListIdentifierBestComments @"bestcomments"
#define kNETEntryListIdentifierNewComments @"newcomments"
#define kNETEntryListIdentifierUserSubmissions @"submitted"
#define kNETEntryListIdentifierUserComments @"threads"
#define kNETEntryListIdentifierSaved @"saved"

@interface NETEntryList : NETContainer {
    NETUser *user;
}

@property (nonatomic, retain, readonly) NETUser *user;

+ (id)session:(NETSession *)session entryListWithIdentifier:(NETEntryListIdentifier)identifier_ user:(NETUser *)user_;
+ (id)session:(NETSession *)session entryListWithIdentifier:(NETEntryListIdentifier)identifier_;

@end
