//
//  TodoDocument.m
//  AnotherTodo
//
//  Created by d on 3/3/15.
//  Copyright (c) 2015 Damian Martinez. All rights reserved.
//

#import "TodoDocument.h"
#import "TodoItem.h"

// TodoDocumen
// Data storage: json plain text, array of hashes, each hash a TodoItem
// [{}, ...]

@implementation TodoDocument

// loading data happens in this method
- (BOOL)loadFromContents:(id)contents ofType:(NSString *)typeName error:(NSError *__autoreleasing *)outError {
    // check if any data exists
    if ([contents length] > 0) {
        // extract a String from the NSData object
        //self.documentData = [[NSString alloc] initWithData:(NSData*)contents encoding:NSUTF8StringEncoding];
        self.documentData = (NSData*)contents;
    } else {
        // empty document is empty array
        self.documentData = [@"[]" dataUsingEncoding:NSUTF8StringEncoding];
    }
    // now - how should we convert JSON -> NSArray? ...
    // and does that happen here or in another callback?
    
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

@end
