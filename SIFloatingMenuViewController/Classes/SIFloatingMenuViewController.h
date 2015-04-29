//
//  SIFloatingMenuViewController.h
//  SIFloatingMenuViewController
//
//  Created by Shawn Irvin on 4/21/15.
//  Copyright (c) 2015 Shawn Irvin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SIMenuButton.h"
#import "SIMenuTableView.h"
#import "FXBlurView.h"

/**
 *  Choices for how the menu button animates onto screen.
 */
typedef NS_ENUM(NSUInteger, SIMenuButtonAnimationType){
    /**
     *  Animate from the left side of the screen to chosen location.
     */
    kSIMenuAnimationTypeFromLeft,
    /**
     *  Animate from the bottom of the screen to chosen location.
     */
    kSIMenuAnimationTypeFromBottom,
    /**
     *  Animate from the right side of the screen to chosen location.
     */
    kSIMenuAnimationTypeFromRight,
    /**
     *  No animation. Menu button just appears on screen.
     */
    kSIMenuAnimationTypeNone
};

/**
 *  Choices for where the menu button is displayed on screen.
 */
typedef NS_ENUM(NSUInteger, SIMenuButtonLocation){
    /**
     *  Shows the menu button in the bottom left corner of the screen.
     */
    kSIMenuLocationBottomLeft,
    /**
     *  Shows the menu button in the bottom right corner of the screen.
     */
    kSIMenuLocationBottomRight,
    /**
     *  Shows the menu button in the bottom middle of the screen.
     */
    kSIMenuLocationBottomMiddle
};

typedef void (^MenuItemSelected)(SIMenuItem *menuItem, NSUInteger selectedIndex);

@interface SIFloatingMenuViewController : UIViewController

/*******************************
    Menu Button Properties
 *******************************/

/**
*  The button containing the icon. This property is readonly, but you can still set values on it.
*/
@property (strong, nonatomic, readonly) SIMenuButton *menuButton;

/**
 *  Where the menu button is displayed on screen. Choose one of the SIMenuButtonLocation enum values.
 */
@property (nonatomic) SIMenuButtonLocation menuButtonLocation;

/**
 *  How the menu button is displayed on screen. Choose one of the SIMenuButtonAnimationType enum values.
 */
@property (nonatomic) SIMenuButtonAnimationType menuButtonAnimationType;

/**
 *  The size of the menu button. Looks best if width and height are equal.
 */
@property (nonatomic) CGSize menuButtonSize;

/**
 *  The distance between the edge of the button and the edge (left, bottom, and right edges) of the screen.
 */
@property (nonatomic) CGFloat menuButtonBorderMargin;

/**
 *  The additional margain to the bottom of the screen, on top of the menuButtonBorderMargin.
 */
@property (nonatomic) CGFloat menuButtonAdditionalBottomMargin;

/**
 *  The additional margain to the left or right of the screen, on top of the menuButtonBorderMargin.
 */
@property (nonatomic) CGFloat menuButtonAdditionalSideMargin;

/**
 *  How quickly the menuButton animates on screen. Must be a value between 0 and 20.
 */
@property (nonatomic) CGFloat animationSpeed;

/**
 *  How bouncy the menuButton is while animating. Must be a value between 0 and 20.
 */
@property (nonatomic) CGFloat animationBounciness;

/**
 *  When the menuButton is pressed, this determines how much it scales down. Must be a value between 0 and 1.
 */
@property (nonatomic) CGFloat menuButtonPressedAnimationScale;




/*******************************
 Menu Properties
 *******************************/

/**
 *  Whether the menu is currently showing on screen or not. This property is read only.
 */
@property (nonatomic, readonly) BOOL menuIsOpen;

/**
 *  Table view containing the menu items.
 */
@property (strong, nonatomic, readonly) SIMenuTableView *menuTableView;

/**
 *  The block that should be called when a menu item is selected.
 */
@property (strong, nonatomic) MenuItemSelected menuItemSelectedBlock;

/**
 *  The UIViewControllers to be displayed when the respective menu item is selected. This property is read only! Use the set, add, remove, and insert methods to modify the viewControllers.
 */
@property (strong, nonatomic) NSArray *viewControllers;

/**
 *  The speed at which the dimmed view should animate it's alpha.
 */
@property (nonatomic) CGFloat backgroundViewAnimationSpeed;

/**
 *  Should the menu dismiss if the background is tapped.
 */
@property (nonatomic) BOOL backgroundTapDismissesMenu;

/**
 *  The view displayed behind the menu when the menu is being displayed.
 */
@property (strong, nonatomic, readonly) FXBlurView *backgroundView;

/**
 *  DESIGNATED INITIALIZER
 *
 *  @param viewControllers       The UIViewControllers to be displayed when the respective menu item is selected.
 *  @param size                  The size of the menuButton.
 *  @param margin                The distance between the edge of the button and the edge (left, bottom, and right edges) of the screen.
 *  @param animateToInitialState Whether the icon should animate to it's initial state when coming on screen.
 *
 *  @return Instance of SIFloatingMenuViewController
 */
-(instancetype)initWithViewControllers:(NSArray *)viewControllers menuButtonSize:(CGSize)size borderMargin:(CGFloat)margin animateIconToInitalState:(BOOL)animateToInitialState;

/**
 *  Show the menu.
 *
 *  @param animated Whether the menu should animate on screen or not.
 */
-(void)showMenuAnimated:(BOOL)animated;

/**
 *  Hide the menu.
 *
 *  @param animated Whether the menu should animate off screen or not.
 */
-(void)hideMenuAnimated:(BOOL)animated;

@end
