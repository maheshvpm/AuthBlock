//
//  ABProductListViewController.m
//  AuthBlock
//
//  Created by Ramesh D on 12/19/17.
//  Copyright © 2017 Logu Subramaniyan. All rights reserved.
//

#import "ABProductListViewController.h"
#import "SWRevealViewController.h"
#import "ABProductListCell.h"
#import "ABProductDetailViewController.h"
#import "ABWebServiceManager.h"
#import "ABActivityIndicator.h"
#import "ABProduct.h"

@interface ABProductListViewController ()

@property ( nonatomic, strong )NSMutableArray *products;
@property ( nonatomic, strong )ABWebServiceManager *serviceManager;
@property ( nonatomic, strong )ABActivityIndicator *activityIndicator;

@end

@implementation ABProductListViewController

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

    [self getProducts];

    self.productListTableView.dataSource = self;
    self.productListTableView.delegate = self;
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

- ( void )encodeRestorableStateWithCoder:( NSCoder * )coder
{
    NSLog(@"%s", __PRETTY_FUNCTION__);

    [super encodeRestorableStateWithCoder:coder];
}


- ( void )decodeRestorableStateWithCoder:( NSCoder * )coder
{
    NSLog(@"%s", __PRETTY_FUNCTION__);

    [super decodeRestorableStateWithCoder:coder];
}


- ( void )applicationFinishedRestoringState
{
    NSLog(@"%s", __PRETTY_FUNCTION__);

    // Call whatever function you need to visually restore
    [self customSetup];
}

//MARK:- Tableview Datasource and Delegates
- ( NSInteger )numberOfSectionsInTableView:( UITableView * )tableView
{
    return 1;
}

- ( NSInteger )tableView:( UITableView * )tableView
   numberOfRowsInSection:( NSInteger )section
{
    return self.products.count;
}

- ( CGFloat )tableView:( UITableView * )tableView
heightForRowAtIndexPath:( NSIndexPath * )indexPath
{
    return self.view.frame.size.height * 0.2;
}

- ( UITableViewCell * )tableView:( UITableView * )tableView
           cellForRowAtIndexPath:( NSIndexPath * )indexPath
{
    static NSString *identifier = @"ABProductListCell";

    ABProductListCell *cell = (ABProductListCell *)[tableView dequeueReusableCellWithIdentifier:identifier];

    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:identifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }

    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];

    ABProduct *product = [[ABProduct alloc]init];
    product = self.products[indexPath.row];
    cell.productTitle.text = product.productName;
    cell.productDescription.text = product.productDescription;
    cell.productPrice.text = [ NSString stringWithFormat:@"%@",product.productPrice];

    return cell;
}

- ( void )    tableView:( UITableView * )tableView
didSelectRowAtIndexPath:( NSIndexPath * )indexPath
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];

    ABProductDetailViewController *detailVC = ( ABProductDetailViewController * )[storyboard instantiateViewControllerWithIdentifier:@"productDetailViewController"];

    detailVC.product = self.products[ indexPath.row ];
    [self.navigationController pushViewController:detailVC animated:YES];
}

- ( void )getProducts
{
    [self.activityIndicator showActivityIndicator];

    [self.serviceManager getProductsWithSccessResponse:^(NSMutableArray *products) {

        [self.activityIndicator stopActivityIndicator];
        self.products = products;

    } withFailureResponse:^(ABError *error) {
        [self.activityIndicator stopActivityIndicator];
    }];
}

@end
