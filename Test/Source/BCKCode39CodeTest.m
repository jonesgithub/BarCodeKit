//
//  BCKCode39CodeTest.m
//  BarCodeKit
//
//  Created by Oliver Drobnik on 8/19/13.
//  Copyright (c) 2013 Oliver Drobnik. All rights reserved.
//

#import "BCKCode39Code.h"
#import "BCKCode39CodeModulo43.h"

@interface BCKCode39Code () // private

- (NSString *)bitString;

@end


@interface BCKCode39CodeTest : SenTestCase

@property BCKCode39CodeModulo43 *codeWithModulo43CheckDigit;

@end

@implementation BCKCode39CodeTest

- (void)setUp
{
	[super setUp];
   
	self.codeWithModulo43CheckDigit = [[BCKCode39CodeModulo43 alloc] initWithContent:@"OLIVER"];
}

- (void)tearDown
{
	self.codeWithModulo43CheckDigit = nil;
	
	[super tearDown];
}

// tests encoding a basic word
- (void)testEncode
{
	BCKCode39Code *code = [[BCKCode39Code alloc] initWithContent:@"OLIVER"];
	NSString *expected = @"1001011011010110101101001010110101001101011010011010100110101011011010110010101101010110010100101101101";
	NSString *actual = [code bitString];
	BOOL isEqual = [expected isEqualToString:actual];
	
	STAssertTrue(isEqual, @"Result from encoding incorrect");
}

// lower case should not be possible initially
- (void)testEncodeInvalid
{
	BCKCode39Code *code = [[BCKCode39Code alloc] initWithContent:@"oliver"];
	STAssertNil(code, @"Should not be able to encode lower case text in Code39");
}

// tests encoding a barcode with the Modulo 43 check digit
- (void)testEncodeWithModulo43CheckDigit
{
	NSString *expected = @"10010110110101101011010010101101010011010110100110101001101010110110101100101011010101100101011001101010100101101101";
	NSString *actual = [self.codeWithModulo43CheckDigit bitString];
	BOOL isEqual = [expected isEqualToString:actual];
	
	STAssertTrue(isEqual, @"Mod 43 check digit incorrect");
}

@end
