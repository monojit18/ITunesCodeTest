//
//  BaseAppModel.h
//  ITunesSearch
//
//  Created by Monojit Datta@Cognizant on 11/22/16.
//  Copyright © 2016 Monojit Datta. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BaseAppModel;
typedef void(^AppModelCallback)(BaseAppModel* pAppModel, NSError* pError);

@interface BaseAppModel : NSObject

@end
