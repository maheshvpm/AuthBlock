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
#import "ABTransactionCell.h"
#import "ABWebServiceManager.h"

@interface ABHistoryViewController ()<ABQRCodeReaderDelegate>

@property ( nonatomic, strong )NSMutableArray *transactions;
@property ( nonatomic, strong )ABWebServiceManager *serviceManager;

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

    self.serviceManager = [[ABWebServiceManager alloc]init];
    [self customSetup];

    [self navigateToScanQRCodeViewControlller];
    
    self.historyTableView.dataSource = self;
    self.historyTableView.delegate = self;
    
    [self getTransactions];
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

//MARK:- Tableview Datasource and Delegates
- ( NSInteger )numberOfSectionsInTableView:( UITableView * )tableView
{
    return 1;
}

- ( NSInteger )tableView:( UITableView * )tableView numberOfRowsInSection:( NSInteger )section
{
    return 1;
}

- ( CGFloat )tableView:( UITableView * )tableView heightForRowAtIndexPath:( NSIndexPath * )indexPath
{
    return self.view.frame.size.height * 0.2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- ( UITableViewCell * )tableView:( UITableView * )tableView
           cellForRowAtIndexPath:( NSIndexPath * )indexPath
{
    static NSString *identifier = @"ABTransactionCell";
    ABTransactionCell *cell = (ABTransactionCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:identifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    
    return cell;
}

- ( void )getTransactions
{
    
    [self.serviceManager getTransactionsWithSuccessResponse:^(NSMutableArray *transactions) {
        self.transactions = transactions;
        NSLog(@"bxhvhbvbb");
        [self.historyTableView reloadData];
        
    } withFailureResponse:^(ABError *error) {
        
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"Error"
                                     message:error.errorMessage
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        //Add Buttons
        UIAlertAction* noButton = [UIAlertAction
                                   actionWithTitle:@"Cancel"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
                                       //Handle no, thanks button
                                   }];
        
        //Add your buttons to alert controller
        [alert addAction:noButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    }];
}

#pragma mark - MFQRCodeReaderDelegate

/*!
 Notify QR code scan completion.
 
 @param result QR code result.
 */
- ( void )readerDidScanResult:( NSString * )result
{
    NSLog(@"Scan Result: %@",result);
    // Pop QR code reader view controller.
    [self.navigationController popViewControllerAnimated:YES];
}

@end
