//
//  RootViewController.m
//  PlaceMark
//
//  Created by Matthaus Litteken on 7/15/10.
//  Copyright (c) 2010 Matthaus Litteken
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import "RootViewController.h"
#import "PlaceMarkAppDelegate.h"
#import "PlaceMarkViewController.h"
#import "PlaceMarkCell.h"
#import "PlaceMark.h"


@implementation RootViewController

@synthesize placeMarkView;


#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
	[self.tableView reloadData];
}

/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

/*
 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 */


#pragma mark -
#pragma mark Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	PlaceMarkAppDelegate *placeMarkDelegate = (PlaceMarkAppDelegate *)[[UIApplication sharedApplication] delegate];
    return placeMarkDelegate.placemarks.count;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *MyIdentifier = @"MyIdentifier";
	
	PlaceMarkCell *cell = (PlaceMarkCell *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
	if (cell == nil) {
		cell = [[[PlaceMarkCell alloc] initWithFrame:CGRectZero reuseIdentifier:MyIdentifier] autorelease];
	}
	
	PlaceMarkAppDelegate *placeMarkAppDelegate = (PlaceMarkAppDelegate *)[[UIApplication sharedApplication] delegate];
	PlaceMark *pm = [placeMarkAppDelegate.placemarks objectAtIndex:indexPath.row];
	
	[cell setPlaceMark:pm];
	
	// Set up the cell
	return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
	/*
	 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
	 [self.navigationController pushViewController:detailViewController animated:YES];
	 [detailViewController release];
	 */
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end

/*
 
@implementation RootViewController
@synthesize todoView;

- (void) addTodo:(id)sender {
	todoAppDelegate *appDelegate = (todoAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	if (self.todoView == nil) {
		TodoViewController *viewController = [[TodoViewController alloc]
											  initWithNibName:@"TodoViewController" bundle:[NSBundle mainBundle]];
		self.todoView = viewController;
		[viewController release];
	}
	
	Todo *todo = [appDelegate addTodo];
	[self.navigationController pushViewController:self.todoView animated:YES];
	self.todoView.todo = todo;
	self.todoView.title = todo.text;
	[self.todoView.todoText setText:todo.text];
}

- (void)viewDidLoad {
	// Add the following line if you want the list to be editable
	// self.navigationItem.leftBarButtonItem = self.editButtonItem;
	self.title = @"Todo Items";
	self.navigationItem.leftBarButtonItem = self.editButtonItem;
	
	UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithTitle:@"Add" 
															style:UIBarButtonItemStyleBordered target:self action:@selector(addTodo:)];
	self.navigationItem.rightBarButtonItem = btn;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	todoAppDelegate *appDelegate = (todoAppDelegate *)[[UIApplication sharedApplication] delegate];
    return appDelegate.todos.count;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	todoAppDelegate *appDelegate = (todoAppDelegate *)[[UIApplication sharedApplication] delegate];
	Todo *todo = (Todo *)[appDelegate.todos objectAtIndex:indexPath.row];
	
	if(self.todoView == nil) {
		TodoViewController *viewController = [[TodoViewController alloc] 
											  initWithNibName:@"TodoViewController" bundle:[NSBundle mainBundle]];
		self.todoView = viewController;
		[viewController release];
	}
	
	[self.navigationController pushViewController:self.todoView animated:YES];
	self.todoView.todo = todo;
	self.todoView.title = todo.text;
	[self.todoView.todoText setText:todo.text];
	
	NSInteger priority = todo.priority - 1;
	if(priority > 2 || priority < 0) {
		priority = 1;
	}
	priority = 2 - priority;
	
	[self.todoView.todoPriority setSelectedSegmentIndex:priority];
	
	if(todo.status == 1) {
		[self.todoView.todoButton setTitle:@"Mark As In Progress" forState:UIControlStateNormal];
		[self.todoView.todoButton setTitle:@"Mark As In Progress" forState:UIControlStateHighlighted];
		[self.todoView.todoStatus setText:@"Complete"];
	} else {
		[self.todoView.todoButton setTitle:@"Mark As Complete" forState:UIControlStateNormal];
		[self.todoView.todoButton setTitle:@"Mark As Complete" forState:UIControlStateHighlighted];
		[self.todoView.todoStatus setText:@"In Progress"];
	}
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	todoAppDelegate *appDelegate = (todoAppDelegate *)[[UIApplication sharedApplication] delegate];
	Todo *todo = (Todo *)[appDelegate.todos objectAtIndex:indexPath.row];
	
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		[appDelegate removeTodo:todo];
		// Delete the row from the data source
		[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
		//[self.tableView reloadData];
	}	
}



/*
 Override if you support conditional editing of the list
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


/*
 Override if you support rearranging the list
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */


/*
 Override if you support conditional rearranging of the list
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */ 



/*
- (void)viewWillAppear:(BOOL)animated {
	[self.tableView reloadData];
	[super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
}

- (void)viewDidDisappear:(BOOL)animated {
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
	// Release anything that's not essential, such as cached data
}

@end

*/