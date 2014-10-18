//
//  ARNDeferredTask.m
//  ARNDeferred
//
//  Created by Airin on 2014/04/16.
//  Copyright (c) 2014 Airin. All rights reserved.
//

#if !__has_feature(objc_arc)
#error This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
#endif

#import "ARNDeferredTask.h"

@interface ARNDeferredTask ()

@property (nonatomic, readwrite) ARNDeferredTaskState state;

@end

@implementation ARNDeferredTask {
    ARNDeferredTackCallbackBlock _fireBlock;
    ARNDeferredCallbackBlock _doneBlock;
    ARNDeferredCallbackBlock _failBlock;
    ARNDeferredCallbackBlock _cancelBlock;
}

// -------------------------------------------------------------------------------------------------------------------------------//
#pragma mark - Class Methods

+ (instancetype)createTask
{
    return [[self class] new];
}

// -------------------------------------------------------------------------------------------------------------------------------//
#pragma mark - Custom Setters

- (void (^)(ARNDeferredTackCallbackBlock))fire
{
    return ^void (ARNDeferredTackCallbackBlock block) {
        _fireBlock = [block copy];
    };
}

- (void (^)(ARNDeferredCallbackBlock))done
{
    return ^void (ARNDeferredCallbackBlock block) {
        _doneBlock = [block copy];
    };
}

- (void (^)(ARNDeferredCallbackBlock))fail
{
    return ^void (ARNDeferredCallbackBlock block) {
        _failBlock = [block copy];
    };
}

- (void (^)(ARNDeferredCallbackBlock))cancel
{
    return ^void (ARNDeferredCallbackBlock block) {
        _cancelBlock = [block copy];
    };
}

// -------------------------------------------------------------------------------------------------------------------------------//
#pragma mark - Instance Methods

- (instancetype)init
{
    if (!(self = [super init])) { return nil; }
    
    _state = ARNDeferredTaskStateUnresolved;
    
    return self;
}

- (void)fire:(id)resultObject
{
    if (_fireBlock) {
        _fireBlock(self, resultObject);
    }
}

- (void)done:(id)resultObject
{
    self.state = ARNDeferredTaskStateResolved;
    if (_doneBlock) {
        _doneBlock(resultObject);
    }
}

- (void)fail:(id)resultObject
{
    self.state = ARNDeferredTaskStateRejected;
    if (_failBlock) {
        _failBlock(resultObject);
    }
}

- (void)cancel:(id)resultObject
{
    self.state = ARNDeferredTaskStateCanceled;
    if (_cancelBlock) {
        _cancelBlock(resultObject);
    }
}

@end
