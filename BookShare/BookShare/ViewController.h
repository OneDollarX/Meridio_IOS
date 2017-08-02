//
//  ViewController.h
//  Setting
//
//  Created by YILUN XU on 7/18/17.
//  Copyright © 2017 CarnegieMellonUniversity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Accounts/Accounts.h>
#import <Social/Social.h>

@interface ViewController : UIViewController {
    SLComposeViewController *slComposer;
}

@property (strong, nonatomic) IBOutlet UIButton *aroundMeButton;

//passing varibales
@property (nonatomic) NSString *username;
@property (nonatomic) NSString *emailAddress;
@property (nonatomic) NSString *userId;





@end

