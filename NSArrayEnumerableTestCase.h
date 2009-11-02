//
//  NSArrayEnumerableTestCase.h
//  Keirin
//
//  Created by jpld on 26 Oct 2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>

@class Animal;

@interface NSArrayEnumerableTestCase : SenTestCase {
@private
    NSArray* _animals;
    Animal* _boy;
    Animal* _cat;
    Animal* _bird;
}
@end
