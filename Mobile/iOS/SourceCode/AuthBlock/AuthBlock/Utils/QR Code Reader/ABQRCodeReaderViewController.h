//
//  ABQRCodeReaderViewController.h
//  AuthBlock
//
//  Created by Ramesh D on 16/12/17.
//  Copyright © 2017 Ramesh D. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

//! Protocol for notifying scan QR code operations.
@protocol ABQRCodeReaderDelegate < NSObject >

/*!
 Notify QR code scan completion.
 @param result QR code result.
 */
- ( void )readerDidScanResult:( NSString * )result;

@end

@interface ABQRCodeReaderViewController : UIViewController < AVCaptureMetadataOutputObjectsDelegate >

//! Delegate conforming to ABQRCodeReaderDelegate protocol.
@property ( nonatomic, weak ) id < ABQRCodeReaderDelegate > delegate;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *menuButton;

@end
