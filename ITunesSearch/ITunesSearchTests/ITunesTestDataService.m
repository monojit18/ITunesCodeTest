//
//  ITunesTestDataService.m
//  ITunesSearch
//
//  Created by Monojit Datta@Cognizant on 11/23/16.
//  Copyright © 2016 Monojit Datta. All rights reserved.
//

#import "ITunesTestDataService.h"

@implementation ITunesTestDataService

-(void) getAsyncWithCallback:(HTTPCallback) pCallback
{
    
    NSMutableDictionary* pTestDictionaryM = [[NSMutableDictionary alloc] initWithCapacity:1];
    NSMutableDictionary* pTestModelDictionaryM = [[NSMutableDictionary alloc] initWithCapacity:1];
    
    pTestModelDictionaryM[@"artworkUrl100"] = @"http://is1.mzstatic.com/image/thumb/Music/v4/2f/e8/ea/2fe8ea10-1313-daff-595b-24ab3eb6ef91/source/60x60bb.jpg";
    pTestModelDictionaryM[@"artistName"] = @"Test Artist";
    pTestModelDictionaryM[@"trackName"] = @"Test Track";
    pTestModelDictionaryM[@"collectionName"] = @"Test Collection";
    pTestModelDictionaryM[@"releaseDate"] = @"2011-03-21T00:00:00Z";
    pTestModelDictionaryM[@"collectionPrice"] = [NSNumber numberWithDouble:15.55];
    
    pTestDictionaryM[@"results"] = pTestModelDictionaryM;
    
    NSData* pData = [NSJSONSerialization dataWithJSONObject:pTestDictionaryM options:NSJSONWritingPrettyPrinted
                                                      error:NULL];

    _pHttpCallback = pCallback;
    pCallback(self, pData, nil);
    
}


@end
