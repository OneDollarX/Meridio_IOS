//
//  UserLibraryTableViewController.h
//  BookShare
//
//  Created by YILUN XU on 7/26/17.
//  Copyright © 2017 CarnegieMellonUniversity. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserLibraryTableViewController : UITableViewController {
    
    
    NSMutableArray *title;
    NSMutableArray *categories;
    NSMutableArray *imageURL;
    NSMutableArray *bookId;
    NSMutableArray *bookDescription;
}

@property (strong, nonatomic) NSString *receivedUserId;
@property (strong, nonatomic) NSString *receivedTradeId;

@end
