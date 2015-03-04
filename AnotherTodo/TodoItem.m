//
//  TodoItem.m
//  AnotherTodo
//
//  Created by d on 3/3/15.
//  Copyright (c) 2015 Damian Martinez. All rights reserved.
//

#import "TodoItem.h"

// private interface (as class extension)
@interface TodoItem ()

@property (readwrite)NSDate *creationDate;
@property (readwrite)NSDate *completionDate;

@end

@implementation TodoItem


// convert self to a simple dict
- (NSDictionary*)dictionaryFromItem {
    // FIXME: TODO: what if a property value is nil?
    /*
    return @{
             @"itemName": self.itemName,
             @"creationDate": self.creationDate,
             @"completionDate": self.completionDate,
             @"isCompleted": [NSNumber numberWithBool:self.completed],
             };
     */
    NSMutableDictionary *itemDict = [NSMutableDictionary new];
    if (self.itemName) {
        itemDict[@"itemName"] = self.itemName;
    }
    if (self.creationDate) {
        itemDict[@"creationDate"] = self.creationDate;
    }
    if (self.completionDate) {
        itemDict[@"completionDate"] = self.completionDate;
    }
    if (self.isCompleted) {
        // in order to represent a BOOL in an NSDictionary, we have to convert it to an id'd Object
        itemDict[@"isCompleted"] = [NSNumber numberWithBool:self.completed];
    }
    return itemDict;
}

@end
