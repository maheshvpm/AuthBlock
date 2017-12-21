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

@end
