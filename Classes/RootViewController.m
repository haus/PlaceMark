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
	
	// Add the following line if you want the list to be editable
	// self.navigationItem.leftBarButtonItem = self.editButtonItem;
	
	self.title = @"PlaceMarks";
	self.navigationItem.leftBarButtonItem = self.editButtonItem;
	
	UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithTitle:@"Add" 
															style:UIBarButtonItemStyleBordered target:self action:@selector(addPlaceMark:)];
	self.navigationItem.rightBarButtonItem = btn;
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

- (void) addPlaceMark:(id)sender {
	PlaceMarkAppDelegate *placeMarkAppDelegate = (PlaceMarkAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	if (self.placeMarkView == nil) {
		PlaceMarkViewController *viewController = [[PlaceMarkViewController alloc]
											  initWithNibName:@"PlaceMarkViewController" bundle:[NSBundle mainBundle]];
		self.placeMarkView = viewController;
		[viewController release];
	}
	
	PlaceMark *pm = [placeMarkAppDelegate addPlaceMark];
	[self.navigationController pushViewController:self.placeMarkView animated:YES];
	self.placeMarkView.placeMark = pm;
	self.placeMarkView.title = pm.pmName;
	[self.placeMarkView.pmName setText:pm.pmName];
	[self.placeMarkView.pmDescription setText:pm.description];
	[self.placeMarkView.pmLatitude setText:[pm.latitude stringValue]];
	[self.placeMarkView.pmLongitude setText:[pm.longitude stringValue]];
	[self.placeMarkView.pmThreshold setValue: pm.threshold];
	[self.placeMarkView.pmThresholdLabel setText:[NSString stringWithFormat:@"%d", pm.threshold]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	PlaceMarkAppDelegate *placeMarkAppDelegate = (PlaceMarkAppDelegate *)[[UIApplication sharedApplication] delegate];
	PlaceMark *pm = (PlaceMark *)[placeMarkAppDelegate.placemarks objectAtIndex:indexPath.row];
	
	if(self.placeMarkView == nil) {
		PlaceMarkViewController *viewController = [[PlaceMarkViewController alloc] 
											  initWithNibName:@"PlaceMarkViewController" bundle:[NSBundle mainBundle]];
		self.placeMarkView = viewController;
		[viewController release];
	}
	
	[self.navigationController pushViewController:self.placeMarkView animated:YES];
	self.placeMarkView.placeMark = pm;
	self.placeMarkView.title = pm.pmName;
	[self.placeMarkView.pmName setText:pm.pmName];
	[self.placeMarkView.pmDescription setText:pm.description];
	[self.placeMarkView.pmLatitude setText:[pm.latitude stringValue]];
	[self.placeMarkView.pmLongitude setText:[pm.longitude stringValue]];
	
	NSInteger threshold = pm.threshold;
	if (threshold > 250 || threshold < 0) {
		threshold = 25;
	}

	[self.placeMarkView.pmThreshold setValue:pm.threshold];
	[self.placeMarkView.pmThresholdLabel setText:[NSString stringWithFormat:@"%d", pm.threshold + 1]];
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


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	PlaceMarkAppDelegate *placeMarkAppDelegate = (PlaceMarkAppDelegate *)[[UIApplication sharedApplication] delegate];
	PlaceMark *pm = (PlaceMark *)[placeMarkAppDelegate.placemarks objectAtIndex:indexPath.row];
	
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		[placeMarkAppDelegate removePlaceMark:pm];
		// Delete the row from the data source
		[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
		//[self.tableView reloadData];
	}	
}


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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [super dealloc];
}


@end