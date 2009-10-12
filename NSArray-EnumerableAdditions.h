//
//  NSArray-EnumerableAdditions.h
//  Keirin
//
//  Created by jpld on 11 Oct 2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

// see http://www.ruby-doc.org/core/classes/Enumerable.html
@interface NSArray(Enumerable)
- (id)detect:(BOOL (^)(id obj))predicate; // find
- (NSArray*)select:(BOOL (^)(id obj))predicate; // find_all
- (NSArray*)reject:(BOOL (^)(id obj))predicate;
- (NSArray*)collect:(id (^)(id obj))predicate; // map
- (id)inject:(id (^)(id memo, id obj))predicate;
- (id)injectWithInitialValue:(id)initial predicate:(id (^)(id memo, id obj))predicate;
- (BOOL)all:(BOOL (^)(id obj))predicate;
- (BOOL)any:(BOOL (^)(id obj))predicate;
@end
