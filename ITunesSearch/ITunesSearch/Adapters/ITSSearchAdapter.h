//
//  ITSSearchAdapter.h
//  ITunesSearch
//
//  Created by Monojit Datta@Cognizant on 11/22/16.
//  Copyright © 2016 Monojit Datta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseAdapter.h"

@interface ITSSearchAdapter : BaseAdapter

-(void) searchWithCallbackAsync:(AdapterCallback) pCallback;

@end
