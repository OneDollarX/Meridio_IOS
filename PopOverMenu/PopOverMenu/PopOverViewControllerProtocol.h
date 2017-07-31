//
//  PopOverViewControllerProtocol.h
//  PopOverMenu
//
//  Created by YILUN XU on 7/31/17.
//  Copyright © 2017 CarnegieMellonUniversity. All rights reserved.
//

#ifndef PopOverViewControllerProtocol_h
#define PopOverViewControllerProtocol_h

@protocol PopOverViewControllerDelegate <NSObject>

- (void) performAction:(NSString *)value andChange:(NSString *)actionType;

@end


#endif /* PopOverViewControllerProtocol_h */
