//
//  ABError.h
//  AuthBlock
//
//  Created by Ramesh D on 16/12/17.
//  Copyright © 2017 Ramesh D. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ABError : NSObject

@property ( nonatomic, strong ) NSString *errorMessage;
@property ( nonatomic, assign ) NSInteger errorCode;

@end
