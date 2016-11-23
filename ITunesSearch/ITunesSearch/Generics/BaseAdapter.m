//
//  BaseAdapter.m
//  ITunesSearch
//
//  Created by Monojit Datta@Cognizant on 11/22/16.
//  Copyright © 2016 Monojit Datta. All rights reserved.
//

#import "BaseAdapter.h"
#import "BaseHttpDataService.h"

@implementation BaseAdapter

-(id) initWithHttpService:(BaseHttpDataService*) pHttpService
{
    
    self = [super init];
    if (!self)
        return nil;
    
    _pHttpService = pHttpService;
    return self;
    
}


-(void) suspend
{
    
    if (!_pHttpService)
        return;
    
    [_pHttpService suspend];
    
    
}

-(void) resume
{
    
    if (!_pHttpService)
        return;
    
    [_pHttpService resume];
    
    
}

-(void) cancel
{
    
    if (!_pHttpService)
        return;
    
    [_pHttpService cancel];
    
    
}


@end
