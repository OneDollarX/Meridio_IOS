//
//  PopOverViewController.h
//  PopOverMenu
//
//  Created by YILUN XU on 7/31/17.
//  Copyright © 2017 CarnegieMellonUniversity. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopOverViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *myTableView;


/* Whoever uses this view controller, will have to register as a delegate to communicate back to parent controller */
//@property (weak, nonatomic) id delegate;

@end
