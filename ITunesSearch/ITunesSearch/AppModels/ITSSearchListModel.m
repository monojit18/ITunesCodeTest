//
//  ITSSearchModel.m
//  ITunesSearch
//
//  Created by Monojit Datta@Cognizant on 11/22/16.
//  Copyright © 2016 Monojit Datta. All rights reserved.
//

#import "ITSSearchListModel.h"
#import "ITSSearchAdapter.h"
#import "ITSSearchService.h"
#import "ITSDownloadService.h"
#import "ITSDownloadAdapter.h"

@interface ITSSearchListModel ()

-(void) prepareSearchResults:(NSArray<ITSSearchModel*>*) pSearchResultsArray;

-(NSString*) extractReleaseDate:(NSString*) pReleaseDateTimeString;

@end


@implementation ITSSearchListModel

-(void) prepareSearchResults:(NSArray*) pSearchResultsArray
{
    
    if (!pSearchResultsArray && !(pSearchResultsArray.count))
        return;
    
    NSMutableArray* pSearchResultsArrayM = [NSMutableArray arrayWithCapacity:pSearchResultsArray.count];
    
    for (NSDictionary* pSearchResultDictionary  in pSearchResultsArray)
    {
        
        ITSSearchModel* pSearchResult = [[ITSSearchModel alloc] init];
        
        pSearchResult.artworkUrl = pSearchResultDictionary[@"artworkUrl100"];
        pSearchResult.artistName = pSearchResultDictionary[@"artistName"];
        pSearchResult.trackName = pSearchResultDictionary[@"trackName"];
        pSearchResult.collectionName = pSearchResultDictionary[@"collectionName"];
        
        NSString* pReleaseDateString = pSearchResultDictionary[@"releaseDate"];
        pSearchResult.releaseDate = [self extractReleaseDate:pReleaseDateString];
        pSearchResult.collectionPrice = pSearchResultDictionary[@"collectionPrice"];
        
        [pSearchResultsArrayM addObject:pSearchResult];
        
    }
    
    self.searchModelsArray = [[NSArray alloc] initWithArray:pSearchResultsArrayM];
    
}

-(NSString*) extractReleaseDate:(NSString*) pReleaseDateTimeString
{
    
    NSDateFormatter* pDateFormatter = [[NSDateFormatter alloc] init];
    [pDateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    
    NSDate* pReleasedDate = [pDateFormatter dateFromString:pReleaseDateTimeString];
    [pDateFormatter setDateFormat:@"dd-MM-yyyy"];
    
    NSString* pReleaseDateString = [pDateFormatter stringFromDate:pReleasedDate];
    return pReleaseDateString;
    
}

-(void) search:(NSString*) pSearchString withCallbackAsync:(AppModelCallback) pCallback
{
    
    NSAssert(pCallback != NULL, @"Provide an AppModel Callback");
    __weak typeof(self) pWeakSelf = self;
    
    ITSSearchService* pSearchService = [[ITSSearchService alloc] initWithSearchTerm:pSearchString];
    ITSSearchAdapter* pSearchAdapter = [[ITSSearchAdapter alloc] initWithHttpService:pSearchService];
    
    [pSearchAdapter searchWithCallbackAsync:^(BaseAdapter *pAdapter, id pResponse, NSError *pError)
    {
        
        NSDictionary* pResponseDictionary = (NSDictionary*) pResponse;
        if (pResponseDictionary && pResponseDictionary.count)
        {
            
            NSArray* pSearchModelsArray = pResponseDictionary[@"results"];
            [pWeakSelf prepareSearchResults:pSearchModelsArray];
            
        }
        
        pCallback(pWeakSelf, pError);
        
    }];
    
}

@end

@implementation ITSSearchModel

-(void) downloadImageFromURL:(NSString*) pURLString
{
    
    __weak typeof(self) pWeakSelf = self;
    
    ITSDownloadService* pDownloadService = [[ITSDownloadService alloc] initWithDownloadURL:pURLString];
    ITSDownloadAdapter* pDownloadAdapter = [[ITSDownloadAdapter alloc] initWithHttpService:pDownloadService];
    
    [pDownloadAdapter downloadWithCallbackAsync:^(BaseAdapter *pAdapter, id pResponse, NSError *pError)
    {
        
        __strong typeof(pWeakSelf) pStrongSelf = pWeakSelf;
        pStrongSelf.artWorkData = (NSData*)pResponse;
        
        NSDictionary* pUserInfoDictionary = @{@"searchModel" : pStrongSelf};
        [[NSNotificationCenter defaultCenter] postNotificationName:@"OnRefresh" object:nil
                                                          userInfo:pUserInfoDictionary];
        
        
    }];
    
}

@end
