//
//  ARNDeferred.m
//  ARNDeferred
//
//  Created by Airin on 2014/04/16.
//  Copyright (c) 2014 Airin. All rights reserved.
//

#if !__has_feature(objc_arc)
#error This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
#endif

#import "ARNDeferred.h"
#import "ARNDeferredTask.h"

@implementation ARNDeferred {
    NSMutableArray            *_steps;
    ARNDeferredCallbackBlock   _resolvedBlock;
    ARNDeferredCallbackBlock   _rejectedBlock;
    ARNDeferredCallbackBlock   _cancelBlock;
    ARNDeferredCompletionBlock _completionBlock;
}

// -------------------------------------------------------------------------------------------------------------------------------//
#pragma mark - Class Methods

+ (instancetype)deferred
{
    return [[self class] new];
}

// -------------------------------------------------------------------------------------------------------------------------------//
#pragma mark - Custom Setters

- (void (^)(ARNDeferredTackCallbackBlock block))then
{
    return ^void (ARNDeferredTackCallbackBlock block) {
        ARNDeferredTask *task = [ARNDeferredTask createTask];
        
        task.fire ( ^(ARNDeferredTask *task, id resultObject){
            ARNDeferredTackCallbackBlock fireBlock = [block copy];
            if (fireBlock) {
                fireBlock(task, resultObject);
            }
        });
        task.done ( ^(id resultObject) {
            [self resolve:resultObject];
        });
        task.fail ( ^(id resultObject) {
            [self reject:resultObject];
        });
        task.cancel ( ^(id resultObject) {
            [self cancel:resultObject];
        });
        [_steps addObject:task];
    };
}

- (void (^)(ARNDeferredCallbackBlock))rejected
{
    return ^void (ARNDeferredCallbackBlock callblock) {
        _rejectedBlock = [callblock copy];
    };
}

- (void (^)(ARNDeferredCallbackBlock))resolved
{
    return ^void (ARNDeferredCallbackBlock callblock) {
        _resolvedBlock = [callblock copy];
    };
}

- (void (^)(ARNDeferredCompletionBlock))canceller
{
    return ^void (ARNDeferredCompletionBlock callblock) {
        _cancelBlock = [callblock copy];
    };
}

- (void (^)(ARNDeferredCompletionBlock))completion
{
    return ^void (ARNDeferredCompletionBlock callblock) {
        _completionBlock = [callblock copy];
    };
}

// -------------------------------------------------------------------------------------------------------------------------------//
#pragma mark - Instance Methods

- (instancetype)init
{
    if (!(self = [super init])) { return nil; }
    
    _steps = [NSMutableArray array];
    
    return self;
}

- (void)runDeferred:(id)resultObject
{
    if (![_steps count]) {
        [self finish];
    } else {
        [self resolve:resultObject];
    }
}

- (ARNDeferredTask *)dequeueNextStep
{
    if (![_steps count]) {
        return nil;
    }
    
    ARNDeferredTask *task = _steps[0];
    [_steps removeObjectAtIndex:0];
    return task;
}

- (void)resolve:(id)resultObject
{
    ARNDeferredTask *task = [self dequeueNextStep];
    if (task) {
        [task fire:resultObject];
    } else {
        if (_resolvedBlock) {
            _resolvedBlock(resultObject);
        }
        [self finish];
    }
}

- (void)reject:(id)resultObject
{
    if (_rejectedBlock) {
        _rejectedBlock(resultObject);
    }
    [self finish];
}

- (void)cancel:(id)resultObject
{
    if (_cancelBlock) {
        _cancelBlock(resultObject);
    }
    [self finish];
}

- (void)finish
{
    _steps         = nil;
    _resolvedBlock = nil;
    _rejectedBlock = nil;
    _cancelBlock   = nil;
    if (_completionBlock) {
        _completionBlock();
    }
}

@end
