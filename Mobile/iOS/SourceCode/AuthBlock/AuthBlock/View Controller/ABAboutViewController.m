//
//  ABAboutViewController.m
//  AuthBlock
//
//  Created by Ramesh D on 12/21/17.
//  Copyright © 2017 Logu Subramaniyan. All rights reserved.
//

#import "ABAboutViewController.h"
#import "SWRevealViewController.h"
#import <MessageUI/MessageUI.h>

@interface ABAboutViewController () < MFMailComposeViewControllerDelegate >

@end

@implementation ABAboutViewController

- ( void )viewDidLoad
{
    [super viewDidLoad];
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"Bg.png"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    
    [self customSetup];
}

- ( void )didReceiveMemoryWarning
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

- (IBAction)contactUSButtonAction:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://7871564595"]];
}

- (IBAction)emailButtonAction:(id)sender
{
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *composeViewController = [[MFMailComposeViewController alloc] initWithNibName:nil bundle:nil];
        [composeViewController setMailComposeDelegate:self];
        [composeViewController setToRecipients:@[@"guru.ramachandran@aspiresys.com",@"mani.palanivel@aspiresys.com",@"yogaraj.rajendran@aspiresys.com",@"mahesh.muthusamy@aspiresys.com",@"ramesh.duraisamy@aspiresys.com",@"kovarthanan.murugan@aspiresys.com"]];
        [composeViewController setSubject:@"Feedback"];
        [self presentViewController:composeViewController animated:YES completion:nil];
    }
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    //Add an alert in case of failure
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
