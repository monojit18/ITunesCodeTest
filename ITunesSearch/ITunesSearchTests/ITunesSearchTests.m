//
//  ITunesSearchTests.m
//  ITunesSearchTests
//
//  Created by Monojit Datta on 22/11/16.
//  Copyright © 2016 Monojit Datta. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ITunesTestDataService.h"
#import "ITSSearchAdapter.h"

@interface ITunesSearchTests : XCTestCase

@end

@implementation ITunesSearchTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark - Test Search Adapter
-(void) testSearchAdapter
{
    
    XCTestExpectation* pExpectation = [self expectationWithDescription:@"testSearchAdapter"];
    
    ITunesTestDataService* pTestService = [[ITunesTestDataService alloc] init];
    ITSSearchAdapter* pTestAdapter = [[ITSSearchAdapter alloc] initWithHttpService:pTestService];
    
    [pTestAdapter searchWithCallbackAsync:^(BaseAdapter *pAdapter, id pResponse, NSError *pError)
    {
        
        NSLog(@"Test%@", pResponse);
        [pExpectation fulfill];
        
    }];
    
    [self waitForExpectationsWithTimeout:2.0 handler:NULL];
    
    
    
}

@end
