//
//  ViewController.h
//  Setting
//
//  Created by YILUN XU on 7/18/17.
//  Copyright © 2017 CarnegieMellonUniversity. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController



@property (nonatomic) NSString *username;

@property (nonatomic) NSString *emailAddress;




@property (strong, nonatomic) IBOutlet UIBarButtonItem *settingBtn;
- (IBAction)SettingClicked:(id)sender;


@end

