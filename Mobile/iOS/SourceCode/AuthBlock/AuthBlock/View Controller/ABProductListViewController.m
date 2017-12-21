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
#import "UIImageView+AFNetworking.h"

@interface ABProductListViewController ()

@property ( nonatomic, strong )NSMutableArray *products;
@property ( nonatomic, strong )ABWebServiceManager *serviceManager;
@property ( nonatomic, strong )ABActivityIndicator *activityIndicator;
@property ( nonatomic, strong )UIRefreshControl *refreshController;

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
    self.refreshController = [[UIRefreshControl alloc] init];
    [self.refreshController addTarget:self action:@selector(handleRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.productListTableView addSubview:self.refreshController];
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

#pragma mark - Handle Refresh Method

-(void) handleRefresh: (id)sender
{
    [self getProducts];
    [self.refreshController endRefreshing];
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

- ( NSInteger )tableView:( UITableView * )tableView numberOfRowsInSection:( NSInteger )section
{
    if (self.products.count > 0) {
        return self.products.count;
        return 20;
    }
    return 1;
}

- ( CGFloat )tableView:( UITableView * )tableView heightForRowAtIndexPath:( NSIndexPath * )indexPath
{
    if ( self.products.count > 0 ) {
        return self.view.frame.size.height * 0.2;
    }
    return self.view.frame.size.height * 0.1;
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
    if ( self.products.count > 0 )
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
        [cell.productImageView setImageWithURL:[NSURL URLWithString:product.productImageURL]];
    
//        cell.productTitle.text = @"Kohinoor Diamond";
//        cell.productDescription.text = @"dest dest dest dest dest dest dest dest dest dest dest dest dest dest dest dest dest dest dest dest";
//        cell.productPrice.text = [ NSString stringWithFormat:@"₹ %d",1000];
//        [cell.productImageView setImageWithURL:[NSURL URLWithString:@"https://www.fastrack.in/datasource/products/table-top/fastrack-girls-stainless-steel-analog-white-watches-6168sm02(table-top).jpg"] placeholderImage:[UIImage imageNamed:@"Placeholder.png"]];

        return cell;
    }
    
    // Load information cell
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:identifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.text = @"No products available";
    cell.textLabel.textColor = [UIColor whiteColor];
    return cell;
}

- ( void )    tableView:( UITableView * )tableView
didSelectRowAtIndexPath:( NSIndexPath * )indexPath
{
    if (self.products.count > 0) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];

        ABProductDetailViewController *detailVC = ( ABProductDetailViewController * )[storyboard instantiateViewControllerWithIdentifier:@"productDetailViewController"];
        detailVC.product = self.products[ indexPath.row ];
        [self.navigationController pushViewController:detailVC animated:YES];
    }
}

- ( void )getProducts
{
    [self.activityIndicator showActivityIndicator];

    [self.serviceManager getProductsWithSccessResponse:^(NSMutableArray *products) {

        [self.activityIndicator stopActivityIndicator];
        self.products = products;
        [self.productListTableView reloadData];

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

@end
