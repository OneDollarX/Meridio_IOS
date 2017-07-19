//
//  ScanViewController.h
//  BookShare
//
//  Created by YILUN XU on 7/19/17.
//  Copyright © 2017 CarnegieMellonUniversity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ScanViewController : UIViewController {
    NSString *barCodeGenerated;
}

@property (strong, nonatomic) IBOutlet UIView *cameraPreviewView;

@property (strong, nonatomic) IBOutlet UILabel *scannedBarcode;
@property (strong, nonatomic) IBOutlet UIButton *goButton;

@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *captureLayer;

- (IBAction)rescanButton:(id)sender;
- (IBAction)goPressed:(id)sender;




@end
