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

@interface BNRItemsViewController ()

@property (nonatomic, strong) IBOutlet UIView *headerView;

@end

@implementation BNRItemsViewController

// override init to make the style of the label laways plain
- (instancetype)init
{
    // call the designated initilizer
    self = [super initWithStyle:UITableViewStylePlain];
    
    if (self) {
        
        // create 5 itemes and put them in the store
        for (int i = 0; i < 5; i++) {
            [[BNRItemStore sharedStore] createItem];
        }
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

- (IBAction)addNewItem:(id)sender
{
    
}

- (IBAction)toggleEditingMode:(id)sender
{
    
}

@end
