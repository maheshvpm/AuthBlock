//
//  ABLoginViewController.m
//  AuthBlock
//
//  Created by Ramesh D on 12/19/17.
//  Copyright © 2017 Logu Subramaniyan. All rights reserved.
//

#import "ABLoginViewController.h"

@interface ABLoginViewController ()

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
}

- ( void )didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- ( IBAction )loginButtonAction:( id )sender
{
    [self performSegueWithIdentifier:@"LoginViewController" sender:self];
}

- ( IBAction )registerButtonAction:( id )sender
{
    
}

@end
