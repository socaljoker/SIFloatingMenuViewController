//
//  SIMenuTableView.h
//  SIFloatingMenuViewController
//
//  Created by Shawn Irvin on 4/25/15.
//  Copyright (c) 2015 Shawn Irvin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SIMenuItem.h"
#import "TDBadgedCell.h"

@class SIMenuTableView;

typedef UITableViewCell* (^CustomTableViewCell)(SIMenuTableView *tableView, NSIndexPath *indexPath);
typedef TDBadgedCell* (^ModifyTableViewCell)(SIMenuTableView *tableView, NSIndexPath *indexPath, TDBadgedCell *cell);

@interface SIMenuTableView : UITableView

/**
 *  Menu items to be displayed.
 */
@property (strong, nonatomic) NSArray *menuItems;

/**
 *  Implement this block to use a completely custom UITableViewCell design for the menu items.
 */
@property (strong, nonatomic) CustomTableViewCell customTableViewCellBlock;

/**
 *  Implement this block to modify the appearance of the base TDBadgedCell design.
 */
@property (strong, nonatomic) ModifyTableViewCell modifyTableViewCellBlock;

/**
 *  The background color of the currently selected cell.
 */
@property (strong, nonatomic) UIColor *selectedCellBackgroundColor;

/**
 *  The background color of the cells.
 */
@property (strong, nonatomic) UIColor *cellBackgroundColor;

/**
 *  The currently selected index.
 */
@property (nonatomic) NSInteger selectedIndex;

/**
 *  Font to be used when displaying the menu item title in the menu.
 */
@property (strong, nonatomic) UIFont *menuItemTitleFont;

/**
 *  Color of the menu item title.
 */
@property (strong, nonatomic) UIColor *menuItemTitleTextColor;

@end
