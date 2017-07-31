//
//  ViewController.m
//  PopOverMenu
//
//  Created by YILUN XU on 7/31/17.
//  Copyright © 2017 CarnegieMellonUniversity. All rights reserved.
//

#import "ViewController.h"
#import "PopOverViewController.h"

@interface ViewController ()

@property (strong, nonatomic) PopOverViewController *PopVC;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)buttonClicked:(id)sender {
    
    /* Once the button is clicked, instantiate the pop over view controller*/
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.PopVC = [storyboard instantiateViewControllerWithIdentifier:@"PopOver"];
    
    /* In order to have the pop view controller as a pop over, modalPresentationStyle should be set as UIModalPresentationPopover. */
    self.PopVC.modalPresentationStyle = UIModalPresentationPopover;
    
    /* Also make sure you set the following parameters for pop over to work as expected. */
    self.PopVC.popoverPresentationController.barButtonItem = self.button;
    self.PopVC.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUnknown;
    
    
    self.PopVC.popoverPresentationController.delegate = self;
    

    [self presentViewController:self.PopVC animated:YES completion:nil];

}

#pragma mark - UIPopoverPresentationControllerDelegate

/* For delegate method below, make sure you return  UIModalPresentationStyle as UIModalPresentationNone. Because by default UIModalPresentationStyle is set as UIModalPresentationFullScreen which will display popover in full screen. */
- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller{
    return UIModalPresentationNone;
}
@end
