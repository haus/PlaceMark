//
//  PlaceMarkViewController.h
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

#import <UIKit/UIKit.h>
#import "PlaceMark.h"

@interface PlaceMarkViewController : UIViewController {
	IBOutlet UITextField        *pmName;
	IBOutlet UITextField		*pmDescription;
	IBOutlet UITextField		*pmLatitude;
	IBOutlet UITextField		*pmLongitude;
	IBOutlet UILabel			*pmThresholdLabel;
	IBOutlet UISlider			*pmThreshold;
	PlaceMark					*placeMark;
}

@property(nonatomic,retain) IBOutlet UITextField        *pmName;
@property(nonatomic,retain) IBOutlet UITextField		*pmDescription;
@property(nonatomic,retain) IBOutlet UITextField		*pmLatitude;
@property(nonatomic,retain) IBOutlet UITextField		*pmLongitude;
@property(nonatomic,retain)	IBOutlet UILabel			*pmThresholdLabel;
@property(nonatomic,retain) IBOutlet UISlider			*pmThreshold;
@property(nonatomic,retain) PlaceMark					*placeMark;

- (IBAction) updateName:(id) sender;
- (IBAction) updateDescription:(id) sender;
- (IBAction) updateLatitude:(id) sender;
- (IBAction) updateLongitude:(id) sender;
- (IBAction) updateThreshold:(id) sender;

@end
