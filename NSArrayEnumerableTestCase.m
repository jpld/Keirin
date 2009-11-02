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

- (void)dealloc {
    [_name release];

    [super dealloc];
}

- (NSString*)description {
    return [NSString stringWithFormat:@"%@ legs:%d % fly", self.name, self.numberOfLegs, (self.canFly ? @"can" : @"cannot" )];
}

@end

@implementation NSArrayEnumerableTestCase

- (void)setUp {
    _animals = [[NSArray alloc] initWithObjects:
                [Animal animalWithName:@"boy" numberOfLegs:2 canFly:NO],
                [Animal animalWithName:@"cat" numberOfLegs:4 canFly:NO],
                [Animal animalWithName:@"bird" numberOfLegs:2 canFly:YES],
                nil];
}

- (void)tearDown {
    [_animals release];
}

@end
