# ARNDeferred

[![CI Status](http://img.shields.io/travis/xxxAIRINxxx/ARNDeferred.svg?style=flat)](https://travis-ci.org/xxxAIRINxxx/ARNDeferred)
[![Version](https://img.shields.io/cocoapods/v/ARNDeferred.svg?style=flat)](http://cocoadocs.org/docsets/ARNDeferred)
[![License](https://img.shields.io/cocoapods/l/ARNDeferred.svg?style=flat)](http://cocoadocs.org/docsets/ARNDeferred)
[![Platform](https://img.shields.io/cocoapods/p/ARNDeferred.svg?style=flat)](http://cocoadocs.org/docsets/ARNDeferred)

I aimed at the implementation of futures and promises and jQuery.Deferred.

but, It is only implemented then currently...

ARNDeferred is Simple.

## Features

Features of ARNDeferred is the following

* Then is called to order.

* Resolved and rejected only one.

* If you cancel, then and resolved and rejected also not called.

* Completion is called only once at the end always.

## Respect

It was inspired by the following products.

* [STDeferred](https://github.com/saiten/STDeferred)

* [OMPromises](https://github.com/b52/OMPromises)

* [Sequencer](https://github.com/berzniz/Sequencer)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

### then resolve
```objectivec

ARNDeferred *def = [ARNDeferred deferred];
def.then (^(ARNDeferredTask *task, id resultObject) {
// call
// resultObject -> @"test"
[task done:@"test2"];
});
def.then (^(ARNDeferredTask *task, id resultObject) {
// call
// resultObject -> @"test2"
[task done:@"test3"];
});
def.resolved (^(id resultObject){
// call
// resultObject -> @"test3"
});
def.rejected (^(id resultObject){
// not call
});
def.canceller (^(id resultObject){
// not call
});
def.completion (^{
// call
});
[def runDeferred:@"test"];

```

### then reject
```objectivec

ARNDeferred *def = [ARNDeferred deferred];
def.then (^(ARNDeferredTask *task, id resultObject) {
// call
// resultObject -> @"test"
[task fail:@"test2"];
});
def.then (^(ARNDeferredTask *task, id resultObject) {
// not call
});
def.resolved (^(id resultObject){
// not call
});
def.rejected (^(id resultObject){
// call
// resultObject -> @"test2"
});
def.canceller (^(id resultObject){
// not call
});
def.completion (^{
// call
});
[def runDeferred:@"test"];

```

### then cancel
```objectivec

ARNDeferred *def = [ARNDeferred deferred];
def.then (^(ARNDeferredTask *task, id resultObject) {
// call
// resultObject -> @"test"
[task cancel:@"test2"];
});
def.then (^(ARNDeferredTask *task, id resultObject) {
// not call
});
def.resolved (^(id resultObject){
// not call
});
def.rejected (^(id resultObject){
// not call
});
def.canceller (^(id resultObject){
// call
// resultObject -> @"test2"
});
def.completion (^{
// call
});
[def runDeferred:@"test"];

```

## Requirements

* iOS 5.0+
* ARC

## Installation

ARNDeferred is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod "ARNDeferred"

## License

ARNDeferred is available under the MIT license. See the LICENSE file for more info.

