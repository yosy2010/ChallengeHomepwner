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

@property (nonatomic, strong) IBOutlet UIView *headerView;
@property (nonatomic, weak) IBOutlet UIButton *editButton; // so I can change its title inside methods that doesn't have sender
@end

@implementation BNRItemsViewController

// override init to make the style of the label laways plain
- (instancetype)init
{
    // call the designated initilizer
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        
    }
    return self;
}

// override initWithStyle (designated)
// let it call init which configer the style of the table
- (instancetype)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}


- (void)viewDidLoad
{
    // call super view did load
    [super viewDidLoad];
    
    // set the table view identifier to be reused
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:@"UITableViewCell"];
    
    // set the header for the tableView
    self.tableView.tableHeaderView = self.headerView;
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

// override the headerView getter
- (UIView *)headerView
{
    // if the header not loaded yet, load it into the view
    if (!_headerView) {
        _headerView = [[NSBundle mainBundle] loadNibNamed:@"Header"
                                                    owner:self
                                                  options:nil].firstObject;
    }
    
    return _headerView;
}
//٢٥٦٤٣٤
// new button
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

// edit button
- (IBAction)toggleEditingMode:(id)sender
{
    // is it on edition mode? change it and change the text to Edit
    if (self.isEditing) {
        [self setEditing:NO animated:YES];
        [self.editButton setTitle:@"Edit" forState:UIControlStateNormal];
      // not in editing mode? then make it, and change the text to Done
    } else {
        [self setEditing:YES animated:YES];
        [self.editButton setTitle:@"Done" forState:UIControlStateNormal];
    }
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
