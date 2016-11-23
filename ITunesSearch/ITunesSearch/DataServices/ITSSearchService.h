//
//  ITSHttpService.h
//  ITunesSearch
//
//  Created by Monojit Datta on 22/11/16.
//  Copyright © 2016 Monojit Datta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseHttpDataService.h"


@interface ITSSearchService : BaseHttpDataService

-(id) initWithSearchTerm:(NSString*) pSearchTermString;



@end


