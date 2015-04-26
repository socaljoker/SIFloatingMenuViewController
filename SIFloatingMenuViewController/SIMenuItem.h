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

@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) UIImage *selectedImage;
@property (strong, nonatomic) NSString *title;
@property (nonatomic) int badgeValue;

+(instancetype)menuItemWithTitle:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage;
+(instancetype)menuItemWithTitle:(NSString *)title image:(UIImage *)image;

@end
