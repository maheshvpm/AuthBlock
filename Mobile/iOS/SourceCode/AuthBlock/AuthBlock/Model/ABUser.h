//
//  ABUser.h
//  AuthBlock
//
//  Created by Ramesh D on 16/12/17.
//  Copyright © 2017 Ramesh D. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ABUser : NSObject

@property ( nonatomic, strong ) NSString *privateKey;
@property ( nonatomic, strong ) NSString *publicKey;

@end
