//
//  PlaceMark.m
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

#import "PlaceMark.h"

static sqlite3_stmt *init_statement = nil;
static sqlite3_stmt *dehydrate_statment = nil;
static sqlite3_stmt *delete_statement = nil;
static sqlite3_stmt *insert_statement = nil;

@implementation PlaceMark

@synthesize primaryKey,description,latitude,longitude,pmName,threshold,distance;

+ (NSInteger)insertNewPlaceMarkIntoDatabase:(sqlite3 *)database {
	if (insert_statement == nil) {
		static char *sql = "INSERT INTO placemark (pmName, description, latitude, longitude, threshold) VALUES ('New PlaceMark', 'Description, '0', '0', '25')";
		if (sqlite3_prepare_v2(database, sql, -1, &insert_statement, NULL) != SQLITE_OK) {
			NSAssert1(0, @"Error: failed to prepare statment with message '%s'.", sqlite3_errmsg(database));
		}
	}
	
	int success = sqlite3_step(insert_statement);
	
	sqlite3_reset(insert_statement);
	
	if (success != SQLITE_ERROR) {
		return sqlite3_last_insert_rowid(database);
	}
	
	NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
	return -1;
}

- (void) deleteFromDatabase {
	if (delete_statement == nil) {
		const char *sql = "DELETE FROM placemark WHERE pk=?";
		
		if (sqlite3_prepare_v2(database, sql, -1, &delete_statement, NULL) != SQLITE_OK) {
			NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
		}
	}	
	
	sqlite3_bind_int(delete_statement, 1, self.primaryKey);
	int success = sqlite3_step(delete_statement);
	
	if (success != SQLITE_DONE) {
		NSAssert1(0, @"Error: failed to delete todo with message '%s'.", sqlite3_errmsg(database));
	}
	
	sqlite3_reset(delete_statement);
}


- (id)initWithPrimaryKey:(NSInteger)pk database:(sqlite3 *)db {
	
	if (self = [super init]) {
        primaryKey = pk;
        database = db;
        // Compile the query for retrieving book data. See insertNewBookIntoDatabase: for more detail.
        if (init_statement == nil) {
            // Note the '?' at the end of the query. This is a parameter which can be replaced by a bound variable.
            // This is a great way to optimize because frequently used queries can be compiled once, then with each
            // use new variable values can be bound to placeholders.
            const char *sql = "SELECT pmName, description, latitude, longitude, threshold FROM placemark WHERE pk = ?";
            if (sqlite3_prepare_v2(database, sql, -1, &init_statement, NULL) != SQLITE_OK) {
                NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
            }
        }
        // For this query, we bind the primary key to the first (and only) placeholder in the statement.
        // Note that the parameters are numbered from 1, not from 0.
        sqlite3_bind_int(init_statement, 1, primaryKey);
        if (sqlite3_step(init_statement) == SQLITE_ROW) {
            self.pmName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(init_statement, 0)];
			self.description = [NSString stringWithUTF8String:(char *)sqlite3_column_text(init_statement, 1)];
			self.latitude = [[NSNumber alloc] initWithDouble:sqlite3_column_double(init_statement, 2)];
			self.longitude = [[NSNumber alloc] initWithDouble:sqlite3_column_double(init_statement, 3)];
			self.threshold = sqlite3_column_int(init_statement,4);
			self.distance = 0;
        } else {
            self.pmName = @"Nothing";
        }
        // Reset the statement for future reuse.
        sqlite3_reset(init_statement);
    }
    return self;
}

- (void)updateLat:(NSNumber *)newLatitude {
	self.latitude = newLatitude;
	dirty = YES;
	
}

- (void)updateLong:(NSNumber *)newLongitude {
	self.longitude = newLongitude;
	dirty = YES;
}

- (void)updateThreshold:(NSInteger)newThreshold {
	self.threshold = newThreshold;
	dirty = YES;
}

- (void)updateName {
	dirty = YES;
}

- (void)updateDescription {
	dirty = YES;
}

- (void) dehydrate {
	if(dirty) {
		
		if (dehydrate_statment == nil) {
			const char *sql = "UPDATE placemark SET pmName = ?, description = ?, latitude = ?, longitude = ?, threshold = ? WHERE pk=?";
			if (sqlite3_prepare_v2(database, sql, -1, &dehydrate_statment, NULL) != SQLITE_OK) {
				NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
			}
		}
		
		sqlite3_bind_int(dehydrate_statment, 6, self.primaryKey);
		sqlite3_bind_int(dehydrate_statment, 5, self.threshold);
		sqlite3_bind_double(dehydrate_statment, 4, [self.longitude doubleValue]);
		sqlite3_bind_double(dehydrate_statment, 3, [self.latitude doubleValue]);
		sqlite3_bind_text(dehydrate_statment, 2, [self.description UTF8String], -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(dehydrate_statment, 1, [self.pmName UTF8String], -1, SQLITE_TRANSIENT);
		int success = sqlite3_step(dehydrate_statment);
		
		if (success != SQLITE_DONE) {
			NSAssert1(0, @"Error: failed to save priority with message '%s'.", sqlite3_errmsg(database));
		}
		
		sqlite3_reset(dehydrate_statment);
		dirty = NO;
	}
	
}

@end