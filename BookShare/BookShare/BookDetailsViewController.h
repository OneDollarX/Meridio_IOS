//
//  BookDetailsViewController.h
//  BookShare
//
//  Created by YILUN XU on 7/19/17.
//  Copyright © 2017 CarnegieMellonUniversity. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookDetailsViewController : UIViewController

@property (strong, nonatomic) NSString *bookISBN;

@property (strong, nonatomic) IBOutlet UIImageView *bookImageView;

@property (strong, nonatomic) IBOutlet UILabel *bookTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *bookCategoriesLabel;
@property (strong, nonatomic) IBOutlet UITextView *bookDescriptionsTextView;
- (IBAction)postClicked:(id)sender;

@end
