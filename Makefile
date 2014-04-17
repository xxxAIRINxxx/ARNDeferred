PROJECT=ARNDeferred.xcodeproj
SCHEME=ARNDeferred
TEST_SCHEME=ARNDeferredTests

default: clean build test

clean:
		xctool \
		-project ${PROJECT} \
		-scheme ${SCHEME} \
		clean

build:
		xctool \
		-project ${PROJECT} \
		-scheme ${SCHEME} \
		build \
		-sdk iphonesimulator

test:
		xctool \
		-project ${PROJECT} \
		-scheme ${SCHEME} \
		test \
		-test-sdk iphonesimulator \
		-parallelize
