//
//  TradeBookDetailsViewController.h
//  BookShare
//
//  Created by YILUN XU on 7/26/17.
//  Copyright © 2017 CarnegieMellonUniversity. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TradeBookDetailsViewController : UIViewController

@property (strong, nonatomic) NSString *tradeBookTitle;
@property (strong, nonatomic) NSString *tradeBookGenre;
@property (strong, nonatomic) NSString *tradeBookImageUrl;
@property (strong, nonatomic) NSString *tradeBookDescription;
@property (strong, nonatomic) NSString *tradeBookId;
@property (strong, nonatomic) NSString *tradeId;


@property (strong, nonatomic) IBOutlet UIImageView *tradeBookImage;
@property (strong, nonatomic) IBOutlet UILabel *tradeBookTitleLabel;

@property (strong, nonatomic) IBOutlet UILabel *tradeBookGenreLabel;
@property (strong, nonatomic) IBOutlet UITextView *tradeBookDescriptionsTextView;

- (IBAction)acceptTradeReqeust:(id)sender;


@end
