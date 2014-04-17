ARNDeferred
============

[![Build Status](https://travis-ci.org/xxxAIRINxxx/ARNDeferred.svg?branch=master)](https://travis-ci.org/xxxAIRINxxx/ARNDeferred)

I aimed at the implementation of futures and promises and jQuery.Deferred.

but, It is only implemented then currently...

ARNDeferred is Simple.

Welcome Pull Request!

Features
============

Features of ARNDeferred is the following

* then is called to order.

* resolved and rejected only one.

* If you cancel, then and resolved and rejected also not called.

* completion is called only once at the end always.


Respect
============

It was inspired by the following products.

* [STDeferred](https://github.com/saiten/STDeferred)

* [OMPromises](https://github.com/b52/OMPromises)

* [Sequencer](https://github.com/berzniz/Sequencer)


Requirements
============

ARNDeferred requires iOS 5.0 and above, and uses ARC.


How To Use
============

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


Licensing
============

The source code is distributed under the nonviral MIT License.

 It's the simplest most permissive license available.


Japanese Note
============

jQuery.Deferred.のようなfutures/promisesパターンを実装したく試行錯誤した結果物です。

thenしか実装してませんが。。

実際に組み込むならRespectで挙げたライブラリ等を使った方が良いかと。。

分かりやすさだけが強みだと思っています。実装の参考程度にして下さい。

プルリクお待ちしています！
