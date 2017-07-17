//
//  ScanViewController.h
//  BarCodeScanner
//
//  Created by YILUN XU on 7/9/17.
//  Copyright © 2017 CarnegieMellonUniversity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ScanViewController : UIViewController {
    NSString *barCodeGenerated;
}

@property (weak, nonatomic) IBOutlet UIView *cameraPreviewView;
@property (weak, nonatomic) IBOutlet UILabel *scannedBarcode;
@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *captureLayer;
@property (strong, nonatomic) IBOutlet UIButton *goButton;


- (IBAction)doneBtn:(id)sender;
- (IBAction)rescanBtn:(id)sender;


@end
