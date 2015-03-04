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

static NSString *FILE_TYPE = @"todoitems";
static NSString *EMPTY_JSON = @"[]";

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


// use a class method to build the list of items from json data
+ (NSMutableArray *)todoItemsFromDocumentData:(NSData *)data error:(NSError *__autoreleasing *)outError {
    NSMutableArray *convertedItems;

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
            convertedItems = [[NSMutableArray alloc] init];
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


// use a class method to encapsulate conversion -> to JSON NSData
+ (NSData *)dataFromTodoItems:(NSArray*)items error:(NSError **)outError {
    if ([items count] > 0) {
        // gather the items into an Array of Dictionaries
        NSMutableArray *itemArray = [NSMutableArray new];
        for (TodoItem *todoItem in items) {
            [itemArray addObject:[todoItem dictionaryFromItem]];
        }
        // convert to JSON
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


@end
