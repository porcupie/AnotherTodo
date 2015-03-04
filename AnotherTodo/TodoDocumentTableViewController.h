//
//  TodoDocumentTableViewController.h
//  AnotherTodo
//
//  Created by d on 4/3/15.
//  Copyright (c) 2015 Damian Martinez. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TodoDocument.h"

@interface TodoDocumentTableViewController : UITableViewController

// this controller will display one TodoDocument at a time ...
@property TodoDocument* todoDocument;

@end
