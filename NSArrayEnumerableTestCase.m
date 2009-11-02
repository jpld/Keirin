//
//  NSArrayEnumerableTestCase.m
//  Keirin
//
//  Created by jpld on 26 Oct 2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "NSArrayEnumerableTestCase.h"
#import "NSArray-EnumerableAdditions.h"

@interface Animal : NSObject {
@private
    NSString* _name;
    NSUInteger _numberOfLegs;
    BOOL _canFly;
}
+ (id)animalWithName:(NSString*)name numberOfLegs:(NSUInteger)legs canFly:(BOOL)flag;
@property (nonatomic, retain) NSString* name;
@property (nonatomic) NSUInteger numberOfLegs;
@property (nonatomic) BOOL canFly;
@end

@implementation Animal
@synthesize name = _name, numberOfLegs = _numberOfLegs, canFly = _canFly;

+ (id)animalWithName:(NSString*)name numberOfLegs:(NSUInteger)legs canFly:(BOOL)flag {
    Animal* a = [[[self class] alloc] init];
    if (!a)
        return nil;
    a.name = name;
    a.numberOfLegs = legs;
    a.canFly = flag;
    return [a autorelease];
}

- (id)initWithName:(NSString*)name numberOfLegs:(NSUInteger)legs canFly:(BOOL)flag {
    self = [super init];
    if (!self)
        return nil;
    self.name = name;
    self.numberOfLegs = legs;
    self.canFly = flag;
    return self;
}

- (void)dealloc {
    [_name release];

    [super dealloc];
}

- (NSString*)description {
    return [NSString stringWithFormat:@"%@ legs:%d % fly", self.name, self.numberOfLegs, (self.canFly ? @"can" : @"cannot" )];
}

@end

# pragma mark -

@implementation NSArrayEnumerableTestCase

- (void)setUp {
    _boy = [[Animal alloc] initWithName:@"boy" numberOfLegs:2 canFly:NO];
    _cat = [[Animal alloc] initWithName:@"cat" numberOfLegs:4 canFly:NO];
    _bird = [[Animal alloc] initWithName:@"bird" numberOfLegs:2 canFly:YES];
    _animals = [[NSArray alloc] initWithObjects:_boy, _cat, _bird, nil];
}

- (void)tearDown {
    [_animals release];

    [_boy release];
    [_cat release];
    [_bird release];
}

# pragma mark -
# pragma mark DETECT

- (void)testDetectForKnownPresentAnimal {
    Animal* firstBiped = [_animals detect:^(id obj) {
        return (BOOL)([(Animal*)obj numberOfLegs] == 2);
    }];

    STAssertNotNil(firstBiped, @"should return non-nil result");
    STAssertEquals(firstBiped, _boy, @"first two legged animal should be boy");
}

- (void)testDetectForKnownMissingAnimal {
    Animal* gorilla = [_animals detect:^(id obj) {
        return (BOOL)([[(Animal*)obj name] isEqualToString:@"gorilla"]);
    }];

    STAssertNil(gorilla, @"should not detect result");
}

- (void)testDetectOnEmptyArray {
    NSArray* list = [[NSArray alloc] init];
    Animal* firstBiped = [list detect:^(id obj) {
        return (BOOL)([(Animal*)obj numberOfLegs] == 2);
    }];
    [list release];

    STAssertNil(firstBiped, @"empty array should not detect result");
}

- (void)testDetectOnNilArray {
    NSArray* list = nil;
    Animal* firstBiped = [list detect:^(id obj) {
        return (BOOL)([(Animal*)obj numberOfLegs] == 2);
    }];

    STAssertNil(firstBiped, @"nil array should not detect result");
}

# pragma mark -
# pragma mark SELECT

- (void)testSelectForKnownPresentAnimals {
    NSArray* bipeds = [_animals select:^(id obj) {
        return (BOOL)([(Animal*)obj numberOfLegs] == 2);
    }];

    STAssertNotNil(bipeds, @"should return non-nil result");
    STAssertTrue(bipeds.count == 2, @"should select 2 objects");
    STAssertEquals([bipeds objectAtIndex:0], _boy, @"first selection should be boy");
    STAssertEquals([bipeds objectAtIndex:1], _bird, @"second selection should be bird");
}

- (void)testSelectForKnownMissingAnimals {
    NSArray* picks = [_animals select:^(id obj) {
        return (BOOL)([(Animal*)obj numberOfLegs] == 0);
    }];

    STAssertNotNil(picks, @"should return non-nil result");
    STAssertTrue(picks.count == 0, @"should select 0 objects");
}

- (void)testSelectOnEmptyArray {
    NSArray* list = [[NSArray alloc] init];
    NSArray* bipeds = [list select:^(id obj) {
        return (BOOL)([(Animal*)obj numberOfLegs] == 2);
    }];
    [list release];

    STAssertNotNil(bipeds, @"should return non-nil result");
    STAssertTrue(bipeds.count == 0, @"should select 0 objects");
}

- (void)testSelectOnNilArray {
    NSArray* list = nil;
    NSArray* bipeds = [list select:^(id obj) {
        return (BOOL)([(Animal*)obj numberOfLegs] == 2);
    }];

    STAssertNil(bipeds, @"should return nil result");
}

@end
