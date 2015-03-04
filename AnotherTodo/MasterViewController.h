//
//  MasterViewController.h
//  AnotherTodo
//
//  Created by d on 3/3/15.
//  Copyright (c) 2015 Damian Martinez. All rights reserved.
//
// Use this controller to list all the TodoDocuments 

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) DetailViewController *detailViewController;


@end

