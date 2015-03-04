//
//  DetailViewController.h
//  AnotherTodo
//
//  Created by d on 3/3/15.
//  Copyright (c) 2015 Damian Martinez. All rights reserved.
//
// Use this to display a single TodoDocument's todo items


#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

