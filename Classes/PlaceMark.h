//
//  PlaceMark.h
//  PlaceMark
//
//  Created by Matthaus Litteken on 7/30/10.
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

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface PlaceMark : NSObject {
	sqlite3		*database;
	NSString	*pmName;
	NSString	*description;
	NSInteger	primaryKey;
	NSNumber	*latitude;
	NSNumber	*longitude;
	NSInteger	threshold;
	double		distance;
	BOOL		dirty;
}

@property (assign, nonatomic, readonly) NSInteger primaryKey;
@property (nonatomic, retain) NSString *pmName;
@property (nonatomic, retain) NSString *description;
@property (nonatomic, retain) NSNumber *latitude;
@property (nonatomic, retain) NSNumber *longitude;
@property (nonatomic) double distance;
@property (nonatomic) NSInteger threshold;

- (id)initWithPrimaryKey:(NSInteger)pk database:(sqlite3 *)db;
- (void)updateThreshold:(NSInteger) newThreshold;
- (void)updateLat:(NSNumber *) newLatitude;
- (void)updateLong:(NSNumber *) newLongitude;
- (void)updateName;
- (void)updateDescription;
- (void)dehydrate;
- (void)deleteFromDatabase;
+ (NSInteger)insertNewPlaceMarkIntoDatabase:(sqlite3 *) database;

@end

