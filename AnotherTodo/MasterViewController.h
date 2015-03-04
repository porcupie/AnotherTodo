//
//  MasterViewController.h
//  AnotherTodo
//
//  Created by d on 3/3/15.
//  Copyright (c) 2015 Damian Martinez. All rights reserved.
//
// Use this controller to list all the TodoDocuments 

#import <UIKit/UIKit.h>

#import "TodoDocumentTableViewController.h"

@class DetailViewController;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) DetailViewController *detailViewController;

// want to keep reference to the Detail controller - in this case, our TodoDocumentTableViewController
@property (strong, nonatomic) TodoDocumentTableViewController *todoDocumentController;

@end

