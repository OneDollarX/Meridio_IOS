//
//  BooksAroundMeTableViewController.h
//  BookShare
//
//  Created by Dhruv Prakash on 26/07/17.
//  Copyright © 2017 CarnegieMellonUniversity. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BooksAroundMeTableViewController : UITableViewController {
    NSMutableArray *title;
    NSMutableArray *imageURL;
    NSMutableArray *bookId;
    NSMutableArray *aroundMeUserId;
    NSMutableArray *aroundMeBookIsbn;
    
    
    

}


@property (strong, nonatomic) NSString *passingLat;
@property (strong, nonatomic) NSString *passingLong;

@end
