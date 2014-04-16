//
//  ARNDeferred.h
//  ARNDeferred
//
//  Created by Airin on 2014/04/16.
//  Copyright (c) 2014 Airin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM (NSInteger, ARNDeferredTaskState) {
    ARNDeferredTaskStateUnresolved = 0,
    ARNDeferredTaskStateResolved,
    ARNDeferredTaskStateRejected,
    ARNDeferredTaskStateCanceled
};

@class ARNDeferredTask;

typedef void (^ARNDeferredCallbackBlock)(id resultObject);
typedef void (^ARNDeferredCompletionBlock) ();
typedef void (^ARNDeferredTackCallbackBlock)(ARNDeferredTask *task, id resultObject);

#define ARNDeferredTackBlockParameter (ARNDeferredTask * task, id resultObject)

@interface ARNDeferred : NSObject

@property (readonly) void (^then)(ARNDeferredTackCallbackBlock block);
@property (readonly) void (^resolved)(ARNDeferredCallbackBlock block);
@property (readonly) void (^rejected)(ARNDeferredCallbackBlock block);
@property (readonly) void (^canceller)(ARNDeferredCompletionBlock block);
@property (readonly) void (^completion)(ARNDeferredCompletionBlock block);

+ (instancetype)deferred;

- (void)runDeferred:(id)resultObject;

@end
