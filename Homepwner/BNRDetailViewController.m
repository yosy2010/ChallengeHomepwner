//
//  BNRDetailViewController.m
//  Homepwner
//
//  Created by YASSER ALTAMIMI on 26/09/2018.
//  Copyright © 2018 YASSER ALTAMIMI. All rights reserved.
//

#import "BNRDetailViewController.h"
#import "BNRItem.h"

@interface BNRDetailViewController ()

// we connnect only the stuff that we need as varibles in our code
@property (weak, nonatomic) IBOutlet UITextField *nameFeild;
@property (weak, nonatomic) IBOutlet UITextField *serialFeild;
@property (weak, nonatomic) IBOutlet UITextField *valueFeild;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation BNRDetailViewController

// to implement the "DONE" bar button to dismiss the keyboard
- (void)viewDidLoad
{
    // create a bar button to dismiss the keyboard
    UIBarButtonItem *doneBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                      style:UIBarButtonItemStyleDone target:self
                                                                     action:@selector(cancelKeyboard:)];
    
    // set it to the right bar button
    self.navigationItem.rightBarButtonItem = doneBarButton;
}

// prepare before using
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

// override to set the properties of the detail view controller to the passed BNRItem
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // get the item passed
    BNRItem *item = self.item;
    
    // set the property to that item
    self.nameFeild.text = item.itemName;
    self.serialFeild.text = item.serialNumber;
    self.valueFeild.text = [NSString stringWithFormat:@"%d",item.valueInDollars];
   
    // convert the date into a string
    static NSDateFormatter *formatter = nil;
    if (!formatter) {
        formatter = [[NSDateFormatter alloc]init];
        formatter.dateStyle = NSDateFormatterMediumStyle;
        formatter.timeStyle = NSDateFormatterNoStyle;
    }
    
    // use set the date object content
    self.dateLabel.text = [formatter stringFromDate:item.dateCreated];
}

// override to save the new values of the items that the user changed
- (void)viewWillDisappear:(BOOL)animated
{
    // call super
    [super viewWillDisappear:animated];
    
    // resign first responder
    [self.view endEditing:YES];
    
    // save item changes
    self.item.itemName = self.nameFeild.text;
    self.item.serialNumber = self.serialFeild.text;
    self.item.valueInDollars = [self.valueFeild.text intValue];
}

// override settter method for item to set the title of the view controller to the name of the item
- (void)setItem:(BNRItem *)item
{
    _item = item;
    self.navigationItem.title = _item.itemName;
}

// to dismess the keyboard when the user hit done on the tool bar
-(IBAction)cancelKeyboard:(id)sender
{
    // [self view] give the view that the controller is manging right now, [endEditing:YES]; to end the editing of the current view
    // in our case we want to dismess the keyboard
    [[self view] endEditing:YES];
}
@end
