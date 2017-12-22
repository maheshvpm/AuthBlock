//
//  ABProductDetailViewController.m
//  AuthBlock
//
//  Created by Mahesh Muthusamy on 19/12/17.
//  Copyright © 2017 Logu Subramaniyan. All rights reserved.
//

#import "ABProductDetailViewController.h"
#import "ABProductDetailImageCell.h"
#import "ABProductDescriptionCell.h"
#import "ABSellerInfoCell.h"
#import "ABCertificationCell.h"
#import "ABWebServiceManager.h"
#import "ABActivityIndicator.h"
#import "ABHistoryViewController.h"

typedef NS_ENUM( NSInteger, ProductDetailSections ) {
    ProductImage,
    ProductDescription,
    SellerInfo,
    Certification
};

@interface ABProductDetailViewController () < ABProductVerifyDelegate >

@property ( nonatomic, strong )ABWebServiceManager *serviceManager;
@property ( nonatomic, strong )ABActivityIndicator *activityIndicator;

@end

@implementation ABProductDetailViewController

- ( void )viewDidLoad
{
    [super viewDidLoad];

    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"Bg.png"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    
    self.serviceManager = [[ABWebServiceManager alloc]init];
    self.activityIndicator = [[ABActivityIndicator alloc]init];

    self.productDetailTableView.dataSource = self;
    self.productDetailTableView.delegate = self;
    self.productDetailTableView.backgroundColor = [UIColor clearColor];
    
    // Get the seller id
    NSArray *array = [self.product.productHolder componentsSeparatedByString:@"#"];
    if (array.count > 1) {
        [self getSellerInformation:[array objectAtIndex:1]];
    }
}

- ( void )didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- ( IBAction )shareAction:( id )sender
{
    if ( self.product != nil )
    {
        NSString *title = self.product.productName;
        NSURL *imageURL = [NSURL URLWithString:self.product.productImageURL];
        NSArray *objectsToShare = @[title, imageURL];
    
        UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
        activityVC.popoverPresentationController.sourceView = self.view;
        [self presentViewController:activityVC animated:YES completion:nil];
    }
}

//MARK:- Tableview Datasource and Delegates
- ( NSInteger )numberOfSectionsInTableView:( UITableView * )tableView
{
    return 4;
}

- ( NSInteger )tableView:( UITableView * )tableView
   numberOfRowsInSection:( NSInteger )section
{
    return 1;
}

- ( CGFloat )tableView:( UITableView * )tableView
heightForRowAtIndexPath:( NSIndexPath * )indexPath
{
    switch ( indexPath.section )
    {
        case ProductImage:
            return self.view.frame.size.height * 0.4;
        case ProductDescription:
            return self.view.frame.size.height * 0.15;
        case SellerInfo:
            return self.view.frame.size.height * 0.15;
        case Certification:
            return self.view.frame.size.height * 0.1;
        default:
            return 0;
    }
}

- ( CGFloat )tableView:( UITableView * )tableView
heightForHeaderInSection:( NSInteger )section
{
    switch ( section )
    {
        case SellerInfo:
            return 50;
        default:
            return 0.1;
    }
}

- ( UIView * )tableView:( UITableView * )tableView
 viewForHeaderInSection:( NSInteger )section
{
    switch (section)
    {
        case SellerInfo:
        {
            UIView *headerView =  [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 50)];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, tableView.frame.size.width, 50)];
            [label setFont:[UIFont boldSystemFontOfSize:18]];
            NSString *string =@"SELLER INFO";
            [label setText:string];
            [label setTextColor:[UIColor whiteColor]];
            [headerView addSubview:label];
            return headerView;
        }
        default:
            return nil;
    }
}

- ( CGFloat )tableView:( UITableView * )tableView
heightForFooterInSection:( NSInteger )section
{
    return 0.1;
}

- ( UITableViewCell * )tableView:( UITableView * )tableView
           cellForRowAtIndexPath:( NSIndexPath * )indexPath
{
    switch ( indexPath.section )
    {
        case ProductImage:
        {
            static NSString *identifier = @"ABProductDetailImageCell";
            ABProductDetailImageCell *cell = (ABProductDetailImageCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil) {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:identifier owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }
            cell.backgroundColor = [UIColor clearColor];
            cell.contentView.backgroundColor = [UIColor clearColor];
            [cell.productImageView setImageWithURL:[NSURL URLWithString:self.product.productImageURL] placeholderImage:[UIImage imageNamed:@"Placeholder.png"]];
            return cell;
        }
        case ProductDescription:
        {
            static NSString *identifier = @"ABProductDescriptionCell";
            ABProductDescriptionCell *cell = (ABProductDescriptionCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil) {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:identifier owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }
            cell.delegate = self;
            cell.productTitle.text = self.product.productName;
            cell.productPrice.text = [NSString stringWithFormat:@"₹ %@",self.product.productPrice];
            cell.backgroundColor = [UIColor clearColor];
            cell.contentView.backgroundColor = [UIColor clearColor];
            return cell;
        }
        case SellerInfo:
        {
            static NSString *identifier = @"ABSellerInfoCell";
            ABSellerInfoCell *cell = (ABSellerInfoCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil) {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:identifier owner:self options:nil];
                cell = [nib objectAtIndex:0];
                cell.backgroundColor = [UIColor clearColor];
                cell.contentView.backgroundColor = [UIColor clearColor];
            }
            cell.sellerName.text = [NSString stringWithFormat:@"%@ %@",self.sellerInfo.firstname,self.sellerInfo.lastname];
            cell.sellerRating.text =[NSString stringWithFormat:@"%@",self.sellerInfo.userRating];
            return cell;
        }
        case Certification:
        {
            static NSString *identifier = @"ABCertificationCell";
            ABCertificationCell *cell = (ABCertificationCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil) {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:identifier owner:self options:nil];
                cell = [nib objectAtIndex:0];
                cell.backgroundColor = [UIColor clearColor];
                cell.contentView.backgroundColor = [UIColor clearColor];
            }
            return cell;
        }
        default:
        {
            UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
            cell.backgroundColor = [UIColor clearColor];
            cell.contentView.backgroundColor = [UIColor clearColor];
            return cell;
        }
    }
}

-( void )verifyProduct:( NSString * )productId
{
    NSLog(@"Verify product for product id:%@", productId);
    ABHistoryViewController *historyViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ABHistoryViewController"];
    [self.navigationController pushViewController:historyViewController animated:YES];
}

-( void )getSellerInformation:(NSString *)userId {
    
    [self.serviceManager getSellerInfo:userId WithSuccessResponse:^(ABUser *user)  {
        self.sellerInfo = user;
        [self.productDetailTableView reloadData];
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

@end
