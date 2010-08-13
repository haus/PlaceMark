//
//  PlaceMarkCell.m
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

#import "PlaceMarkCell.h"

static UIImage *distance1Image = nil;
static UIImage *distance2Image = nil;
static UIImage *distance3Image = nil;

@interface PlaceMarkCell()
- (UILabel *)newLabelWithPrimaryColor:(UIColor *)primaryColor selectedColor:
	(UIColor *)selectedColor fontSize:(CGFloat)fontSize bold:(BOOL)bold;
@end

@implementation PlaceMarkCell

@synthesize placeMarkNameLabel,placeMarkDistanceLabel,placeMarkDistanceImageView;

/*
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        // Initialization code
    }
    return self;
}
 */

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	
	[super setSelected:selected animated:animated];
	
	UIColor *backgroundColor = nil;
	if (selected) {
	    backgroundColor = [UIColor clearColor];
	} else {
		backgroundColor = [UIColor whiteColor];
	}
    
	self.placeMarkNameLabel.backgroundColor = backgroundColor;
	self.placeMarkNameLabel.highlighted = selected;
	self.placeMarkNameLabel.opaque = !selected;
	
	self.placeMarkDistanceLabel.backgroundColor = backgroundColor;
	self.placeMarkDistanceLabel.highlighted = selected;
	self.placeMarkDistanceLabel.opaque = !selected;
}

- (void)dealloc {
    [super dealloc];
}

+ (void)initialize {
    // The priority images are cached as part of the class, so they need to be
    // explicitly retained.
    distance1Image = [[UIImage imageNamed:@"red.png"] retain];
    distance2Image = [[UIImage imageNamed:@"yellow.png"] retain];
	distance3Image = [[UIImage imageNamed:@"green.png"] retain];
	
}

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
	if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) {
        UIView *myContentView = self.contentView;
        
		self.placeMarkDistanceImageView = [[UIImageView alloc] initWithImage:distance1Image];
		[myContentView addSubview:self.placeMarkDistanceImageView];
        [self.placeMarkDistanceImageView release];
        
        self.placeMarkNameLabel = [self newLabelWithPrimaryColor:[UIColor blackColor] 
											  selectedColor:[UIColor whiteColor] fontSize:14.0 bold:YES]; 
		self.placeMarkNameLabel.textAlignment = UITextAlignmentLeft; // default
		[myContentView addSubview:self.placeMarkNameLabel];
		[self.placeMarkNameLabel release];
		
        self.placeMarkDistanceLabel = [self newLabelWithPrimaryColor:[UIColor blackColor] 
												  selectedColor:[UIColor whiteColor] fontSize:10.0 bold:YES];
		self.placeMarkDistanceLabel.textAlignment = UITextAlignmentRight;
		[myContentView addSubview:self.placeMarkDistanceLabel];
		[self.placeMarkDistanceLabel release];
        
        // Position the todoPriorityImageView above all of the other views so
        // it's not obscured. It's a transparent image, so any views
        // that overlap it will still be visible.
        [myContentView bringSubviewToFront:self.placeMarkDistanceImageView];
    }
    return self;
}

- (PlaceMark *)placemark {
    return self.placemark;
}

- (void)setPlaceMark:(PlaceMark *)newPlaceMark {
	
    placemark = newPlaceMark;
    
    self.placeMarkNameLabel.text = newPlaceMark.pmName;
    self.placeMarkDistanceImageView.image = [self imageForDistance:newPlaceMark.distance:newPlaceMark.threshold];
    self.placeMarkDistanceLabel.text = 
		(newPlaceMark.distance == -1.0 ? @"Loading..." : [NSString stringWithFormat:@"%.1f", newPlaceMark.distance]);
	
    [self setNeedsDisplay];
}



- (void)layoutSubviews {
    
#define LEFT_COLUMN_OFFSET 1
#define LEFT_COLUMN_WIDTH 75
	
#define RIGHT_COLUMN_OFFSET 90
#define RIGHT_COLUMN_WIDTH 240
	
#define UPPER_ROW_TOP 4
    
    [super layoutSubviews];
    CGRect contentRect = self.contentView.bounds;
	
    if (!self.editing) {
		
        CGFloat boundsX = contentRect.origin.x;
		CGRect frame;
        
        // Place the Text label.
		frame = CGRectMake(boundsX +RIGHT_COLUMN_OFFSET  , UPPER_ROW_TOP, RIGHT_COLUMN_WIDTH, 13);
		frame.origin.y = 15;
		self.placeMarkNameLabel.frame = frame;
        
        // Place the priority image.
        UIImageView *imageView = self.placeMarkDistanceImageView;
        frame = [imageView frame];
		frame.origin.x = boundsX + LEFT_COLUMN_OFFSET;
		frame.origin.y = 10;
 		imageView.frame = frame;
        
        // Place the priority label.
        CGSize prioritySize = [self.placeMarkDistanceLabel.text sizeWithFont:self.placeMarkDistanceLabel.font 
															   forWidth:RIGHT_COLUMN_WIDTH lineBreakMode:UILineBreakModeTailTruncation];
        CGFloat priorityX = frame.origin.x + imageView.frame.size.width + 8.0;
        frame = CGRectMake(priorityX, UPPER_ROW_TOP, prioritySize.width, prioritySize.height);
		frame.origin.y = 15;
        self.placeMarkDistanceLabel.frame = frame;
    }
}

- (UILabel *)newLabelWithPrimaryColor:(UIColor *)primaryColor 
						selectedColor:(UIColor *)selectedColor fontSize:(CGFloat)fontSize bold:(BOOL)bold
{
	
    UIFont *font;
    if (bold) {
        font = [UIFont boldSystemFontOfSize:fontSize];
    } else {
        font = [UIFont systemFontOfSize:fontSize];
    }
    
	UILabel *newLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	newLabel.backgroundColor = [UIColor whiteColor];
	newLabel.opaque = YES;
	newLabel.textColor = primaryColor;
	newLabel.highlightedTextColor = selectedColor;
	newLabel.font = font;
	
	return newLabel;
}

- (UIImage *)imageForDistance:(double) distance:(NSInteger *) thresh {
	double threshold = [[[NSNumber alloc] initWithInt: thresh] doubleValue];
	if ((distance / threshold) < 2) {
		return distance3Image;
	} else if ((distance / threshold) < 5) {
		return distance2Image;
	} else if ((distance / threshold) > 5) {
		return distance1Image;
	} else {
		return nil;
	}
}


@end
