//
//  RequestsReceivedTableViewCell.h
//  BookShare
//
//  Created by YILUN XU on 7/25/17.
//  Copyright © 2017 CarnegieMellonUniversity. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RequestsReceivedTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *requestorWantsBook;
@property (strong, nonatomic) IBOutlet UILabel *acceptorWantsBook;

@property (strong, nonatomic) IBOutlet UILabel *usernameReceived;
@property (strong, nonatomic) IBOutlet UILabel *statusReceived;

@property (strong, nonatomic) IBOutlet UIImageView *statusImage;

@end
