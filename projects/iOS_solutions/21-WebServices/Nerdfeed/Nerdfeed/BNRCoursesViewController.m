//
//  BNRCoursesViewController.m
//  Nerdfeed
//
//  Created by John Gallagher on 1/9/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import "BNRCoursesViewController.h"
#import "BNRWebViewController.h"

// add a property to the class extension to hold onto an instance of NSURLSession
@interface BNRCoursesViewController () <NSURLSessionDelegate>

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, copy) NSArray *courses; //to hang on to that array, which is an array of NSDictionary objects that describle each course

@end

@implementation BNRCoursesViewController

// override initWithStyle: to create the NSURLSession object
- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.navigationItem.title = @"BNR Courses";

        // get a default configuration which will be passed in for the first argument of NSURLSession
        NSURLSessionConfiguration *config =
            [NSURLSessionConfiguration defaultSessionConfiguration];

        //the NSURLSession is created with a configuration, a delegate and a delegate queue
        
        _session = [NSURLSession sessionWithConfiguration:config
                                                 delegate:self
                                            delegateQueue:nil];

        [self fetchFeed]; //Kick off the exchange whenever the BNRCourseViewController is created.
    }
    return self;
}

- (void)viewDidLoad // override viewDidLoad to register the table view cell class
// update the data source methods so that each of the course titles are shown in the table
{
    [super viewDidLoad];

    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:@"UITableViewCell"];
}

- (void)fetchFeed // method fetchFeed can ask for the list of courses
{
    //create an NSURLRequest that connects to JSON data
    NSString *requestString = @"https://bookapi.bignerdranch.com/private/courses.json";
    // create an NSURL instance
    NSURL *url = [NSURL URLWithString:requestString];
    // and instantiate a request object with it
    NSURLRequest *req = [NSURLRequest requestWithURL:url];

    // use the NSURLSession to create an NSURLSessionTask that transfers this request to server
    NSURLSessionDataTask *dataTask =
        [self.session dataTaskWithRequest:req
                        completionHandler:
         ^(NSData *data, NSURLResponse *response, NSError *error) {
             
             // use NSJSONSerialization class to convert the raw JSON data into the basic foundation objects
             // The jsonObject is an instance of NSDictionary and it has an NSString key with an associated value of type NSArray
             NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data
                                                                        options:0
                                                                          error:nil];
             //NSURLSessionDataTask completion handler
             self.courses = jsonObject[@"courses"];

             NSLog(@"%@", self.courses);

             // use the dispatch_async function to force code to run on the main thread in order to reload the table view
             // reload the table view data on the main thread
             dispatch_async(dispatch_get_main_queue(), ^{
                 [self.tableView reloadData];
             });
         }];
    [dataTask resume];
}

// at the very begin, you can write stubs for the required data source methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.courses count]; //return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell =
        [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"
                                        forIndexPath:indexPath];

    NSDictionary *course = self.courses[indexPath.row];
    cell.textLabel.text = course[@"title"];

    return cell; //return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *course = self.courses[indexPath.row];
    NSURL *URL = [NSURL URLWithString:course[@"url"]];

    self.webViewController.title = course[@"title"];
    self.webViewController.URL = URL;
    [self.navigationController pushViewController:self.webViewController
                                         animated:YES];
}

- (void)  URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
 didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
   completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *))completionHandler
{
    NSURLCredential *cred =
        [NSURLCredential credentialWithUser:@"BigNerdRanch"
                                   password:@"AchieveNerdvana"
                                persistence:NSURLCredentialPersistenceForSession];
    completionHandler(NSURLSessionAuthChallengeUseCredential, cred);
}

@end
