//
//  TodoDocument.h
//  AnotherTodo
//
//  Created by d on 3/3/15.
//  Copyright (c) 2015 Damian Martinez. All rights reserved.
//

// To get this Document class to be loadable in my iOS application, I had to setup the Xcode project info.
//  1. created a new exported UTI (com.example.AnotherTodo.yatodoList) that conforms to public.utf8-plain-text
//  2. added a new Document Type for that UTI, made sure the app was registered as the Editor and the Owner of any yatodoList files
// https://developer.apple.com/library/ios/qa/qa1587/_index.html
// https://developer.apple.com/library/ios/documentation/DataManagement/Conceptual/DocumentBasedAppPGiOS/DocumentImplPreflight/DocumentImplPreflight.html

#import <UIKit/UIKit.h>

#import "TodoItem.h"

@interface TodoDocument : UIDocument 

// UIDocument has fileURL and localizedName and documentName already - do we need another?
//@property NSString *friendlyName;

// temp store the data from file -- is this needed?
@property (nonatomic, strong) NSData* documentData;

// keep a list of todoItems
// FIXME: does this need to also be (nonatomic, strong) ?
@property (nonatomic, strong) NSMutableArray *todoItems;

// provide a convenience helper to add a TodoItem directly -- or do synthesized accessors get created already?
- (void)addTodoItem:(TodoItem*)item;

- (NSInteger)countOfTodoItems;

// class method to build new TodoItems from JSON Data
+ (NSMutableArray *)todoItemsFromDocumentData:(NSData *)data error:(NSError **)outError;

// Listing 4-1  Getting a URL to the application’s Documents directory in the local sandbox
+ (NSURL *)LocalDocumentsDirectoryURL;

+ (NSString*)DefaultNewFilename;
+ (NSURL*)DefaultDocumentURLForFilename:(NSString*)filename;

+ (id)todoDocumentWithFilename:(NSString*)filename;

@end
