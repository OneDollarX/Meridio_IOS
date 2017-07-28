//
//  RequestBookDetailViewController.h
//  BookShare
//
//  Created by YILUN XU on 7/28/17.
//  Copyright © 2017 CarnegieMellonUniversity. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RequestBookDetailViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *requestBookImageView;
@property (strong, nonatomic) IBOutlet UILabel *requestBookTitle;
@property (strong, nonatomic) IBOutlet UILabel *requestBookCategories;
@property (strong, nonatomic) IBOutlet UITextView *requestBookDescription;


@property (strong, nonatomic) NSString *requestBookIsbn;
@property (strong, nonatomic) NSString *requestBookId;

- (IBAction)reqeustBook:(id)sender;

@end