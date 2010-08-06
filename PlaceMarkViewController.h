//
//  PlaceMarkViewController.h
//  PlaceMark
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
	IBOutlet UISlider			*pmThreshold;
	PlaceMark					*placeMark;
}

@property(nonatomic,retain) IBOutlet UITextField        *pmName;
@property(nonatomic,retain) IBOutlet UITextField		*pmDescription;
@property(nonatomic,retain) IBOutlet UITextField		*pmLatitude;
@property(nonatomic,retain) IBOutlet UITextField		*pmLongitude;
@property(nonatomic,retain) IBOutlet UISlider			*pmThreshold;
@property(nonatomic,retain) PlaceMark					*placeMark;

- (IBAction) updateName:(id) sender;
- (IBAction) updateDescription:(id) sender;
- (IBAction) updateLatitude:(id) sender;
- (IBAction) updateLongitude:(id) sender;
- (IBAction) updateThreshold:(id) sender;

@end
