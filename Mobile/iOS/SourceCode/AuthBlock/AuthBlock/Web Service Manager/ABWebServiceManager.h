//
//  ABWebServiceManager.h
//  AuthBlock
//
//  Created by Ramesh D on 16/12/17.
//  Copyright © 2017 Ramesh D. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ABError.h"

@interface ABWebServiceManager : NSObject

typedef void (^WebServiceFailureResponse)( ABError *error );
typedef void (^ProductListResponse)( NSMutableArray *products );

- ( void )getProducts:( NSString * )urlString
   withSccessResponse:( ProductListResponse )products
  withFailureResponse:( WebServiceFailureResponse )error;

@end
