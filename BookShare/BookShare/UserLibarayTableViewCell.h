//
//  UserLibarayTableViewCell.h
//  BookShare
//
//  Created by YILUN XU on 7/26/17.
//  Copyright © 2017 CarnegieMellonUniversity. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserLibarayTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *userLibraryBookImageView;
@property (strong, nonatomic) IBOutlet UILabel *userLibraryBookTitle;
@property (strong, nonatomic) IBOutlet UILabel *userLibraryBookCategories;
@property (strong, nonatomic) IBOutlet UILabel *userLibraryBookId;

@end
