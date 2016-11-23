//
//  ITSSearchModel.h
//  ITunesSearch
//
//  Created by Monojit Datta@Cognizant on 11/22/16.
//  Copyright © 2016 Monojit Datta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseAppModel.h"

@class ITSSearchModel;
@interface ITSSearchListModel : BaseAppModel

@property(nonatomic, strong) NSArray<ITSSearchModel*>* searchModelsArray;

-(void) search:(NSString*) pSearchString withCallbackAsync:(AppModelCallback) pCallback;


@end

@interface ITSSearchModel : BaseAppModel

@property(nonatomic, copy) NSString* artworkUrl;
@property(nonatomic, copy) NSString* artistName;
@property(nonatomic, copy) NSString* trackName;
@property(nonatomic, copy) NSString* collectionName;
@property(nonatomic, copy) NSString* releaseDate;
@property(nonatomic, strong) NSNumber* collectionPrice;
@property(nonatomic, strong) NSData* artWorkData;

-(void) downloadImageFromURL:(NSString*) pURLString;


@end
