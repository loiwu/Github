<br/>1. Implementing Controllers and Views
<br/>1.1. Displaying Alerts with UIAlertView
<br/>1.2. Creating and Using Switches with UISwitch
<br/>1.3. Customizing the UISwitch
<br/>1.4. Picking Values with the UIPickerView
<br/>1.5. Picking the Date and Time with UIDatePicker
<br/>1.6. Implementing Range Pickers with UISlider
<br/>1.7. Customizing the UISlider
<br/>1.8. Grouping Compact Options with UISegmentedControl
<br/>1.9. Presenting and Managing Views with UIViewController
<br/>1.10. Presenting Sharing Options with UIActivityViewController
<br/>1.11. Presenting Custom Sharing Options with UIActivityViewController 
<br/>1.12. Implementing Navigation with UINavigationController
<br/>1.13. Manipulating a Navigation Controller’s Array of View Controllers 
<br/>1.14. Displaying an Image on a Navigation Bar
<br/>1.15. Adding Buttons to Navigation Bars Using UIBarButtonItem
<br/>1.16. Presenting Multiple View Controllers with UITabBarController 
<br/>1.17. Displaying Static Text with UILabel
<br/>1.18. Customizing the UILabel
<br/>1.19. Accepting User Text Input with UITextField
<br/>1.20. Displaying Long Lines of Text with UITextView
<br/>1.21. Adding Buttons to the User Interface with UIButton
<br/>1.22. Displaying Images with UIImageView
<br/>1.23. Creating Scrollable Content with UIScrollView
<br/>1.24. Loading Web Pages with UIWebView
<br/>1.25. Displaying Progress with UIProgressView
<br/>1.26. Constructing and Displaying Styled Texts

<br/>2. Creating Dynamic and Interactive User Interfaces
<br/>2.1. Adding Gravity to Your UI Components
<br/>2.2. Detecting and Reacting to Collisions Between UI Components
<br/>2.3. Animating Your UI Components with a Push
<br/>2.4. Attaching Multiple Dynamic Items to Each Other
<br/>2.5. Adding a Dynamic Snap Effect to Your UI Components 
<br/>2.6. Assigning Characteristics to Your Dynamic Effects

<br/>3. Auto Layout and the Visual Format Language
<br/>3.1. Placing UI Components in the Center of the Screen 
<br/>3.2. Defining Horizontal and Vertical Constraints with the Visual Format Language 
<br/>3.3. Utilizing Cross View Constraints 
<br/>3.4. Configuring Auto Layout Constraints in Interface Builder 

<br/>4. Constructing and Using Table Views
<br/>4.1. Populating a Table View with Data
<br/>4.2. Using Different Types of Accessories in a Table View Cell 
<br/>4.3. Creating Custom Table View Cell Accessories 
<br/>4.4. Enabling Swipe Deletion of Table View Cells 
<br/>4.5. Constructing Headers and Footers in Table Views 
<br/>4.6. Displaying Context Menus on Table View Cells 
<br/>4.7. Moving Cells and Sections in Table Views 
<br/>4.8. Deleting Cells and Sections from Table Views 
<br/>4.9. Utilizing the UITableViewController for Easy Creation of Table Views 
<br/>4.10. Displaying a Refresh Control for Table Views

<br/>5. Building Complex Layouts with Collection Views
<br/>5.1. Constructing Collection Views 
<br/>5.2. Assigning a Data Source to a Collection View 
<br/>5.3. Providing a Flow Layout to a Collection View 
<br/>5.4. Providing Basic Content to a Collection View 
<br/>5.5. Feeding Custom Cells to Collection Views Using .xib Files
<br/>5.6. Handling Events in Collection Views
<br/>5.7. Providing a Header and a Footer in a Flow Layout
<br/>5.8. Adding Custom Interactions to Collection Views



<br/>Problems set
<br/>1.9. Presenting and Managing Views with UIViewController
<br/>Problem
<br/>You want to switch among different views in your application.
<br/>Solution
<br/>Use the UIViewController class.
<br/>Discussion
<br/>View controllers can be loaded from .xib files,or simply be created programmatically.
<br/>

