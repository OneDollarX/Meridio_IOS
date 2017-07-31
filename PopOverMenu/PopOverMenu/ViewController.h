//
//  ViewController.h
//  PopOverMenu
//
//  Created by YILUN XU on 7/31/17.
//  Copyright © 2017 CarnegieMellonUniversity. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIPopoverPresentationControllerDelegate>
- (IBAction)buttonClicked:(id)sender;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *button;

@end

