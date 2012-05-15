//
//  YKTableViewDataSource.h
//  YelpKit
//
//  Created by Gabriel Handford on 5/13/12.
//  Copyright (c) 2012 Yelp. All rights reserved.
//

@protocol YKTableViewCellDataSource <NSObject>
- (UITableViewCell *)cellForTableView:(UITableView *)tableView rowAtIndexPath:(NSIndexPath *)indexPath;
- (CGSize)sizeThatFits:(CGSize)size;
@end


@interface YKTableViewDataSource : NSObject <UITableViewDelegate, UITableViewDataSource> {  
  NSMutableDictionary */*Row -> NSMutableArray of id<YKTableViewCellDataSource>*/_cellDataSourceSections;
    
  NSMutableDictionary */*Row -> NSString*/_sectionHeaderTitles;
  NSMutableDictionary */*Row -> UIView*/_sectionHeaderViews;  
  NSMutableDictionary */*Row -> UIView*/_sectionFooterViews;
  
  NSInteger _sectionCount; // We need to keep section count stable since row animating requires tht we don't add or remove sections while animating.
  
  // We can optimize away *forHeaderInSection by tracking if we've ever had headers set
  BOOL _headersExist;
}

/*!
 Create empty data source.
 */
+ (YKTableViewDataSource *)dataSource;

/*!
 Create data source with cell data sources.
 @param cellDataSources
 */
+ (YKTableViewDataSource *)dataSourceWithCellDataSources:(NSArray */*of id<YKTableViewCellDataSource>*/)cellDataSources;

/*!
 Clear section.
 @param section Section to clear
 @param indexPaths If set, adds the index paths we removed
 */
- (void)clearSection:(NSInteger)section indexPaths:(NSMutableArray **)indexPaths;

/*!
 Get index path for last row in the last section.
 @result Last index path
 */
- (NSIndexPath *)lastIndexPath;

/*!
 Number of sections.
 @result Number of sections
 */
- (NSInteger)sectionCount;

/*!
 Number of cells for a section.
 @param section Section to count
 @result Cell count in section
 */
- (NSInteger)countForSection:(NSInteger)section;

- (void)clearSection:(NSInteger)section indexPaths:(NSMutableArray **)indexPaths;

- (void)setHeaderTitle:(NSString *)title section:(NSInteger)section;
- (void)setHeaderView:(UIView *)view section:(NSInteger)section;

//! Clear all cells.
- (void)clearAll;

//! Clear header views and titles
- (void)clearHeaders;

- (void)setHeaderView:(UIView *)view section:(NSInteger)section;
- (void)setFooterView:(UIView *)view section:(NSInteger)section;

- (id<YKTableViewCellDataSource>)cellDataSourceAtIndexPath:(NSIndexPath *)indexPath;

- (UITableViewCell *)cellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

- (NSIndexPath *)addCellDataSource:(id<YKTableViewCellDataSource>)cellDataSource section:(NSInteger)section;

/*!
 Add cell data sources.
 @param array List of id<YKTableViewCellDataSource>
 @param section Section to append to
 @param indexPaths If specified, adds NSIndexPath's that were added (for help animating)
 */
- (void)addCellDataSources:(NSArray */*of id<YKTableViewCellDataSource>*/)array section:(NSInteger)section indexPaths:(NSMutableArray **)indexPaths;

/*!
 Truncate section to remove all cells after count.
 @param count
 @param section
 @param indexPaths Index paths we removed
 */
- (void)truncateCellDataSourcesToCount:(NSInteger)count section:(NSInteger)section indexPaths:(NSMutableArray **)indexPaths;

- (void)removeCellDataSourceAtIndexPaths:(NSArray *)indexPaths;
- (BOOL)removeCellDataSourceAtIndexPath:(NSIndexPath *)indexPath;
- (BOOL)removeCellDataSourceForRow:(NSInteger)row inSection:(NSInteger)section;

- (void)replaceCellDataSource:(id<YKTableViewCellDataSource>)cellDataSource indexPath:(NSIndexPath *)indexPath;

- (NSIndexPath *)indexPathForCellDataSource:(id<YKTableViewCellDataSource>)cellDataSource;

- (void)moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath;

- (void)insertCellDataSource:(id<YKTableViewCellDataSource>)cellDataSource atIndexPath:(NSIndexPath *)indexPath;

/*!
 Insert cell data sources.
 @param array List of id<YKUITableViewCellDataSource>
 @param section Section to insert to
 @param atIndex Index to insert at
 @param indexPaths If specified, adds NSIndexPath's that were added (for help animating)
 */
- (void)insertCellDataSources:(NSArray */*of id<YKTableViewCellDataSource>*/)array section:(NSInteger)section atIndex:(NSInteger)index indexPaths:(NSMutableArray **)indexPaths;

/*!
 Enumerator for cell data sources.
 */
- (NSEnumerator *)enumeratorForCellDataSources;

/*!
 Replace cell data sources.
 @param array List of id<YKUITableViewCellDataSource>
 @param section Section to append to
 */
- (void)setCellDataSources:(NSArray */*of id<YKTableViewCellDataSource>*/)array section:(NSInteger)section;

- (NSMutableArray *)cellDataSourcesForSection:(NSInteger)section;

@end


@interface YKTableViewDataSourceEnumerator : NSEnumerator { 
  YKTableViewDataSource *_dataSource;
  NSInteger _section;
  NSInteger _index;
}
@property (readonly, nonatomic) NSIndexPath *indexPath;

- (id)initWithDataSource:(YKTableViewDataSource *)dataSource;

@end