//
//  ITSHttpService.m
//  ITunesSearch
//
//  Created by Monojit Datta on 22/11/16.
//  Copyright © 2016 Monojit Datta. All rights reserved.
//

#import "ITSSearchService.h"
#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>

const NSString* const kBaseURLString = @"http://itunes.apple.com/search?term=";

@interface ITSSearchService ()
{
    
@private
    
    NSString* _pURLString;
    NSString* _pSearchTermString;
   
}

@end

@implementation ITSSearchService

#pragma mark - Private Methods

#pragma mark - Public Methods

-(id) initWithSearchTerm:(NSString*) pSearchTermString
{
    
    self = [super init];
    if (!self)
        return nil;
    
    _pSearchTermString = [pSearchTermString copy];
    [self prepareHttpSession];
    
    
   
    return self;
    
}

-(NSURL*) prepareURL
{
    
    NSString* pformattedSearchString = [_pSearchTermString stringByReplacingOccurrencesOfString:@" "
                                                                                     withString:@"+"];
    
    _pURLString = [kBaseURLString stringByAppendingString:pformattedSearchString];
    NSURL* pURL = [[NSURL alloc] initWithString:_pURLString];
    return  pURL;
    
}


@end
