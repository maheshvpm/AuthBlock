//
//  ABMenuTableViewController.m
//  AuthBlock
//
//  Created by Ramesh D on 12/19/17.
//  Copyright © 2017 Logu Subramaniyan. All rights reserved.
//

#import "ABMenuTableViewController.h"
#import "ABMenuTableViewCell.h"

@interface ABMenuTableViewController ()

@property ( nonatomic, strong ) NSMutableArray *menuArray;

@end

@implementation ABMenuTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

     _menuArray = [[NSMutableArray alloc] initWithObjects:@"Admin",@"Home",@"Scan QR Code",@"About",@"Logout", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) prepareForSegue: (UIStoryboardSegue *) segue sender: (id) sender
{
    if ( [segue.identifier isEqualToString:@"Logout"]){
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.menuArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";

    switch ( indexPath.row )
    {

        case 0:
            CellIdentifier = @"Profile";
            break;

        case 1:
            CellIdentifier = @"Home";
            break;

        case 2:
            CellIdentifier = @"ScanQRCode";
            break;

        case 3:
            CellIdentifier = @"About";
            break;

        case 4:
            CellIdentifier = @"Logout";
            break;

    }

    ABMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier forIndexPath: indexPath];
    cell.menuTitle.text = [self.menuArray objectAtIndex:indexPath.row];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 4) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark state preservation / restoration
- (void)encodeRestorableStateWithCoder:(NSCoder *)coder {
    NSLog(@"%s", __PRETTY_FUNCTION__);

    // TODO save what you need here

    [super encodeRestorableStateWithCoder:coder];
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder {
    NSLog(@"%s", __PRETTY_FUNCTION__);

    // TODO restore what you need here

    [super decodeRestorableStateWithCoder:coder];
}

- (void)applicationFinishedRestoringState {
    NSLog(@"%s", __PRETTY_FUNCTION__);

    // TODO call whatever function you need to visually restore
}

@end
