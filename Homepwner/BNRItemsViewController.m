//
//  BNRItemsViewController.m
//  Homepwner
//
//  Created by YASSER ALTAMIMI on 22/09/2018.
//  Copyright © 2018 YASSER ALTAMIMI. All rights reserved.
//

#import "BNRItemsViewController.h"
#import "BNRItemStore.h"
#import "BNRItem.h"
#import "BNRDetailViewController.h"

@interface BNRItemsViewController ()

@property (nonatomic, weak) IBOutlet UIButton *editButton; // so I can change its title inside methods that doesn't have sender

@end

@implementation BNRItemsViewController

// override init to make the style of the label laways plain
- (instancetype)init
{
    // call the designated initilizer
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        // set the title of the navigation bar using the navigation item
        self.navigationItem.title = @"Homepwner";
        
        // create a bar button item that fills the bar button
        UIBarButtonItem *barButoonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                       target:self
                                                                                       action:@selector(addNewItem:)];
        
        // set to the rigght button
        self.navigationItem.rightBarButtonItem = barButoonItem;
        
        // add the left edit button, this line is built in the UIViewController as a property
        self.navigationItem.leftBarButtonItem = self.editButtonItem;
        
        
    }
    return self;
}

// override initWithStyle (designated)
// let it call init which configer the style of the table
- (instancetype)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    // call super view did load
    [super viewDidLoad];
    
    // set the table view identifier to be reused
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:@"UITableViewCell"];

    
}

// set the number of rws in each section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    BNRItemStore *store = [BNRItemStore sharedStore];
//    NSArray *items = store.allItems;
//    return items.count;
    // above is the same as:
    return [[[BNRItemStore sharedStore] allItems] count];
}

// return a cell and the parameter give an index of the currnet item in the data array
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // create a cell or reuse one that is ready
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    // get all the items
    NSArray *items = [[BNRItemStore sharedStore] allItems];
    
    // get the current item
    BNRItem *item = items[indexPath.row];
    
    // set the description of the item to the cell textLabel
    cell.textLabel.text = item.description;
    
    // return the cell
    return cell;
}

// new button in navigation bar
- (IBAction)addNewItem:(id)sender
{
    // create a new item and added it to the store
    BNRItem *newItem = [[BNRItemStore sharedStore] createItem];
    
    // get the position of that item in the array of items in the store
    NSInteger lastRow = [[[BNRItemStore sharedStore] allItems] indexOfObject:newItem];
    
    // create an array because the method that adds the rwo expect an array of indexPaths, so we created an array of one item only to pass
    NSArray *indexPaths = @[[NSIndexPath indexPathForRow:lastRow inSection:0]];
    
    // insert the row
    [self.tableView insertRowsAtIndexPaths:indexPaths
                          withRowAnimation:UITableViewRowAnimationTop];
}

// when in editing mode and the user press a button (delete ot edit)
// here the method provide to us the index path and the editing style
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    // if the user hit delete
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // get all the items in the store
        NSArray *items = [[BNRItemStore sharedStore] allItems];
        
        // get the item form the row
        // this will get us the item because the shred store and the rows are orgnized in the same order
        BNRItem *item = items[indexPath.row];
        
        // delete it from the store
        [[BNRItemStore sharedStore] removeItem:item];
        
        // put the index path in an array so we can pass it to the deleteing method after
        NSArray *indexPaths = @[indexPath];
        
        // delete it from the row
        [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:YES];
        
        // change the editing mode and text
        [self setEditing:NO animated:YES];
        [self.editButton setTitle:@"Edit" forState:UIControlStateNormal];
    }
    
}

// when the rows positions are moved, this method tell the data source about it
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [[BNRItemStore sharedStore] moveItemAtIndex:sourceIndexPath.row toIndex:destinationIndexPath.row];
}

// called when a user tab in an item in the table
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // wehn the user tab on an item, we should create the detaik controller
    BNRDetailViewController *detailViewController = [[BNRDetailViewController alloc]init];
    
    // get the item selected
    NSArray *items = [[BNRItemStore sharedStore]allItems];
    BNRItem *selectedItem = items[indexPath.row];
    
    // pass the pointer to the detail view controller
    detailViewController.item = selectedItem;
    
    // push into the detail view controller
    [self.navigationController pushViewController:detailViewController animated:YES];
    
}

@end