<br/>4. Constructing and Using Table Views
<br/>
<br/>4.0. Introduction
<br/>
<br/>
<br/>4.1. Populating a Table View with Data
<br/>Problem
<br/>You would like to populate your table view with data.
<br/>Solution
<br/><1>Conform to the UITableViewDataSource protocol in an object 
<br/><2>Assign that object to the dataSource property of a table view.
<br/>
<br/>
<br/>++++++++++++++++++++++++
<br/>4.2. Using Different Types of Accessories in a Table View Cell
<br/>Problem
<br/>You want to grab users’ attention in a table view by displaying accessories 
<br/>and offer different ways to interact with each cell in your table view.
<br/>Solution
<br/>Use the accessoryType of the UITableViewCell class, 
<br/>instances of which you provide to your table view in its data source object:
<br/>
<br/>++++++++++++++++++++++++
<br/>4.3. Creating Custom Table View Cell Accessories Problem
<br/>The accessories provided to you by the iOS SDK are not sufficient, 
<br/>and you would like to create your own accessories.
<br/>Solution
<br/>Assign an instance of the UIView class to the accessoryView property of any instance 
<br/>of the UITableViewCell class:
<br/>
<br/>++++++++++++++++++++++++
<br/>
<br/>11. Networking, JSON, XML, and Sharing
<br/>////////////////////
<br/>11.0. Introduction
<br/> XML, JSON, and sharing options
<br/> connect to the Internet and retrieve and send data - NSURLConnection class.
<br/> JSON serialization and deserialization - NSJSONSerialization class
<br/> XML parsing - NSXMLParse class
<br/> manages the connectivity to web services in a more thorough way - NSURLSession class
<br/>////////////////////
<br/>11.1. Downloading Asynchronously with NSURLConnection
<br/>
<br/>Problem
<br/>to download a file from a URL, asynchronously.

<br/>Solution
<br/>Use the NSURLConnection class with an asynchronous request.

