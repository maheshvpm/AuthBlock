//
//  ABLoginViewController.m
//  AuthBlock
//
//  Created by Ramesh D on 12/19/17.
//  Copyright © 2017 Logu Subramaniyan. All rights reserved.
//

#import "ABLoginViewController.h"
#import "ABWebServiceManager.h"
#import "ABActivityIndicator.h"

@interface ABLoginViewController ()

@property ( nonatomic, strong )ABWebServiceManager *serviceManager;
@property ( nonatomic, strong )ABActivityIndicator *activityIndicator;

@end

@implementation ABLoginViewController

- ( void )viewDidLoad
{
    [super viewDidLoad];

    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"Bg.png"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    self.view.backgroundColor = [UIColor colorWithPatternImage:image];

    NSAttributedString *str = [[NSAttributedString alloc] initWithString:self.usernameTextField.placeholder attributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] }];

    self.usernameTextField.attributedPlaceholder = str;

    NSAttributedString *str1 = [[NSAttributedString alloc] initWithString:self.passwordTextField.placeholder attributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] }];

    self.passwordTextField.attributedPlaceholder = str1;

    self.activityIndicator = [[ABActivityIndicator alloc] init];
    self.serviceManager = [[ABWebServiceManager alloc]init];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];

    [self.view addGestureRecognizer:tap];
}

- ( BOOL ) validateTextFields
{
    if ( self.usernameTextField.text.length == 0 ) {
        [self showAlertWithMessage:@"Please enter your user name."];
        return NO;
    }

    if ( self.passwordTextField.text.length == 0  ) {
        [self showAlertWithMessage:@"Please enter your password."];
        return NO;
    }

    return YES;
}

- ( void ) showAlertWithMessage : ( NSString* )message {

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Message" message:message preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:ok];

    [self presentViewController:alertController animated:YES completion:nil];
    
}

- ( void )didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- ( IBAction )loginButtonAction:( id )sender
{
    if ( ![self validateTextFields] ) {
        return;
    }

    [self performSegueWithIdentifier:@"LoginViewController" sender:self];
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField;
{
    [textField resignFirstResponder];
    return YES;
}

-(void)dismissKeyboard
{
    [self.usernameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}

@end
