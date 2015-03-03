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

@end
