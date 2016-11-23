//
//  IHttpDataService.h
//  ITunesSearch
//
//  Created by Monojit Datta@Cognizant on 11/22/16.
//  Copyright © 2016 Monojit Datta. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BaseHttpDataService;
typedef void(^HTTPCallback)(BaseHttpDataService* pHttpService, id pResponse, NSError* pError);

@interface BaseHttpDataService : NSObject
{
    
    NSURLSession* _pHttpSession;
    NSURLSessionDataTask* _pSessiondataTask;
    HTTPCallback _pHttpCallback;
    
}

-(NSURL*) prepareURL;

-(void) prepareHttpSession;

-(void) suspend;

-(void) resume;

-(void) cancel;

-(void) getAsyncWithCallback:(HTTPCallback) pCallback;

@end
