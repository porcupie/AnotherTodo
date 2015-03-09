//
//  TodoDocument.m
//  AnotherTodo
//
//  Created by d on 3/3/15.
//  Copyright (c) 2015 Damian Martinez. All rights reserved.
//

#import "TodoDocument.h"
#import "TodoItem.h"

// TodoDocument
// Data storage: json plain text, array of hashes, each hash a TodoItem
// [{}, ...]

@implementation TodoDocument

static NSString *FILE_EXTENSION = @"yatodoList";
static NSString *EMPTY_JSON = @"[]";

// typed helper to add a todo to array
- (void)addTodoItem:(TodoItem*)item {
    [self.todoItems addObject:item];
}

- (NSInteger)countOfTodoItems {
    if (self.todoItems && [self.todoItems respondsToSelector:@selector(count)]) {
        return [self.todoItems count];
    } else {
        return 0;
    }
}


// loading document data happens in this callback
- (BOOL)loadFromContents:(id)contents ofType:(NSString *)typeName error:(NSError *__autoreleasing *)outError {
    // check if any data exists
    if ([contents length] > 0) {
        // extract a String from the NSData object
        //self.documentData = [[NSString alloc] initWithData:(NSData*)contents encoding:NSUTF8StringEncoding];
        self.documentData = (NSData*)contents;
    } else {
        // empty document is empty array
        self.documentData = [EMPTY_JSON dataUsingEncoding:NSUTF8StringEncoding];
    }
    // now - how should we convert JSON -> NSArray? ...
    // and does that happen here or in another callback?
    self.todoItems = [TodoDocument todoItemsFromDocumentData:self.documentData error:outError];
    
    if (outError != nil) {
        return NO;
    }
    
    // FIXME: notify a delegate ??
    // if ([_delegate respondsToSelector:@selector(noteDocumentContentsUpdated:)]) {
    //     [_delegate noteDocumentContentsUpdated:self];
    // }
    return YES;
}


// use a class method to build the Array of TodoItems from JSON Data
+ (NSMutableArray *)todoItemsFromDocumentData:(NSData *)data error:(NSError *__autoreleasing *)outError {
    NSMutableArray *convertedItems = [[NSMutableArray alloc] init];

    if ([data length] > 0) {
        // first get an array of hashes for what is in the json
        NSError *jsError = nil;
        NSArray *tempItems = [NSJSONSerialization 
                                JSONObjectWithData:data 
                                options:kNilOptions
                                error:&jsError];
        if (jsError != nil) {
            *outError = jsError;
            NSLog(@"%@", [jsError localizedDescription]);
            return nil;
        }
        else {
            // next, convert each hash into a TodoItem ...
            for (NSDictionary *dataItem in tempItems) {
                TodoItem *todoItem = [TodoItem new];
                // generic key-assignment loop
                for (NSString *key in dataItem) {
                    if ([todoItem respondsToSelector:NSSelectorFromString(key)]) {
                        [todoItem setValue:[dataItem valueForKey:key] forKey:key];
                    }
                }
                [convertedItems addObject:todoItem];
            }
        }
    }
    return convertedItems;
}

/*
 When a document is closed or when it is automatically saved, UIDocument sends 
 the document object a contentsForType:error: message. You must override this 
 method to return a snapshot of the document’s data to UIDocument, which then 
 writes it to the document file
 */
// return a snapshot of document data for storage
- (id)contentsForType:(NSString *)typeName error:(NSError *__autoreleasing *)outError {
    self.documentData = [TodoDocument dataFromTodoItems:self.todoItems error:outError];
    
    return self.documentData;
}

// FIXME: TODO: what about the filename and stuff ?

// use a class method to encapsulate conversion -> to JSON NSData
+ (NSData *)dataFromTodoItems:(NSArray*)items error:(NSError **)outError {
    if ([items count] > 0) {
        // gather a Dictionary of each TodoItem into an Array
        NSMutableArray *itemArray = [NSMutableArray new];
        for (TodoItem *todoItem in items) {
            [itemArray addObject:[todoItem dictionaryFromItem]];
        }
        
        // convert Array to JSON for storage
        NSError *jsError;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:itemArray options:NSJSONWritingPrettyPrinted error:&jsError];
        
        if (jsError != nil) {
            *outError = jsError;
            NSLog(@"%@", [jsError localizedDescription]);
            return nil;
        }
        else {
            return jsonData;
        }
    }
    else {
        // if no items, then empty document
        return [EMPTY_JSON dataUsingEncoding:NSUTF8StringEncoding];
    }
}

// not sure if class methods is best, but wanted to use in my class constructor

// Listing 4-1  Getting a URL to the application’s Documents directory in the local sandbox
// from UIDocument guide: https://developer.apple.com/library/ios/documentation/DataManagement/Conceptual/DocumentBasedAppPGiOS/ManageDocumentLifeCycle/ManageDocumentLifeCycle.html#//apple_ref/doc/uid/TP40011149-CH4-SW7
//
+ (NSURL*)LocalDocumentsDirectoryURL {
    // what does this mean? does it get set to nil on every invocation? or does static mean only first time? 
    static NSURL *localDocumentsDirectoryURL = nil;
    if (localDocumentsDirectoryURL == nil) {
        NSString *documentsDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        localDocumentsDirectoryURL = [NSURL fileURLWithPath:documentsDirectoryPath];
    }
    return localDocumentsDirectoryURL;
}

// generate a simple (unique(?)) filename - using timestamp
+ (NSString*)DefaultNewFilename {
    return [NSString stringWithFormat:@"%@", [NSDate date]];
}

// create new file url by appending filename or DefaultNewFilename to local documents URL
+ (NSURL*)DefaultDocumentURLForFilename:(NSString*)filename {
    NSURL *base = [self LocalDocumentsDirectoryURL];
    if (filename && [filename length] > 0) {
        return [base URLByAppendingPathComponent:filename];
    }
    else {
        return [base URLByAppendingPathComponent:[self DefaultNewFilename]];
    }
}

// allocate and create new Document
+ (id)todoDocumentWithFilename:(NSString *)filename {
    NSURL* newDocURL = [self DefaultDocumentURLForFilename:filename];
    
    // alloc and init document
    TodoDocument *newDoc = [[TodoDocument alloc] initWithFileURL:newDocURL];
    
    return newDoc;
}


// TODO: do we need to override init so that it creates a new mutable array for the todoItems?
- (id)initWithFileURL:(NSURL *)url {
    self = [super initWithFileURL:url];
    
    // set up a simple display name? -- READONLY property :/
    //self.localizedName = @"Todo";
    
    // set up an empty list for todoItems
    self.todoItems = [NSMutableArray new];
    
    return self;
}

@end
