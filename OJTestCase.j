import <Foundation/Foundation.j>

import "OJTestResult.j"

AssertionFailedError = "AssertionFailedError";

@implementation OJTestCase : CPObject
{
    SEL _selector;
}

- (OJTestResult)createResult
{
    return [[OJTestResult alloc] init];
}

- (OJTestResult)run
{
    var result = [self createResult];
    [self run:result];
    return result;
}

- (void)run:(OJTestResult)result
{
    [result run:self];
}

- (void)runBare
{
    [self setUp];
    try
    {
        [self runTest];
    }
    finally
    {
        [self tearDown];
    }
}

- (void)runTest
{
    [self assertNotNull:_selector];
    
    [self performSelector:_selector];
}

- (void)setUp
{
}

- (void)tearDown
{
}

- (SEL)selector
{
    return _selector;
}

- (void)setSelector:(SEL)aSelector
{
    _selector = aSelector;
}

- (int)countTestCases
{
    return 1;
}


- (void)assertTrue:(BOOL)condition
{
    [self assertTrue:condition message:nil];
}
- (void)assertTrue:(BOOL)condition message:(CPString)message
{
    if (!condition)
        [self fail:message];
}

- (void)assertFalse:(BOOL)condition
{
    [self assertFalse:condition message:nil];
}
- (void)assertFalse:(BOOL)condition message:(CPString)message
{
    [self assertTrue:(!condition) message:message];
}

- (void)assert:(id)expected equals:(id)actual
{
    [self assert:expected equals:actual message:nil];
}
- (void)assert:(id)expected equals:(id)actual message:(CPString)message
{
	if (expected !== actual && ![expected isEqual:actual])
	    [self failNotEqual:expected actual:actual message:message];
}

- (void)assert:(id)expected same:(id)actual
{
    [self assert:expected same:actual message:nil];
}
- (void)assert:(id)expected same:(id)actual message:(CPString)message
{
	if (expected === actual)
	    [self failSame:expected actual:actual message:message];
}

- (void)assert:(id)expected notSame:(id)actual
{
    [self assert:expected notSame:actual message:nil];
}
- (void)assert:(id)expected notSame:(id)actual message:(CPString)message
{
	if (expected !== actual)
		[self failNotSame:expected actual:actual message:message];
}

- (void)assertNull:(id)object
{
    [self assertNull:object message:nil];
}
- (void)assertNull:(id)object message:(CPString)message
{
	[self assertTrue:(object === null) message:message];
}

- (void)assertNotNull:(id)object
{
    [self assertNotNull:object message:nil];
}
- (void)assertNotNull:(id)object message:(CPString)message
{
	[self assertTrue:(object !== null) message:message];
}

- (void)fail
{
    [self fail:nil];
}

- (void)fail:(CPString)message
{
    [CPException raise:AssertionFailedError reason:(message || "Unknown")];
}

- (void)failSame:(id)expected actual:(id)actual message:(CPString)message
{
    [self fail:((message ? message+" " : "")+"expected not same")];
}

- (void)failNotSame:(id)expected actual:(id)actual message:(CPString)message
{
    [self fail:((message ? message+" " : "")+"expected same:<"+expected+"> was not:<"+actual+">")];
}

- (void)failNotEqual:(id)expected actual:(id)actual message:(CPString)message
{
    [self fail:((message ? message+" " : "")+"expected:<"+expected+"> but was:<"+actual+">")];
}

- (CPString)description
{
    return _selector;
}

@end

