//
//  YKTableView.h
//  YelpKit
//
//  Created by Gabriel Handford on 5/13/12.
//  Copyright (c) 2012 Yelp. All rights reserved.
//

#import "YKTableViewDataSource.h"

@interface YKTableView : UITableView {
  YKTableViewDataSource *dataSource_;
}

- (YKTableViewDataSource *)tableViewDataSource;

@end
