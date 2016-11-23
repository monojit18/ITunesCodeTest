//
//  ITSDownloadAdapter.h
//  ITunesSearch
//
//  Created by Monojit Datta@Cognizant on 11/23/16.
//  Copyright © 2016 Monojit Datta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseAdapter.h"

@interface ITSDownloadAdapter : BaseAdapter

-(void) downloadWithCallbackAsync:(AdapterCallback) pCallback;

@end
