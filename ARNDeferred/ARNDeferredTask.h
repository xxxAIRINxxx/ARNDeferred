//
//  ARNDeferredTask.h
//  ARNDeferred
//
//  Created by Airin on 2014/04/16.
//  Copyright (c) 2014 Airin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ARNDeferred.h"

@interface ARNDeferredTask : NSObject

@property (nonatomic, readonly) ARNDeferredTaskState state;

@property (readonly) void (^fire)(ARNDeferredTackCallbackBlock block);
@property (readonly) void (^done)(ARNDeferredCallbackBlock block);
@property (readonly) void (^fail)(ARNDeferredCallbackBlock block);
@property (readonly) void (^cancel)(ARNDeferredCallbackBlock block);

+ (instancetype)createTask;

- (void)fire:(id)resultObject;
- (void)done:(id)resultObject;
- (void)fail:(id)resultObject;
- (void)cancel:(id)resultObject;

@end
