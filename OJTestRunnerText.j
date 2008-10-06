import <Foundation/Foundation.j>

import "OJTestCase.j"
import "OJTestSuite.j"
import "OJTestResult.j"

import "OJTestListenerText.j"

CPLogRegister(CPLogPrint);

@implementation OJTestRunnerText : CPObject
{
    OJTestListener _listener;
}

- (id)init
{
    if (self = [super init])
    {
        _listener = [[OJTestListenerText alloc] init];
    }
    return self;
}

- (OJTest)getTest:(CPString)suiteClassName
{
    var testClass = objj_lookUpClass(suiteClassName);
    
    if (testClass)
    {
        var suite = [[OJTestSuite alloc] initWithClass:testClass];
        return suite;
    }
    
    CPLog.warn("unable to get tests");
    return nil;
}

- (void)startWithArguments:(CPArray)args
{
    var testCaseFile = args.shift();
    
    if (!testCaseFile)
        return;

    var matches = testCaseFile.match(/([^\/]+)\.j$/)
    print(matches[1]);
    var testCaseClass = matches[1];
        
    objj_import(testCaseFile, YES, function() {
        var suite = [self getTest:testCaseClass];

        [self run:suite];
        
        // run the next test when this is done
        [self startWithArguments:args];
    });
}

- (OJTestResult)run:(OJTest)suite wait:(BOOL)wait
{
    var result = [[OJTestResult alloc] init];
    
    [result addListener:_listener];
    
    [suite run:result];
    
    return result;
}
- (OJTestResult)run:(OJTest)suite
{
    return [self run:suite wait:NO];
}

+ (void)runTest:(OJTest)suite
{
    var runner = [[OJTestRunnerText alloc] init];
    [runner run:suite];
}

+ (void)runClass:(Class)aClass
{
    [self runTest:[[OJTestSuite alloc] initWithClass:aClass]];
}

@end

print(args);

runner = [[OJTestRunnerText alloc] init];
[runner startWithArguments:args];
