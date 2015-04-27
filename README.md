# SIFloatingMenuViewController
---
This is a floating menu style navigation inspired by MailChimp's iOS menu navigation control. It utilizes the VBFPopFlatButton and TDBadgedCell frameworks. See a demo below:

##Demo
![Demo Gif]
(http://cl.ly/image/3p0e0R0O0225/ao0UT4k.gif)

##How to Use It

The best way to use this control is to use CocoaPods. Insert the following in your podfile:

	pod 'SIFloatingMenuViewController'
	
For more information on using CocoaPods, visit cocoapods.org. If this is your first time using CocoaPods, I also recommend watching the video [here] [1].
[1]: https://www.youtube.com/watch?v=9_FbAlq2g9o

###Basic Implementation

Once you've added the pod to your project, subclass the `SIFloatingMenuViewController` and add your version of the following code to the `viewDidLoad` method.

	//Create the menu items
	SIMenuItem *menuItem1 = [SIMenuItem menuItemWithTitle:@"View 1" image:[UIImage imageNamed:@"Image1"]];
    SIMenuItem *menuItem2 = [SIMenuItem menuItemWithTitle:@"View 2" image:[UIImage imageNamed:@"Image2"]];
    SIMenuItem *menuItem3 = [SIMenuItem menuItemWithTitle:@"View 3" image:[UIImage imageNamed:@"Image3"]];
    
	//Add the menu items
    [self.menuTableView setMenuItems:@[menuItem1, menuItem2, menuItem3]];
    
	//Initialize the UIViewControllers you want to be displayed when a menu item is tapped
    UIViewController *vc1 = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"View 1"];
    UIViewController *vc2 = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"View 2"];
    UIViewController *vc3 = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"View 3"];
    
	//Set them on the SIFloatingMenuViewController.
    self.viewControllers = @[vc1, vc2, vc3];
    
###Customizing the Menu Button

Below are just some of the customizations you can make to the control. There are plenty more including changing where the menu button is displayed on screen (Bottom Left, Bottom Middle, or Bottom Right) and how the menu button is animated onto screen.

######Change the bounciness of the animations
    self.animationBounciness = 0;
    
######Change the speed of the animations
    self.animationSpeed = 10;
    
######Change how far away the menu button is from the edge
    self.menuButtonBorderMargin = 20;
    
######Make the menu button show up an additional 10 points higher from the bottom of the screen
    self.menuButtonAdditionalBottomMargin = 10;
    
######Make the menu button show up an additional 5 points further from the sides of the screen
    self.menuButtonAdditionalSideMargin = 5;
    
######Change the size of the button
    self.menuButtonSize = CGSizeMake(60, 60);
    
######Change the darkness of the dimmed view behind the menu
	self.dimmedViewAlpha = 0.25;
	
######Change whether tapping on the background view dismisses the menu
	self.backgroundTapDismissesMenu = NO;