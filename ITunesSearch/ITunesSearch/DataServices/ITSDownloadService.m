//
//  ITSDownloadService.m
//  ITunesSearch
//
//  Created by Monojit Datta@Cognizant on 11/23/16.
//  Copyright © 2016 Monojit Datta. All rights reserved.
//

#import "ITSDownloadService.h"

@interface ITSDownloadService ()
{
    
@private
    
    NSString* _pDownloadURLString;
    
}

@end

@implementation ITSDownloadService

-(id) initWithDownloadURL:(NSString*) pDownloadURLString
{
    
    self = [super init];
    if (!self)
        return nil;
    
    _pDownloadURLString = [pDownloadURLString copy];
    [self prepareHttpSession];
    
    return self;
    
    
}

-(NSURL*) prepareURL
{
    
    NSURL* pURL = [[NSURL alloc] initWithString:_pDownloadURLString];
    return  pURL;
    
}

@end
