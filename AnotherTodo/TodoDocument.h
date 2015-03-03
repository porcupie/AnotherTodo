//
//  TodoDocument.h
//  AnotherTodo
//
//  Created by d on 3/3/15.
//  Copyright (c) 2015 Damian Martinez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TodoDocument : UIDocument

// UIDocument has fileURL and localizedName
@property NSString *friendlyName;

// do we need to temp store the string data from file?
@property (nonatomic, strong) NSString* documentText;

// keep a list of todoItems
@property NSMutableArray *todoItems;

@end
