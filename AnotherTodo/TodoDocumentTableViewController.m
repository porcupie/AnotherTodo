//
//  TodoDocumentTableViewController.m
//  AnotherTodo
//
//  Created by d on 4/3/15.
//  Copyright (c) 2015 Damian Martinez. All rights reserved.
//

#import "TodoDocumentTableViewController.h"
#import "AddTodoItemViewController.h"

@interface TodoDocumentTableViewController ()

@end

@implementation TodoDocumentTableViewController


// called to unwind from Adding a new Item to the TodoDocument
- (IBAction)unwindToDocument:(UIStoryboardSegue*)segue {
    // expecting to unwind from the Add item controller, so get it
    AddTodoItemViewController* addItemController = [segue sourceViewController];
    
    // figure out if we need to store a newly built item
    TodoItem *newItem = addItemController.todoItem;
    if (newItem != nil) {
        [self.todoDocument addTodoItem:newItem];
        // reload view
        [self.tableView reloadData];
    }
    
}

// called to (re)display the document view
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // setup the items from the document?
    // what if no document?
    if (self.todoDocument == nil) {
        // FIXME: TODO: how to create a new document?
        // self.todoDocument = ...
    }
    
    //
    
    // does the other controller make new documents for us?
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    // get the count of items from the document
    return [self.todoDocument countOfTodoItems];
}

// display of each individual TableCell for a TodoItem
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TodoItemPrototypeCell" forIndexPath:indexPath];
    
    // Configure the cell...
    TodoItem *cellItem = [self.todoDocument.todoItems objectAtIndex:indexPath.row];
    cell.textLabel.text = cellItem.itemName;
    
    // set accessory (checkmark or not)
    if (cellItem.completed) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark - Table view delegate

// what to do when a row is selected: toggle the checkmark
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // deselect row - don't want it selected, just want to toggle completed
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    // which item was tapped
    TodoItem *tappedItem = [self.todoDocument.todoItems objectAtIndex:indexPath.row];
    
    // toggle completion state of tapped item
    tappedItem.completed = !tappedItem.completed;
    
    // capture completed date (todo: readonly property, can't access here; write observer callback method on isCompleted)
    /*
    if (tappedItem.isCompleted) {
        tappedItem.completionDate = [NSDate new];
    }
     */
    
    // tell table view to reload the row
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

@end
