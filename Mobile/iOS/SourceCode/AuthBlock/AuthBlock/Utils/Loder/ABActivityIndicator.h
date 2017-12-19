//
//  ABActivityIndicator.h
//  AuthBlock
//
//  Created by Ramesh D on 16/12/17.
//  Copyright © 2017 Ramesh D. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DGActivityIndicatorView.h"
#import "AppDelegate.h"

@interface ABActivityIndicator : NSObject

@property ( nonatomic, strong ) DGActivityIndicatorView *activityIndicatorView;
@property ( nonatomic, strong ) UIView *indicator;

- ( void )showActivityIndicator;
- ( void )stopActivityIndicator;

@end
