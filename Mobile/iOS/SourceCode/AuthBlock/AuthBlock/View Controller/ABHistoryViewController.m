//
//  ABHistoryViewController.m
//  AuthBlock
//
//  Created by Ramesh D on 12/20/17.
//  Copyright © 2017 Logu Subramaniyan. All rights reserved.
//

#import "ABHistoryViewController.h"
#import "SWRevealViewController.h"
#import "ABQRCodeReaderViewController.h"

@interface ABHistoryViewController ()<ABQRCodeReaderDelegate>

@end

@implementation ABHistoryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"Bg.png"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    
    [self customSetup];
    
    [self navigateToScanQRCodeViewControlller];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)customSetup
{
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.menuButton setTarget: revealViewController];
        [self.menuButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:revealViewController.panGestureRecognizer];
        [self.view addGestureRecognizer:revealViewController.tapGestureRecognizer];
    }
}

#pragma mark state preservation / restoration

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    [super encodeRestorableStateWithCoder:coder];
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    [super decodeRestorableStateWithCoder:coder];
}

- (void)applicationFinishedRestoringState
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    // Call whatever function you need to visually restore
    [self customSetup];
}

- ( void )navigateToScanQRCodeViewControlller
{
    ABQRCodeReaderViewController *qrCodeReaderViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"QRCodeReaderViewController"];
    qrCodeReaderViewController.delegate = self;
    [self.navigationController pushViewController:qrCodeReaderViewController animated:YES];
}

#pragma mark - MFQRCodeReaderDelegate

/*!
 Notify QR code scan completion.
 
 @param result QR code result.
 */
- ( void )readerDidScanResult:( NSString * )result
{
    
    // Pop QR code reader view controller.
    [self.navigationController popViewControllerAnimated:YES];
}

@end
