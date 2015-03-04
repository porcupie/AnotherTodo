//
//  TodoDocument.h
//  AnotherTodo
//
//  Created by d on 3/3/15.
//  Copyright (c) 2015 Damian Martinez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TodoDocument : UIDocument 

// UIDocument has fileURL and localizedName and documentName already - do we need another?
//@property NSString *friendlyName;

// do we need to temp store the data from file?
@property (nonatomic, strong) NSData* documentData;

// keep a list of todoItems
// FIXME: does this need to also be (nonatomic, strong) ?
@property (nonatomic, strong) NSMutableArray *todoItems;


+ (NSMutableArray *)todoItemsFromDocumentData:(NSData *)data error:(NSError **)outError;

@end
