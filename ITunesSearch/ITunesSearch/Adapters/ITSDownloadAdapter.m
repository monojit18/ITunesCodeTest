//
//  ITSDownloadAdapter.m
//  ITunesSearch
//
//  Created by Monojit Datta@Cognizant on 11/23/16.
//  Copyright © 2016 Monojit Datta. All rights reserved.
//

#import "ITSDownloadAdapter.h"
#import "BaseHttpDataService.h"

@implementation ITSDownloadAdapter

-(void) downloadWithCallbackAsync:(AdapterCallback) pCallback
{
    
    
    NSAssert(pCallback != NULL, @"Provide an Adapter Callback");
    __weak typeof(self) pWeakSelf = self;
    
    [_pHttpService getAsyncWithCallback:^(BaseHttpDataService *pHttpService, id pResponse, NSError *pError)
     {
         
         NSData* pResponseData = (NSData*) pResponse;
         pCallback(pWeakSelf, pResponseData, pError);
         
     }];
    
}

@end
