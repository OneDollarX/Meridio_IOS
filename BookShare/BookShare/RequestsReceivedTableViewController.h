//
//  RequestsReceivedTableViewController.h
//  BookShare
//
//  Created by YILUN XU on 7/25/17.
//  Copyright © 2017 CarnegieMellonUniversity. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RequestsReceivedTableViewController : UITableViewController
{
    NSMutableArray *requestorWantsBook;
    NSMutableArray *tradeId;
    NSMutableArray *acceptorWantsBook;
    NSMutableArray *usernameReceived;
    NSMutableArray *statusReceived;
    NSMutableArray *fromEmail;
    
}


@end
