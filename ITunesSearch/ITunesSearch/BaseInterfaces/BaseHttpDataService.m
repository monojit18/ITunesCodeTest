//
//  IHttpDataService.m
//  ITunesSearch
//
//  Created by Monojit Datta@Cognizant on 11/22/16.
//  Copyright © 2016 Monojit Datta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseHttpDataService.h"

@implementation BaseHttpDataService

-(NSURL*) prepareURL
{
    
    return nil;
    
}

-(void) prepareHttpSession
{
    
    NSURLSessionConfiguration* pSessionconfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    _pHttpSession = [NSURLSession sessionWithConfiguration:pSessionconfiguration];
    __weak typeof(self) pWeakSelf = self;
    
    _pSessiondataTask = [_pHttpSession dataTaskWithURL:[self prepareURL] completionHandler:^(NSData * _Nullable pResponseData,
                                                                                             NSURLResponse * _Nullable pResponse,
                                                                                             NSError * _Nullable pError)
     {
         
         [[NSOperationQueue mainQueue] addOperationWithBlock:
          ^{
              
              if (_pHttpCallback)
                  _pHttpCallback(pWeakSelf, pResponseData, pError);
              
          }];
         
     }];
    
}

-(void) suspend
{
    
    if (!_pSessiondataTask)
        return;
    
    [_pSessiondataTask suspend];
    
    
}

-(void) resume
{
    
    if (!_pSessiondataTask)
        return;
    
    [_pSessiondataTask resume];
    
    
}

-(void) cancel
{
    
    if (!_pSessiondataTask)
        return;
    
    [_pSessiondataTask cancel];
    
    
}

-(void) getAsyncWithCallback:(HTTPCallback) pCallback
{
    
    NSAssert(pCallback != NULL, @"Provide an Http Callback");
    _pHttpCallback = pCallback;
    [_pSessiondataTask resume];
    
}

@end
