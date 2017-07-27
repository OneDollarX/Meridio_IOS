//
//  BooksAroundMeTableViewCell.h
//  BookShare
//
//  Created by Dhruv Prakash on 26/07/17.
//  Copyright © 2017 CarnegieMellonUniversity. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BooksAroundMeTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *bookAroundMeImage;
@property (strong, nonatomic) IBOutlet UILabel *bookAroundMeTitle;
@property (strong, nonatomic) IBOutlet UILabel *bookAroundMeId;

@end
