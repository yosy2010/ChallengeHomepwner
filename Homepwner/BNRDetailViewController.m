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

@end
