//
//  ABQRCodeReaderViewController.m
//  AuthBlock
//
//  Created by Ramesh D on 16/12/17.
//  Copyright © 2017 Ramesh D. All rights reserved.
//

#import "ABQRCodeReaderViewController.h"
#import "SWRevealViewController.h"

@interface ABQRCodeReaderViewController ()

//! The capture session used for scanning barcodes.
@property ( nonatomic, strong ) AVCaptureSession *captureSession;

//! The layer used to view the camera input. This layer is added to the previewView when scanning starts.
@property ( nonatomic, strong ) AVCaptureVideoPreviewLayer *videoPreviewLayer;

@end

@implementation ABQRCodeReaderViewController

/*!
 Called after the controller's view is loaded into memory.
 */
- ( void )viewDidLoad
{
    [super viewDidLoad];
    
    // Set scan QR code title.
    self.title = @"Scan QR Code";
}

/*!
 Notifies the view controller that its view is about to be added to a view hierarchy.
 This method is called before the receiver's view is about to be added to a view hierarchy
 and before any animations are configured for showing the view.
 @param animated If YES, the view is being added to the window using an animation.
 */
- ( void )viewWillAppear:( BOOL )animated
{
    [super viewWillAppear:animated];

    // Start reading QR code.
    [self startReading];
}

/*!
 Notifies the view controller that its view was added to a view hierarchy.
 @param animated If YES, the view was added to the window using an animation.
 */
- ( void )viewDidAppear:( BOOL )animated
{
    [super viewDidAppear:animated];
}

/*!
 Notifies the view controller that its view is about to be removed from a view hierarchy.
 This method is called in response to a view being removed from a view hierarchy. This method is
 called before the view is actually removed and before any animations are configured.
 @param animated If YES, the disappearance of the view is being animated.
 */
- ( void )viewWillDisappear:( BOOL )animated
{
    [super viewWillDisappear:animated];
    
    // Stop reading QR code.
    [self stopReading];
}

/*!
 Called to notify the view controller that its view is about to layout its subviews.
 */
- ( void )viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    _videoPreviewLayer.frame = self.view.layer.bounds;
}

/*!
 Notifies the container that the size of its view is about to change.
 @param size The new size for the container’s view.
 @param coordinator The transition coordinator object managing the size change. You can use
 this object to animate your changes or get information about the transition
 that is in progress.
 */
- ( void )viewWillTransitionToSize:( CGSize )size
         withTransitionCoordinator:( id< UIViewControllerTransitionCoordinator > )coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];

    __weak typeof( self ) weakSelf = self;

    // Use coordinator to get information of view size change completion.
    [coordinator animateAlongsideTransition:nil
                                 completion:^( id< UIViewControllerTransitionCoordinatorContext > context ) {

         [weakSelf.videoPreviewLayer setNeedsDisplay];

         // Check whether the video preview layer supports video orientation.
         if ( weakSelf.videoPreviewLayer.connection.isVideoOrientationSupported ) {

             // Set video preview layer orientation.
             UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
             weakSelf.videoPreviewLayer.connection.videoOrientation = [weakSelf videoOrientationFromInterfaceOrientation:orientation];
         }
     }];
}

/*!
 Notify the QR code scan completion.
 @param captureOutput The AVCaptureMetadataOutput instance that emitted the objects.
 @param metadataObjects An array of AVMetadataObject subclasses (see AVMetadataObject.h).
 @param connection The AVCaptureConnection through which the objects were emitted.
 */
- ( void ) captureOutput:( AVCaptureOutput * )captureOutput
didOutputMetadataObjects:( NSArray * )metadataObjects
          fromConnection:( AVCaptureConnection * )connection
{
    // Avoid retain cycles.
    __weak typeof( self ) weakSelf = self;
    
    // Check that view is ready and whether meta data objects array have data.
    if ( [metadataObjects count] > 0 ) {

        // Get scan result.
        __block AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];

        // Dispatch scan status and scan result.
        dispatch_async( dispatch_get_main_queue(), ^{

            [weakSelf stopReading];
            [weakSelf.delegate readerDidScanResult:[metadataObj stringValue]];
        } );
    }
}

#pragma mark - Managing the Orientation

/*!
 Get capture video interface orientation based on current device interface orientation.
 @param interfaceOrientation Current device interface orientation.
 @return Capture video interface orientation.
 */
- ( AVCaptureVideoOrientation )videoOrientationFromInterfaceOrientation:( UIInterfaceOrientation )interfaceOrientation
{
    switch ( interfaceOrientation ) {
        case UIInterfaceOrientationLandscapeLeft:
            return AVCaptureVideoOrientationLandscapeLeft;
        case UIInterfaceOrientationLandscapeRight:
            return AVCaptureVideoOrientationLandscapeRight;
        case UIInterfaceOrientationPortrait:
            return AVCaptureVideoOrientationPortrait;
        default:
            return AVCaptureVideoOrientationPortraitUpsideDown;
    }
}

#pragma mark - Private methods

/*!
 Starts scanning the codes.
 @return YES If started reading the codes, Otherwise NO.
 */
- ( BOOL )startReading
{
    NSError *error;

    // Configure the capture device input.
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice
                                                                        error:&error];

    // Configure the session.
    _captureSession = [[AVCaptureSession alloc] init];
    [_captureSession addInput:input];

    // Configure the capture device output.
    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    [_captureSession addOutput:captureMetadataOutput];

    // Create dispatch queue.
    dispatch_queue_t dispatchQueue = dispatch_queue_create( "scanQueue", NULL );

    // Set capture metadata output delegate and queue.
    [captureMetadataOutput setMetadataObjectsDelegate:self
                                                queue:dispatchQueue];

    // Set capture metadata output object types.
    [captureMetadataOutput setMetadataObjectTypes:@[ AVMetadataObjectTypeQRCode, AVMetadataObjectTypeUPCECode,
                                                     AVMetadataObjectTypePDF417Code, AVMetadataObjectTypeCode39Code,
                                                     AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeAztecCode,
                                                     AVMetadataObjectTypeInterleaved2of5Code, AVMetadataObjectTypeITF14Code,
                                                     AVMetadataObjectTypeCode128Code, AVMetadataObjectTypeCode93Code,
                                                     AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeEAN13Code,
                                                     AVMetadataObjectTypeCode39Mod43Code, AVMetadataObjectTypeDataMatrixCode ]];

    // Configure the capture video preview layer.
    _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];

    // Set video gravity to video preview layer.
    [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];

    // Update video preview layer frame.
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    _videoPreviewLayer.connection.videoOrientation = [self videoOrientationFromInterfaceOrientation:orientation];
    [_videoPreviewLayer setFrame:self.view.layer.bounds];

    // Add video preview layer to view controller layer.
    [self.view.layer addSublayer:_videoPreviewLayer];

    // Configure the session.
    [_captureSession startRunning];

    return YES;
}

/*!
 Stops scanning the codes.
 */
- ( void )stopReading
{
    // Stop scanning the session.
    [_captureSession stopRunning];
    _captureSession = nil;
}

@end
