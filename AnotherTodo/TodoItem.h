//
//  TodoItem.h
//  AnotherTodo
//
//  Created by d on 3/3/15.
//  Copyright (c) 2015 Damian Martinez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TodoItem : NSObject

@property NSString *itemName;

@property (getter=isCompleted)BOOL completed;

@property (readonly)NSDate *creationDate;
@property (readonly)NSDate *completionDate;

// a method which can convert to a hash (for JSON output)
- (NSDictionary*)dictionaryFromItem;


// FIXME: should i have this method or an init method?  can i call an init method on an existing instance?
//- (void)loadFromDictionary:(NSDictionary*)dataDict;

// an init and class constructor method to allow setting from dictionary
- (id)initWithItemName:(NSString*)itemName completed:(BOOL)completed completionDate:(NSDate*)completionDate NS_DESIGNATED_INITIALIZER;
- (id)initWithDictionary:(NSDictionary*)dataDict;
+ (id)todoItemWithDictionary:(NSDictionary*)dataDict;

@end
