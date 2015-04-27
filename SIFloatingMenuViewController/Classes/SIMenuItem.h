//
//  SIMenuItem.h
//  SIFloatingMenuViewController
//
//  Created by Shawn Irvin on 4/25/15.
//  Copyright (c) 2015 Shawn Irvin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SIMenuItem : NSObject

/**
 *  The image displayed to the left of the title. This is OPTIONAL.
 */
@property (strong, nonatomic) UIImage *image;

/**
 *  The image displayed to the left of the title when the current Menu Item is selected. This is OPTIONAL. The image will be used if this property is empty.
 */
@property (strong, nonatomic) UIImage *selectedImage;

/**
 *  The title to be displayed in the menu.
 */
@property (strong, nonatomic) NSString *title;

/**
 *  The badge value to be displayed on the right side of the cell.
 */
@property (nonatomic) int badgeValue;


/**
 *  Initializes a new menu item.
 *
 *  @param title         Title of the menu item.
 *  @param image         Image of the menu item.
 *  @param selectedImage Selected image of the menu item.
 *
 *  @return Initialized menu item.
 */
+(instancetype)menuItemWithTitle:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage;

/**
 *  Initializes a new menu item.
 *
 *  @param title         Title of the menu item.
 *  @param image         Image of the menu item.
 *
 *  @return Initialized menu item.
 */
+(instancetype)menuItemWithTitle:(NSString *)title image:(UIImage *)image;

@end
