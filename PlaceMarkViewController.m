//
//  PlaceMarkViewController.m
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
//  THE SOFTWARE.//
//
//  Created by Matthaus Litteken on 8/6/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PlaceMarkViewController.h"


@implementation PlaceMarkViewController

@synthesize pmName, pmDescription, pmLatitude, pmLongitude, pmThreshold, placeMark;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		// Initialization code
	}
	return self;
}

- (IBAction) updateName:(id)sender {
	self.placeMark.pmName = self.pmName.text;
	[self.placeMark updateName];
}

- (IBAction) updateDescription:(id)sender {
	self.placeMark.description = self.pmDescription.text;
	[self.placeMark updateDescription];
}

- (IBAction) updateLatitude:(id)sender {
	self.placeMark.latitude = [[NSNumber alloc] initWithDouble: [self.pmLatitude.text doubleValue]];
	[self.placeMark updateLat:[[NSNumber alloc] initWithDouble: [pmLatitude.text doubleValue]]];
}

- (IBAction) updateLongitude:(id)sender {
	self.placeMark.longitude = [[NSNumber alloc] initWithDouble: [self.pmLongitude.text doubleValue]];
	[self.placeMark updateLong:[[NSNumber alloc] initWithDouble:[pmLongitude.text doubleValue]]];
}

- (IBAction) updateThreshold:(id)sender {
	self.placeMark.threshold = (NSInteger) self.pmThreshold;
	[self.placeMark updateThreshold:pmThreshold];
}
	
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
