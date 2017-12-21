//
//  ABAboutViewController.h
//  AuthBlock
//
//  Created by Ramesh D on 12/21/17.
//  Copyright © 2017 Logu Subramaniyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ABAboutViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *menuButton;

- ( IBAction )contactUSButtonAction:( id )sender;
- ( IBAction )emailButtonAction:( id )sender;

@end
