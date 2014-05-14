 CHAP_04 Constructing and Using Table Views
 
 
 4.0. Introduction
 
 
 (1) A table view is simply a scrolling view that is separated into sections, each of which is further separated into rows. 
 Each row is an instance of the UITableViewCell class, and you can create custom table view rows by subclassing this class.
 
 (2) Using table views is an ideal way to present a list of items to users. 
 You can embed images, text, and other objects into your table view cells; 
 you can customize their height, shape, grouping, and much more. 
 The simplicity of the structure of table views is what makes them highly customizable.
 
 (3) A table view can be fed with data using a table view data source, 
 and you can receive various events and control the physical appearance of table views using a table view delegate object.
 These are defined, respectively, in the UITableViewDataSource and UITableViewDelegate protocols.
 
 (4) Although an instance of UITableView subclasses UIScrollView, table views can only scroll vertically. 
 This is more a feature than a limitation. 
 
 
 (5) The way to instantiate UITableView is through its initWithFrame:style: method. 
 
 <1> initWithFrame
 
 This is a parameter of type CGRect. This specifies where the table view has to be positioned in its superview. 
 
 <2> style
 
 This is a parameter of type UITableViewStyle that is defined in this way:

typedef NS_ENUM(NSInteger, UITableViewStyle) { 
	UITableViewStylePlain, 
	UITableViewStyleGrouped
};

 (6) We feed data to a table view using its data source,
 Table views also have delegates that receive various events from the table view. 
 Delegate objects have to conform to the UITableViewDelegate protocol. 
 
 <1> 
 tableView:viewForHeaderInSection:
 <2>
 tableView:viewForFooterInSection:
 <3>
 tableView:didEndDisplayingCell:forRowAtIndexPath:
 <4>
 tableView:willDisplayCell:forRowAtIndexPath:
 
 +++++++++++++++++++++++++++++++++
 
  #import "ViewController.h"
@interface ViewController () <UITableViewDelegate> 
@property (nonatomic, strong) UITableView *myTableView; 
@end
@implementation ViewController - (void)viewDidLoad{
        [super viewDidLoad];
        self.myTableView = [[UITableView alloc]
                            initWithFrame:self.view.bounds
                            style:UITableViewStylePlain];
        self.myTableView.delegate = self;
        [self.view addSubview:self.myTableView];
    }
@end

 +++++++++++++++++++++++++++++++++
 
 (7) Messages sent to the delegate object of a table view carry a parameter 
 that tells the delegate object which table view has fired that message in its delegate. 
 This is very important to note because you might, under certain circumstances, 
 require more than one table view to be placed on one object (usually a view). Because of this, 
 it is highly recommended that you make your decisions based on which table view has actually sent that specific message to your delegate object
 
 +++++++++++++++++++++++++++++++++
 
 - (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	if ([tableView isEqual:self.myTableView]) { 
		return 100.0f;
	}
	return 40.0f;
 }

 +++++++++++++++++++++++++++++++++
 
 (8) The location of a cell in a table view is represented by its index path.
 An index path is the combination of the section and the row index, 
 where the section index is the zero- based index specifying which grouping or section each cell belongs to, 
 and the cell index is the zero-based index of that particular cell in its section.
 
 
 4.1. Populating a Table View with Data