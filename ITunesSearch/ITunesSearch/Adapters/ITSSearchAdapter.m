//
//  ITSSearchAdapter.m
//  ITunesSearch
//
//  Created by Monojit Datta@Cognizant on 11/22/16.
//  Copyright © 2016 Monojit Datta. All rights reserved.
//

#import "ITSSearchAdapter.h"
#import "BaseHttpDataService.h"

@implementation ITSSearchAdapter

-(void) searchWithCallbackAsync:(AdapterCallback) pCallback
{
    
    NSAssert(pCallback != NULL, @"Provide an Adapter Callback");
    __weak typeof(self) pWeakSelf = self;
    
    [_pHttpService getAsyncWithCallback:^(BaseHttpDataService *pHttpService, id pResponse, NSError *pError)
    {
        
        NSData* pResponseData = (NSData*) pResponse;
        if (!pResponseData)
        {
            
            pCallback(pWeakSelf, nil, pError);
            return;

        }
        
        __strong typeof(pWeakSelf) pStrongSelf = pWeakSelf;
        NSOperationQueue* pQueue = [[NSOperationQueue alloc] init];
        [pQueue addOperationWithBlock:
         ^{
             
             NSDictionary* pResponseDictionary = [NSJSONSerialization JSONObjectWithData:pResponseData
                                                                                 options:NSJSONReadingAllowFragments
                                                                                   error:NULL];
             
             [[NSOperationQueue mainQueue] addOperationWithBlock:
              ^{
                  
                  pCallback(pStrongSelf, pResponseDictionary, pError);
                  
              }];

        }];
        
    }];
    
}

@end
