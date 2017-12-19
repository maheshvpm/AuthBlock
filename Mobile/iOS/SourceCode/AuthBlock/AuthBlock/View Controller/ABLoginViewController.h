//
//  ABLoginViewController.h
//  AuthBlock
//
//  Created by Ramesh D on 12/19/17.
//  Copyright © 2017 Logu Subramaniyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JVFloatLabeledTextField.h"

@interface ABLoginViewController : UIViewController

@property ( strong, nonatomic ) IBOutlet JVFloatLabeledTextField *usernameTextField;

@property ( strong, nonatomic ) IBOutlet JVFloatLabeledTextField *passwordTextField;

- ( IBAction )loginButtonAction:( id )sender;

- ( IBAction )registerButtonAction:( id )sender;

@end
