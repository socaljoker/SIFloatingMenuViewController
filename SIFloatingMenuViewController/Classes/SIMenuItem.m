//
//  SIMenuItem.m
//  SIFloatingMenuViewController
//
//  Created by Shawn Irvin on 4/25/15.
//  Copyright (c) 2015 Shawn Irvin. All rights reserved.
//

#import "SIMenuItem.h"

@implementation SIMenuItem

+(instancetype)menuItemWithTitle:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage
{
    return [[SIMenuItem alloc] initWithTitle:title image:image selectedImage:selectedImage];
}

+(instancetype)menuItemWithTitle:(NSString *)title image:(UIImage *)image
{
    return [[SIMenuItem alloc] initWithTitle:title image:image selectedImage:nil];
}

-(instancetype)initWithTitle:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage
{
    self = [super init];
    
    if (self) {
        self.title = title;
        self.image = image;
        self.selectedImage = image;
        self.badgeValue = 0;
    }
    
    return self;
}

@end
