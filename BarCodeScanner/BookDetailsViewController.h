//
//  BookDetailsViewController.h
//  BarCodeScanner
//
//  Created by YILUN XU on 7/9/17.
//  Copyright © 2017 CarnegieMellonUniversity. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookDetailsViewController : UIViewController


@property (strong, nonatomic) NSString *bookISBN;

@property (strong, nonatomic) IBOutlet UIImageView *bookImageView;
@property (strong, nonatomic) IBOutlet UILabel *bookTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *bookAuthorLabel;
@property (strong, nonatomic) IBOutlet UILabel *bookCategoriesLabel;
@property (strong, nonatomic) IBOutlet UITextView *bookDescriptionsTextView;

@end