<br/>Discussion
<br/>the only difference between a synchronous and an asynchronous connection is that:
<br/>the runtime will create a thread for the asynchronous connection, 
<br/>while it won’t do the same for a synchronous connection.
<br/>
<br/>create an asynchronous connection
<br/>(1)an instance of NSString - URL
<br/>(2)an instance of NSURL - convert from the above URL
<br/>(3)
<br/> an instance of NSURLRequest - a URL Request 
<br/> an instance of NSMutableURLRequest - mutable URLs
<br/>(4)an instance of NSURLConnection, pass the URL request to it
<br/>
<br/> create an asynchronous URL connection using the class method of NSURLConnection. 
<br/>sendAsynchronousRequest:queue:completionHandler: 
<br/>
<br/>////////////////////
<br/>11.2. Handling Timeouts in Asynchronous Connections
<br/>Problem
<br/>set a wait limit—in other words, a timeout—on an asynchronous connection.
<br/>Solution
<br/>Set the timeout on the URL request that you pass to the NSURLConnection class.
<br/>Discussion
<br/>instantiating an object of type NSURLRequest to pass to your URL connection, 
<br/>use its requestWithURL:cachePolicy:timeoutInterval: class method and 
<br/>pass the desired number of seconds of your timeout as the timeoutInterval parameter.
<br/>
<br/>////////////////////
<br/>11.3. Downloading Synchronously with NSURLConnection
<br/>Problem
<br/>to download the contents of a URL, synchronously.
<br/>Solution
<br/>Use the sendSynchronousRequest:returningResponse:error: class method of NSURLConnection. 
<br/>The return value of this method is data of type NSData.
<br/>Discussion
<br/>Using the sendSynchronousRequest:returningResponse:error: class method of NSURLConnection
<br/>a synchronous URL connection won’t necessarily block the main thread, if managed properly. 
<br/>Synchronous connections are guaranteed to block the current thread, though.
<br/>Grand Central Dispatch - GCD
<br/>
<br/>////////////////////
<br/>11.4. Modifying a URL Request with NSMutableURLRequest
<br/>Problem
<br/>to adjust various HTTP headers and settings of a URL request before passing it to a URL connection.
<br/>Solution
<br/>Use NSMutableURLRequest instead of NSURLRequest.
<br/>Discussion
<br/>A URL request can be either mutable or immutable. 
<br/>A mutable URL request can be changed after it has been allocated and initialized, 
<br/>whereas an immutable URL request cannot. Mutable URL requests are the target of this recipe. 
<br/>You can create them using the NSMutableURLRequest class.
<br/>
<br/>////////////////////
<br/>11.5. Sending HTTP GET Requests with NSURLConnection
<br/>Problem
<br/>to send a GET request over the HTTP protocol and perhaps pass parameters along your request to the receiver.
<br/>Solution
<br/>By convention, GET requests allow parameters through query strings of the familiar form:
<br/>   "http://example.com/?param1=value1&param2=value2..."
<br/>use strings to provide the parameters in the conventional format.
<br/>Discussion
<br/>A GET request is a request to a web server to retrieve data. 
<br/>The request usually carries some parameters, 
<br/>which are sent in a query string as part of the URL.
<br/>
<br/>////////////////////
<br/>11.6. Sending HTTP POST Requests with NSURLConnection
<br/>Problem
<br/>You want to call a web service using the HTTP POST method, 
<br/>and perhaps pass pa‐ rameters (as part of the HTTP body or in the query string) to the web service.
<br/>Solution
<br/>Just as with the GET method, we can use the POST method using NSURLConnection. 
<br/>We must explicitly set our URL’s method to POST.
<br/>Discussion
<br/>create an asynchronous connection and send a few parameters as a query string 
<br/>and a few parameters in the HTTP body to a URL
<br/>
<br/>////////////////////
<br/>11.7. Sending HTTP DELETE Requests with NSURLConnection
<br/>Problem
<br/>to call a web service using the HTTP DELETE method to delete a resource from a URL, 
<br/>and perhaps pass parameters, as part of the HTTP body or in the query string, to the web service.
<br/>Solution
<br/>Just as with the GET and POST methods, you can use the DELETE method using NSURLConnection. 
<br/>You must explicitly set your URL’s method to DELETE.
<br/>Discussion
<br/>create an asynchronous connection and send a few parameters as a query string 
<br/>and a few parameters in the HTTP body to the aforementioned URL, using the DELETE HTTP method
<br/>
<br/>////////////////////
<br/>11.8. Sending HTTP PUT Requests with NSURLConnection
<br/>Problem
<br/>You want to call a web service using the HTTP PUT method to place a resource into the web server, 
<br/>and perhaps pass parameters as part of the HTTP body or in the query string, to the web service.
<br/>Solution
<br/>Just as with the GET, POST, and DELETE methods, we can use the PUT method using NSURLConnection. 
<br/>We must explicitly set our URL’s method to PUT.
<br/>Discussion
<br/>create an asynchronous connection and send a few parameters as a query string 
<br/>and a few parameters in the HTTP body to the aforementioned URL using the PUT method:
<br/>
<br/>////////////////////
<br/>11.9. Serializing Arrays and Dictionaries into JSON Problem
<br/>to serialize a dictionary or an array into a JSON object that you can transfer over the network or simply save to disk.
<br/>Solution
<br/>Use the dataWithJSONObject:options:error: method of the NSJSONSerialization class.
<br/>Discussion
<br/>The dataWithJSONObject:options:error: method of the NSJSONSerialization class 
<br/>can serialize dictionaries and arrays that contain only instances of 
<br/>NSString, NSNum ber, NSArray, NSDictionary variables, or NSNull for nil values. 
<br/>
<br/>////////////////////
<br/>11.10. Deserializing JSON into Arrays and Dictionaries
<br/>Problem
<br/>You have JSON data, and you want to deserialize it into a dictionary or an array.
<br/>Solution
<br/>Use the JSONObjectWithData:options:error: method of the NSJSONSerialization class.
<br/>Discussion
<br/>The options parameter of the JSONObjectWithData:options:error: method accepts one or a mixture of the following values:
<br/>NSJSONReadingMutableContainers
<br/>The dictionary or the array returned by the JSONObjectWithData:options:er ror: method will be mutable. 
<br/>In other words, this method will return either an instance of NSMutableArray or NSMutableDictionary, 
<br/>as opposed to an immutable array or dictionary.
<br/>NSJSONReadingMutableLeaves
<br/>Leaf values will be encapsulated into instances of NSMutableString.
<br/>NSJSONReadingAllowFragments
<br/>Allows the deserialization of JSON data whose root top-level object is not an array or a dictionary.
<br/>
<br/>////////////////////
<br/>11.11. Integrating Social Sharing into Your Apps
<br/>Problem
<br/>You want to provide sharing capabilities in your app so that your user can compose 
<br/>a tweet or a Facebook status update on her device.
<br/>Solution
<br/>Incorporate the Social framework into your app and use 
<br/>the SLComposeViewControl ler class to compose social sharing messages, such as tweets.
<br/>Discussion
<br/>The SLComposeViewController class is available in the Social framework and with the Modules feature in the LLVM compiler. All you have to do to start using this framework is import its umbrella header file into your project like so:
<br/>    井import "ViewController.h"
<br/>    井import <Social/Social.h>
<br/>    @implementation ViewController
<br/>
<br/>////////////////////
<br/>11.12. Parsing XML with NSXMLParser 
<br/>Problem
<br/>You want to parse an XML snippet or document.
<br/>Solution
<br/>Use the NSXMLParser class. Discussion
The NSXMLParser uses a delegate model to parse XML content.