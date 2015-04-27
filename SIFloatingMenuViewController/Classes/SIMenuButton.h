//
//  SIMenuButton.h
//  SIFloatingMenuViewController
//
//  Created by Shawn Irvin on 4/25/15.
//  Copyright (c) 2015 Shawn Irvin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VBFPopFlatButton.h"

@class SIMenuButton;

typedef void (^MenuButtonPressed)(SIMenuButton *button);
typedef void (^MenuButtonPressFinished)(SIMenuButton *button);
typedef void (^MenuButtonPressCancelled)(SIMenuButton *button);

@interface SIMenuButton : UIButton

/**
 *  The icon in the middle of the button.
 */
@property (strong, nonatomic, readonly) VBFPopFlatButton *buttonIcon;

/**
 *  The percentage of the button that the icon should take up. This value should be between 0 and 1.
 */
@property (nonatomic) CGFloat menuIconSizePercentage;

/**
 *  Block to be called when menu button is pressed.
 */
@property (strong, nonatomic) MenuButtonPressed buttonPressedBlock;

/**
 *  Block to be called when menu button press finishes.
 */
@property (strong, nonatomic) MenuButtonPressFinished buttonPressFinishedBlock;

/**
 *  Block to be called when the menu button press has been cancelled.
 */
@property (strong, nonatomic) MenuButtonPressCancelled buttonPressCancelledBlock;

/**
 *  DESIGNATED INITIALIZER.
 *
 *  @param frame   The frame of the button.
 *  @param animate Whether the icon in the button should animate to it's initial state.
 *
 *  @return Initialized SIMenuButton.
 */
-(instancetype)initWithFrame:(CGRect)frame animateToInitialState:(BOOL)animate;

@end
