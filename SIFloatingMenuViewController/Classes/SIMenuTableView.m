//
//  SIMenuTableView.m
//  SIFloatingMenuViewController
//
//  Created by Shawn Irvin on 4/25/15.
//  Copyright (c) 2015 Shawn Irvin. All rights reserved.
//

#import "SIMenuTableView.h"

@interface SIMenuTableView() <UITableViewDelegate, UITableViewDataSource>

@end

@implementation SIMenuTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    
    if (self) {
        [self initializeProperties];
    }
    
    return self;
}

-(void)initializeProperties {
    self.dataSource = self;
    self.rowHeight = 44;
    
    [self registerClass:[TDBadgedCell class] forCellReuseIdentifier:@"MenuItemCell"];
    
    self.selectedCellBackgroundColor = [UIColor groupTableViewBackgroundColor];
    self.cellBackgroundColor = [UIColor whiteColor];
    self.menuItemTitleFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:16];
    self.menuItemTitleTextColor = [UIColor blackColor];
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - Table View Data Source Methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.menuItems.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.customTableViewCellBlock) {
        return self.customTableViewCellBlock(self, indexPath);
    }
    else {
        NSString *cellIdentifier = @"MenuItemCell";
        
        TDBadgedCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (!cell) {
            cell = [[TDBadgedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        
        NSInteger currentIndex = indexPath.row;
        SIMenuItem *menuItem = [self.menuItems objectAtIndex:currentIndex];
        
        cell.textLabel.text = menuItem.title;
        cell.imageView.image = currentIndex == self.selectedIndex && menuItem.selectedImage ? menuItem.selectedImage : menuItem.image;
        cell.backgroundColor = currentIndex == self.selectedIndex ? self.selectedCellBackgroundColor : self.cellBackgroundColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.textLabel.font = self.menuItemTitleFont;
        cell.textLabel.textColor = self.menuItemTitleTextColor;
        
        cell.badgeRightOffset = 15;
        cell.badge.fontSize = 13;
        cell.badge.radius = cell.badge.frame.size.height/2;
        cell.badgeColor = [UIColor colorWithRed:134./255. green:190./255. blue:193./255. alpha:1.];
        
        if (menuItem.badgeValue > 0) {
            cell.badgeString = [NSString stringWithFormat:@"%i", menuItem.badgeValue];
        }
        else {
            [cell.badge removeFromSuperview];
        }
        
        if (self.modifyTableViewCellBlock) {
            cell = self.modifyTableViewCellBlock(self, indexPath, cell);
        }
        
        return cell;
    }
}

@end
