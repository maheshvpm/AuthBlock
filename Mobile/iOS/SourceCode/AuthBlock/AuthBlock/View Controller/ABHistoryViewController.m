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
#import "ABHistory.h"
#import "ABActivityIndicator.h"

@interface ABHistoryViewController ()<ABQRCodeReaderDelegate>

@property ( nonatomic, strong )ABWebServiceManager *serviceManager;
@property ( nonatomic, strong )ABActivityIndicator *activityIndicator;

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
    self.activityIndicator = [[ABActivityIndicator alloc]init];
    [self customSetup];

    if ( _productID ) {
        [self getTransactionsWithProductID:_productID];
    }
    else {
         [self navigateToScanQRCodeViewControlller];
    }

    self.historyTableView.dataSource = self;
    self.historyTableView.delegate = self;
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
    return self.transactions.count;
}

- ( CGFloat )tableView:( UITableView * )tableView heightForRowAtIndexPath:( NSIndexPath * )indexPath
{
    return 250;
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

    ABHistory *history = self.transactions[indexPath.row];
    cell.txID.text = history.txID;
    cell.txType.text = history.txType;
    cell.txInvoked.text = history.txInvoked;
    cell.txOldData.text = history.txOldData;
    cell.txNewData.text = history.txNewData;

    //2017-12-25 10:06:04.566+00:00
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSSZ"];
    NSDate *newDate = [dateFormatter dateFromString:history.txDate];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    cell.txDate.text = [dateFormatter stringFromDate:newDate];
    cell.currentOwner.text = history.currentOwner;

    return cell;
}

- ( void )getTransactionsWithProductID:( NSString * )productID
{
    [self.activityIndicator showActivityIndicator];

    [self.serviceManager getTransactions:productID
                     withSuccessResponse:^(NSMutableArray *transactions) {
                         [self.activityIndicator stopActivityIndicator];
        self.transactions = transactions;
        [self.historyTableView reloadData];

    } withFailureResponse:^(ABError *error) {
        [self.activityIndicator stopActivityIndicator];
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
    // Pop QR code reader view controller.
    [self.navigationController popViewControllerAnimated:YES];

    self.title = result;
    [self getTransactionsWithProductID:result];
}

@end
