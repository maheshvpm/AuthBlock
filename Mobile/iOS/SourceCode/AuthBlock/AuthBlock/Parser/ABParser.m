//
//  ABParser.m
//  AuthBlock
//
//  Created by Logu Subramaniyan on 16/12/17.
//  Copyright © 2017 Logu Subramaniyan. All rights reserved.
//

#import "ABParser.h"
#import "ABProduct.h"

@implementation ABParser

- ( NSMutableArray * )parseProductList:( NSDictionary * )response
{
    NSMutableArray *products = [[NSMutableArray alloc]init];
    
    if ( response )
    {
        for (NSDictionary *dict in response)
        {
            ABProduct *product = [[ABProduct alloc]init];
            product.productName = dict[@"productName"];
            product.productDescription = dict[@"productDesc"];
            product.productPrice = dict[@"productPrice"];
            product.productImageURL = dict[@"productImageUrl"];
            product.produdtId = dict[@"produdtId"];
            product.productSKUID = dict[@"productSKUID"];
            product.productHolder = dict[@"productHolder"];
            product.productPriceHistory = dict[@"productPriceHistory"];
            product.productPreviousOwner = dict[@"productPreviousOwner"];
            [products addObject:product];
        }
    }
    return products;
}

- ( NSMutableArray * )parseTransactionHistory:( NSDictionary * )response
{
    NSMutableArray *historyList = [[NSMutableArray alloc]init];
    
    NSArray *timestamps = response[@"timeStamp"];

    if ( response )
    {
        for ( int i =0; i <  [timestamps count]; i++ )
        {
            ABHistory *history = [[ABHistory alloc]init];
            history.txID = response[@"transactionID"][i];
            history.txType = response[@"transactionType"][i];
            history.txInvoked = response[@"transactionType"][i];
            history.txOldData = response[@"transactionOldData"][i];
            history.txNewData = response[@"transactionNewData"][i];
            history.txDate = response[@"timeStamp"][i];
            history.currentOwner = response[@"ownerHistory"][i];
            [historyList addObject:history];
        }
    }
    return historyList;
}

- ( ABUser * )parseSellerInfo:( NSDictionary * )response
{
    ABUser *user = [[ABUser alloc]init];
    if ( response )
    {
        user.email = response[@"email"];
        user.firstname = response[@"firstName"];
        user.lastname = response[@"lastname"];
        user.role = response[@"role"];
        user.userRating = response[@"user_rating"];
        user.userId = response[@"userId"];
    }
    return user;
}
@end
