//
//  BaseAdapter.h
//  ITunesSearch
//
//  Created by Monojit Datta@Cognizant on 11/22/16.
//  Copyright © 2016 Monojit Datta. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BaseAdapter;
@class BaseHttpDataService;
typedef void(^AdapterCallback)(BaseAdapter* pAdapter, id pResponse, NSError* pError);

@interface BaseAdapter : NSObject
{
    
    BaseHttpDataService* _pHttpService;
    
}

-(id) initWithHttpService:(BaseHttpDataService*) pHttpDataService;

-(void) suspend;

-(void) resume;

-(void) cancel;

@end
