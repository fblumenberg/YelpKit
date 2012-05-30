YelpKit
========

YelpKit is a iOS framework for Objective-C, and contains some basics for image loading, caching, requests, views and layouts.

- [API documentation](http://yelp.github.com/YelpKit/).

Install
-------

YelpKit assumes that you are using a modern Xcode project building to the DerivedData directory. Confirm your settings
via the "File" menu > "Project Settings...". On the "Build" tab within the sheet that opens, click the "Advanced..."
button and confirm that your "Build Location" is the "Derived Data Location".

1. Add Git submodule to your project: `git submodule add git://github.com/Yelp/YelpKit.git YelpKit`
1. Add cross-project reference by dragging **YelpKit.xcodeproj** to your project
1. Open build settings editor for your project
1. Add the following **Header Search Paths** (including the quotes): `"$(BUILT_PRODUCTS_DIR)/../../Headers"`
1. Add **Other Linker Flags** for `-ObjC -all_load`
1. Open target settings editor for the target you want to link YelpKit into
1. Add direct dependency on the **YelpKit** aggregate target
1. Link against YelpKit:
    1. **libYelpKit.a** on iOS
    1. **YelpKit.framework** on OS X
1. Import the YelpKit headers via `#import <YelpKit/YelpKit.h>`
1. Build the project to verify installation is successful.

