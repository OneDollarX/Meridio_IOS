//
//  LibraryTableViewCell.h
//  BookShare
//
//  Created by YILUN XU on 7/19/17.
//  Copyright © 2017 CarnegieMellonUniversity. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LibraryTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *bookLibraryImageView;
@property (strong, nonatomic) IBOutlet UILabel *bookLibraryTitle;
@property (strong, nonatomic) IBOutlet UILabel *bookLibraryCategories;

@end
