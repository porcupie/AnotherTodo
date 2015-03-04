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

- (id)initWithItemName:(NSString*)itemName completed:(BOOL)completed completionDate:(NSDate*)completionDate {
    self.itemName = itemName;
    self.completed = completed;
    self.completionDate = completionDate;
    return self;
}

// use designated initializer
- (id)init {
    return [self initWithItemName:@"Todo" completed:NO completionDate:nil]; 
}

// FIXME: TODO: is this a method somewhere else?  ie should i be calling [super initWithDictionary:dataDict]?
- (id)initWithDictionary:(NSDictionary*)dataDict {
    // convert any keys to right kind?
    NSNumber *completedObject = [dataDict objectForKey:@"isCompleted"];
    BOOL completedBool = [completedObject boolValue];
    
    return [self initWithItemName:[dataDict objectForKey:@"itemName"]
                        completed:completedBool
                   completionDate:[dataDict objectForKey:@"completionDate"]];
}

+ (id)todoItemWithDictionary:(NSDictionary*)dataDict {
    return [[self alloc] initWithDictionary:dataDict]; 
}

/*
 * Some utility methods for making easier to use JSON in/out
 * - there might be a better way to do this / a library to use,
 * this is more of a proof of concept and learning exercise
 */

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
    // how to tell if a BOOL is defined (not nil)
    //if (self.completed != nil) {
    // for now, just add if YES -- defaults to NO
    if (self.isCompleted) {
        // in order to represent a BOOL in an NSDictionary, we have to convert it to an id'd Object
        itemDict[@"isCompleted"] = [NSNumber numberWithBool:self.completed];
    }
    return itemDict;
}




@end
