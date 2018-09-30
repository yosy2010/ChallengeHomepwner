//
//  BNRDetailViewController.m
//  Homepwner
//
//  Created by YASSER ALTAMIMI on 26/09/2018.
//  Copyright © 2018 YASSER ALTAMIMI. All rights reserved.
//

#import "BNRDetailViewController.h"
#import "BNRItem.h"
#import "BNRImageStore.h"


@interface BNRDetailViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate>

// we connnect only the stuff that we need as varibles in our code
@property (weak, nonatomic) IBOutlet UITextField *nameFeild;
@property (weak, nonatomic) IBOutlet UITextField *serialFeild;
@property (weak, nonatomic) IBOutlet UITextField *valueFeild;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;

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
    self.imageView.image = [[BNRImageStore SharedStore] imageforKey:self.item.itemKey];
   
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

// take picture button
- (IBAction)takePicture:(id)sender
{
    // create a UIImagePickerController instance
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
    
    // if the phone has camera, then go there, if it doesn't then show photo library
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    // set the delegate
    imagePickerController.delegate = self;
    
    // go there
    [self presentViewController:imagePickerController
                       animated:YES
                     completion:nil];
}

// override settter method for item to set the title of the view controller to the name of the item
- (void)setItem:(BNRItem *)item
{
    _item = item;
    self.navigationItem.title = _item.itemName;
}

// after the user chose the picture, this method will get called
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info
{
    // get the picked image from the info dictionary
    UIImage *pickedImage = info[UIImagePickerControllerOriginalImage];
    
    // place it in the detail page
    self.imageView.image = pickedImage;
    
    // save it to the image store using the key of the item
    [[BNRImageStore SharedStore] setImage:pickedImage
                                   forKey:self.item.itemKey];
    
    // take the image picker of the screen
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}

// this to dismiss the keyboard if the return key is tapped
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

// when backGround is tapped, dismiss the keyboard
- (IBAction)backGroundTapped:(id)sender
{
    [self.view endEditing:YES];
}

@end
