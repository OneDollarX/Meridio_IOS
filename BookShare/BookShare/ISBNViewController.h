//
//  ISBNViewController.h
//  BookShare
//
//  Created by YILUN XU on 7/19/17.
//  Copyright © 2017 CarnegieMellonUniversity. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ISBNViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *inputISBNTextView;
- (IBAction)goPressed:(id)sender;

@end
