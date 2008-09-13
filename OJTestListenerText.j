import <Foundation/Foundation.j>

@implementation OJTestListenerText : CPObject

- (void)addError:(CPException)error forTest:(OJTest)aTest
{
    CPLog.error("addError  test="+[aTest description]+" error="+error);
}

- (void)addFailure:(CPException)failure forTest:(OJTest)aTest
{
    CPLog.warn("addFailure test="+[aTest description]+" failure="+failure);
}

- (void)startTest:(OJTest)aTest
{
    CPLog.info("startTest  test="+[aTest description]);
}

- (void)endTest:(OJTest)aTest
{
    CPLog.info("endTest    test="+[aTest description]);
}

@end