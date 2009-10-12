//
//  NSArray-EnumerableAdditions.m
//  Keirin
//
//  Created by jpld on 11 Oct 2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "NSArray-EnumerableAdditions.h"

@implementation NSArray(Enumerable)

- (id)detect:(BOOL (^)(id obj))predicate {
    __block id object = nil;
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL* stop) {
        if (!predicate(obj))
            return;
        object = obj;
        *stop = YES;
    }];
    return object;
}

- (NSArray*)select:(BOOL (^)(id obj))predicate {
    __block NSMutableIndexSet* idxs = [[NSMutableIndexSet alloc] init];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL* stop) {
        if (!predicate(obj))
            return;
        [idxs addIndex:idx];
    }];
    return [self objectsAtIndexes:idxs];    
}

- (NSArray*)reject:(BOOL (^)(id obj))predicate {
    __block NSMutableIndexSet* idxs = [[NSMutableIndexSet alloc] init];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL* stop) {
        if (predicate(obj))
            return;
        [idxs addIndex:idx];
    }];
    return [self objectsAtIndexes:idxs];    
}

- (NSArray*)collect:(id (^)(id obj))predicate {
    // NB - not sure why the list variable doesn't require __block
    __block NSMutableArray* list = [[NSMutableArray alloc] initWithCapacity:[self count]];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL* stop) {
        id object = predicate(obj);
        if (!object)
            return;
        [list addObject:object];
    }];
    return (NSArray*)[list autorelease];
}

- (NSArray*)inject:(id (^)(id memo, id obj))predicate {
    __block id memo = nil;
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL* stop) {
        memo = predicate(memo, obj);
    }];
    return memo;
}

- (id)injectWithInitialValue:(id)initial predicate:(id (^)(id memo, id obj))predicate {
    __block id memo = initial;
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL* stop) {
        memo = predicate(memo, obj);
    }];
    return memo;
}

- (BOOL)all:(BOOL (^)(id obj))predicate {
    __block BOOL status = false;
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL* stop) {
        status = predicate(obj);
        if (status)
            return;
        *stop = YES;
    }];
    return status;
}

- (BOOL)any:(BOOL (^)(id obj))predicate {
    __block BOOL status = false;
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL* stop) {
        status = predicate(obj);
        if (!status)
            return;
        *stop = YES;
    }];
    return status;
}

@end
