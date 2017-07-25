//
//  LibraryTableViewController.h
//  BookShare
//
//  Created by YILUN XU on 7/19/17.
//  Copyright © 2017 CarnegieMellonUniversity. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LibraryTableViewController : UITableViewController {
    NSMutableArray *title;
    NSMutableArray *categories;
    NSMutableArray *imageURL;
}
- (IBAction)refresh:(id)sender;

@end
