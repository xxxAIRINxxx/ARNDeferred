//
//  ARNDeferredTests.m
//  ARNDeferredTests
//
//  Created by Airin on 2014/04/16.
//  Copyright (c) 2014 Airin. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ARNDeferred.h"
#import "ARNDeferredTask.h"

@interface ARNDeferredTests : XCTestCase

@end

@implementation ARNDeferredTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testThenResolve
{
    ARNDeferred *def = [ARNDeferred deferred];
    def.then (^(ARNDeferredTask *task, id resultObject) {
        NSString *resultString = (NSString *)resultObject;
        XCTAssert([resultString isEqualToString:@"test"], " then 1 error");
        [task done:@"test2"];
    });
    def.then (^(ARNDeferredTask *task, id resultObject) {
        NSString *resultString = (NSString *)resultObject;
        XCTAssert([resultString isEqualToString:@"test2"], " then 2 error");
        [task done:@"test3"];
    });
    def.resolved (^(id resultObject){
        NSLog(@"%s call resolved", __PRETTY_FUNCTION__);
        NSString *resultString = (NSString *)resultObject;
        XCTAssert([resultString isEqualToString:@"test3"], " resolved error");
    });
    def.rejected (^(id resultObject){
        XCTFail("call error rejected");
    });
    def.canceller (^(id resultObject){
        XCTFail("call error canceller");
    });
    def.completion (^{
        NSLog(@"%s call completion", __PRETTY_FUNCTION__);
    });
    
    [def runDeferred:@"test"];
}

- (void)testThenReject
{
    ARNDeferred *def = [ARNDeferred deferred];
    def.then (^(ARNDeferredTask *task, id resultObject) {
        NSString *resultString = (NSString *)resultObject;
        XCTAssert([resultString isEqualToString:@"test"], " then 1 error");
        [task fail:@"test2"];
    });
    def.then (^(ARNDeferredTask *task, id resultObject) {
        XCTFail("call error then");
    });
    def.resolved (^(id resultObject){
        XCTFail("call error resolved");
    });
    def.rejected (^(id resultObject){
        NSLog(@"%s call rejected", __PRETTY_FUNCTION__);
        NSString *resultString = (NSString *)resultObject;
        XCTAssert([resultString isEqualToString:@"test2"], " rejected error");
    });
    def.canceller (^(id resultObject){
        XCTFail("call error canceller");
    });
    def.completion (^{
        NSLog(@"%s call completion", __PRETTY_FUNCTION__);
    });
    
    [def runDeferred:@"test"];
}

- (void)testThenCancel
{
    ARNDeferred *def = [ARNDeferred deferred];
    def.then (^(ARNDeferredTask *task, id resultObject) {
        NSString *resultString = (NSString *)resultObject;
        XCTAssert([resultString isEqualToString:@"test"], " then 1 error");
        [task cancel:resultObject];
    });
    def.then (^(ARNDeferredTask *task, id resultObject) {
        XCTFail("call error then");
    });
    def.resolved (^(id resultObject){
        XCTFail("call error resolved");
    });
    def.rejected (^(id resultObject){
        XCTFail("call error rejected");
    });
    def.canceller (^(id resultObject){
        NSLog(@"%s call canceller", __PRETTY_FUNCTION__);
        NSString *resultString = (NSString *)resultObject;
        XCTAssert([resultString isEqualToString:@"test"], " canceller error");
    });
    def.completion (^{
        NSLog(@"%s call completion", __PRETTY_FUNCTION__);
    });
    
    [def runDeferred:@"test"];
}

@end
