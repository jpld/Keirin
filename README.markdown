
A set of categories on Cocoa collection classes with several traversal and searching methods; inspired by Ruby's Enumerable Module [http://www.ruby-doc.org/core/classes/Enumerable.html](http://www.ruby-doc.org/core/classes/Enumerable.html)

rough support for NSArray is available e.g.

    Animal* firstBiped = [animals detect:^(id obj) {
        return (BOOL)([(Animal*)obj numberOfLegs] == 2);
    }];

    NSArray* quadrupeds = [animals select:^(id obj) {
        return (BOOL)([(Animal*)obj numberOfLegs] == 4);
    }];

    BOOL containsArachnids = [animals any:^(id obj) {
        return (BOOL)([(Animal*)obj numberOfLegs] == 8);
    }];

Mac OS X 10.6 SnowLeopard or later required due to block use.