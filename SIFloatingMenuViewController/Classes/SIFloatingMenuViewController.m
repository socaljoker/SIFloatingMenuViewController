//
//  SIFloatingMenuViewController.m
//  SIFloatingMenuViewController
//
//  Created by Shawn Irvin on 4/21/15.
//  Copyright (c) 2015 Shawn Irvin. All rights reserved.
//

#import "SIFloatingMenuViewController.h"
#import "POP.h"

#define DEFAULT_MENU_BUTTON_WIDTH 40
#define DEFAULT_MENU_BUTTON_HEIGHT 40

#define DEFAULT_MENU_BUTTON_MARGIN 15

#define DEFAULT_MENU_BUTTON_ANIMATION_SPEED 17
#define DEFAULT_MENU_BUTTON_ANIMATION_BOUNCINESS 13
#define DEFAULT_MENU_BUTTON_PRESSED_ANIMATION_SCALE 0.75

#define DEFAULT_DIMMED_VIEW_ALPHA 0.5
#define DEFAULT_DIMMED_VIEW_ANIMATION_SPEED 0.25

#define BOTTOM_MENU_BUFFER 50

@interface SIFloatingMenuViewController () <UITableViewDelegate>

@property (nonatomic) BOOL animateMenuButtonIconToInitialState;
@property (strong, nonatomic) UIView *dimmedView;
@property (nonatomic) CGRect currentMenuButtonFrame;
@property (strong, nonatomic) UITapGestureRecognizer *tapGesture;

@end

@implementation SIFloatingMenuViewController

@synthesize menuButton = _menuButton, menuTableView = _menuTableView;

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self initilizeProperties];
    }
    
    return self;
}

-(instancetype)init {
    self = [super init];
    
    if (self) {
        [self initilizeProperties];
    }
    
    return self;
}

-(instancetype)initWithViewControllers:(NSArray *)viewControllers menuButtonSize:(CGSize)size borderMargin:(CGFloat)margin animateIconToInitalState:(BOOL)animateToInitialState {
    self = [self init];
    
    if (self) {
        _viewControllers = viewControllers;
        self.menuButtonSize = size;
        self.menuButtonBorderMargin = margin;
        self.animateMenuButtonIconToInitialState = animateToInitialState;
    }
    
    return self;
}

-(void)initilizeProperties {
    self.menuButtonSize = CGSizeMake(DEFAULT_MENU_BUTTON_WIDTH, DEFAULT_MENU_BUTTON_HEIGHT);
    self.menuButtonBorderMargin = DEFAULT_MENU_BUTTON_MARGIN;
    self.menuButtonAnimationType = kSIMenuAnimationTypeFromBottom;
    self.menuButtonLocation = kSIMenuLocationBottomLeft;
    self.animateMenuButtonIconToInitialState = YES;
    self.animationSpeed = DEFAULT_MENU_BUTTON_ANIMATION_SPEED;
    self.animationBounciness = DEFAULT_MENU_BUTTON_ANIMATION_BOUNCINESS;
    self.menuButtonPressedAnimationScale = DEFAULT_MENU_BUTTON_PRESSED_ANIMATION_SCALE;
    self.dimmedViewAlpha = DEFAULT_DIMMED_VIEW_ALPHA;
    self.dimmedViewAnimationSpeed = DEFAULT_DIMMED_VIEW_ANIMATION_SPEED;
    self.backgroundTapDismissesMenu = YES;
    _menuIsOpen = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self showMenuButtonAnimated:YES];
}

-(void)setAnimationSpeed:(CGFloat)menuButtonAnimationSpeed {
    _animationSpeed = MAX(0, MIN(20, menuButtonAnimationSpeed));
}

-(void)setAnimationBounciness:(CGFloat)menuButtonAnimationBounciness {
    _animationBounciness = MAX(0, MIN(20, menuButtonAnimationBounciness));
}

-(void)setMenuButtonPressedAnimationScale:(CGFloat)menuButtonPressedAnimationScale {
    _menuButtonPressedAnimationScale = MAX(0, MIN(1, menuButtonPressedAnimationScale));
}

-(SIMenuButton *)menuButton {
    if (!_menuButton) {
        _menuButton = [[SIMenuButton alloc] initWithFrame:[self calculateInitialRect] animateToInitialState:self.animateMenuButtonIconToInitialState];
        
        __weak SIFloatingMenuViewController *weakSelf = self;
        
        [_menuButton setButtonPressedBlock:^void(SIMenuButton *button){
            [weakSelf menuButtonPressed:button];
        }];
        
        [_menuButton setButtonPressFinishedBlock:^void(SIMenuButton *button){
            [weakSelf menuButtonPressFinished:button];
        }];
        
        [_menuButton setButtonPressCancelledBlock:^void(SIMenuButton *button){
            [weakSelf menuButtonPressCancelled:button];
        }];
    }
    
    return _menuButton;
}

-(SIMenuTableView *)menuTableView {
    if (!_menuTableView) {
        _menuTableView = [[SIMenuTableView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 0) style:UITableViewStylePlain];
        _menuTableView.delegate = self;
    }
    
    return _menuTableView;
}

-(UITapGestureRecognizer *)tapGesture {
    if (!_tapGesture) {
        _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundTapped:)];
        _tapGesture.numberOfTapsRequired = 1;
    }
    
    return _tapGesture;
}

-(UIView *)dimmedView {
    if (!_dimmedView) {
        _dimmedView = [[UIView alloc] initWithFrame:self.view.bounds];
        _dimmedView.backgroundColor = [UIColor colorWithRed:0./255. green:0./255. blue:0./255. alpha:self.dimmedViewAlpha];
        
        [_dimmedView addGestureRecognizer:self.tapGesture];
    }
    
    return _dimmedView;
}

-(void)setDimmedViewAlpha:(CGFloat)dimmedViewAlpha {
    _dimmedViewAlpha = MAX(0, MIN(1, dimmedViewAlpha));
}

-(void)animateToScale:(CGFloat)scale {
    NSValue *toValue = [NSValue valueWithCGSize:CGSizeMake(scale, scale)];
    
    POPSpringAnimation *animation = [POPSpringAnimation animation];
    
    animation.property = [POPAnimatableProperty propertyWithName:kPOPViewScaleXY];
    animation.springSpeed = self.animationSpeed;
    animation.springBounciness = self.animationBounciness;
    animation.toValue = toValue;
    
    [self.menuButton pop_addAnimation:animation forKey:@"MenuButtonPressedAnimation"];
}

-(void)menuButtonPressed:(id)sender {
    [self animateToScale:self.menuButtonPressedAnimationScale];
}

-(void)menuButtonPressFinished:(id)sender {
    [self animateToScale:1];
    
    if (self.menuIsOpen) {
        [self hideMenuAnimated:YES];
    }
    else {
        [self showMenuAnimated:YES];
    }
}

-(void)menuButtonPressCancelled:(id)sender {
    [self animateToScale:1];
}

-(CGFloat)calculateInitialXOrigin {
    CGFloat xOrigin;
    
    if (self.menuButtonAnimationType == kSIMenuAnimationTypeNone || self.menuButtonAnimationType == kSIMenuAnimationTypeFromBottom) {
        if (self.menuButtonLocation == kSIMenuLocationBottomLeft) {
            xOrigin = self.menuButtonBorderMargin;
        }
        else if (self.menuButtonLocation == kSIMenuLocationBottomRight) {
            xOrigin = self.view.frame.size.width - self.menuButtonSize.width - self.menuButtonBorderMargin;
        }
        else if (self.menuButtonLocation == kSIMenuLocationBottomMiddle) {
            xOrigin = CGRectGetMidX(self.view.frame) - self.menuButtonSize.width / 2;
        }
    }
    else if (self.menuButtonAnimationType == kSIMenuAnimationTypeFromLeft) {
        xOrigin = self.menuButtonSize.width * -1;
    }
    else if (self.menuButtonAnimationType == kSIMenuAnimationTypeFromRight) {
        xOrigin = self.view.frame.size.width;
    }
    
    return xOrigin;
}

-(CGFloat)calculateInitialYOrigin {
    CGFloat yOrigin;
    
    if (self.menuButtonAnimationType == kSIMenuAnimationTypeNone || self.menuButtonAnimationType != kSIMenuAnimationTypeFromBottom) {
        yOrigin = self.view.frame.size.height - self.menuButtonSize.height - self.menuButtonBorderMargin;
    }
    else {
        yOrigin = self.view.frame.size.height;
    }
    
    return yOrigin;
}

-(CGFloat)calculateFinalXOrigin {
    CGFloat xOrigin;
    
    if (self.menuButtonLocation == kSIMenuLocationBottomLeft) {
        xOrigin = self.menuButtonBorderMargin + self.menuButtonAdditionalSideMargin;
    }
    else if (self.menuButtonLocation == kSIMenuLocationBottomRight) {
        xOrigin = self.view.frame.size.width - self.menuButtonSize.width - self.menuButtonBorderMargin - self.menuButtonAdditionalSideMargin;
    }
    else if (self.menuButtonLocation == kSIMenuLocationBottomMiddle) {
        xOrigin = CGRectGetMidX(self.view.frame) - self.menuButtonSize.width / 2;
        
        if (self.menuButtonAdditionalSideMargin > xOrigin) {
            xOrigin += self.menuButtonAdditionalSideMargin - xOrigin;
        }
    }
    
    return xOrigin;
}

-(CGFloat)calculateFinalYOrigin {
    CGFloat yOrigin;
    
    yOrigin = self.view.frame.size.height - self.menuButtonSize.height - self.menuButtonBorderMargin - self.menuButtonAdditionalBottomMargin;
    
    return yOrigin;
}

-(CGRect)calculateInitialRect {
    CGFloat x = [self calculateInitialXOrigin];
    CGFloat y = [self calculateInitialYOrigin];
    
    CGRect initialRect = CGRectMake(x, y, self.menuButtonSize.width, self.menuButtonSize.height);
    
    return initialRect;
}

-(CGRect)calculateFinalRect {
    CGFloat x = [self calculateFinalXOrigin];
    CGFloat y = [self calculateFinalYOrigin];
    
    CGRect finalRect = CGRectMake(x, y, self.menuButtonSize.width, self.menuButtonSize.height);
    
    return finalRect;
}

-(void)backgroundTapped:(UITapGestureRecognizer *)tapGesture {
    if (self.backgroundTapDismissesMenu) {
        [self hideMenuAnimated:YES];
    }
}

-(void)showDimmedViewAnimated:(BOOL)animated {
    self.dimmedView.alpha = 0;
    [self.view insertSubview:self.dimmedView belowSubview:self.menuButton];
    
    if (animated) {
        [UIView animateWithDuration:self.dimmedViewAnimationSpeed animations:^{
            self.dimmedView.alpha = 1;
        }];
    }
    else {
        self.dimmedView.alpha = 1;
    }
}

-(void)hideDimmedViewAnimated:(BOOL)animated {
    if (animated) {
        [UIView animateWithDuration:self.dimmedViewAnimationSpeed animations:^{
            self.dimmedView.alpha = 0;
        } completion:^(BOOL finished) {
            [self.dimmedView removeFromSuperview];
            self.dimmedView = nil;
        }];
    }
    else {
        self.dimmedView.alpha = 0;
        [self.dimmedView removeFromSuperview];
        self.dimmedView = nil;
    }
}

-(void)offsetMenuButtonByHeight:(CGFloat)heightOffset animated:(BOOL)animated {
    CGRect frame = self.currentMenuButtonFrame;
    frame.origin.y -= heightOffset;
    
    self.currentMenuButtonFrame = frame;
    
    if (animated) {
        NSValue *toValue = [NSValue valueWithCGRect:frame];
        
        POPSpringAnimation *animation = [POPSpringAnimation animation];
        
        animation.property = [POPAnimatableProperty propertyWithName:kPOPViewFrame];
        animation.springSpeed = self.animationSpeed;
        animation.springBounciness = self.animationBounciness;
        animation.toValue = toValue;
        
        [self.menuButton pop_addAnimation:animation forKey:@"MenuButtonYOffsetAnimation"];
    }
    else {
        self.menuButton.frame = frame;
    }
}

-(void)showMenuAnimated:(BOOL)animated
{
    [self.menuButton.buttonIcon animateToType:buttonCloseType];
    
    [self showDimmedViewAnimated:animated];
    
    [self.menuTableView reloadData];
    
    CGFloat menuHeight = self.menuTableView.menuItems.count*self.menuTableView.rowHeight;
    
    CGRect frame = self.menuTableView.frame;
    frame.size.height = menuHeight + BOTTOM_MENU_BUFFER;
    
    self.menuTableView.frame = frame;
    [self.view addSubview:self.menuTableView];
    
    frame.origin.y = self.view.frame.size.height - menuHeight;
    
    if (animated) {
        NSValue *toValue = [NSValue valueWithCGRect:frame];
        
        POPSpringAnimation *animation = [POPSpringAnimation animation];
        
        animation.property = [POPAnimatableProperty propertyWithName:kPOPViewFrame];
        animation.springSpeed = self.animationSpeed;
        animation.springBounciness = self.animationBounciness;
        animation.toValue = toValue;
        
        [self.menuTableView pop_addAnimation:animation forKey:@"MenuAnimation"];
    }
    else {
        self.menuTableView.frame = frame;
    }
    
    [self offsetMenuButtonByHeight:menuHeight animated:animated];
    
    _menuIsOpen = YES;
}

-(void)hideMenuAnimated:(BOOL)animated
{
    [self.menuButton.buttonIcon animateToType:buttonMenuType];
    
    [self hideDimmedViewAnimated:animated];
    
    CGFloat menuHeight = self.menuTableView.menuItems.count*self.menuTableView.rowHeight;
    
    CGRect frame = self.menuTableView.frame;
    frame.origin.y = self.view.frame.size.height;
    
    if (animated) {
        NSValue *toValue = [NSValue valueWithCGRect:frame];
        
        POPSpringAnimation *animation = [POPSpringAnimation animation];
        
        animation.property = [POPAnimatableProperty propertyWithName:kPOPViewFrame];
        animation.springSpeed = self.animationSpeed;
        animation.springBounciness = self.animationBounciness;
        animation.toValue = toValue;
        
        [self.menuTableView pop_addAnimation:animation forKey:@"MenuHideAnimation"];
    }
    else {
        self.menuTableView.frame = frame;
    }
    
    [self offsetMenuButtonByHeight:(menuHeight * -1) animated:animated];
    
    _menuIsOpen = NO;
}

-(void)showMenuButtonAnimated:(BOOL)animated {
    [self.view addSubview:self.menuButton];
    
    CGRect finalRect = [self calculateFinalRect];
    
    if (self.menuButtonAnimationType != kSIMenuAnimationTypeNone && animated) {
        self.currentMenuButtonFrame = finalRect;
        NSValue *toValue = [NSValue valueWithCGRect:finalRect];
        
        POPSpringAnimation *animation = [POPSpringAnimation animation];
        
        animation.property = [POPAnimatableProperty propertyWithName:kPOPViewFrame];
        animation.springSpeed = self.animationSpeed;
        animation.springBounciness = self.animationBounciness;
        animation.toValue = toValue;
        
        [self.menuButton pop_addAnimation:animation forKey:@"MenuButtonAnimation"];
    }
    else {
        self.menuButton.frame = finalRect;
    }
}

-(void)setViewControllers:(NSArray *)viewControllers {
    if (!_viewControllers) {
        [self.view insertSubview:[viewControllers.firstObject view] belowSubview:self.menuButton];
    }
    
    _viewControllers = viewControllers;
}

#pragma mark - Table View Delegate Methods

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *oldViewController = [self.viewControllers objectAtIndex:self.menuTableView.selectedIndex];
    UIViewController *newViewController = [self.viewControllers objectAtIndex:indexPath.row];
    
    SIMenuItem *menuItem = [self.menuTableView.menuItems objectAtIndex:self.menuTableView.selectedIndex];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.menuTableView.selectedIndex inSection:0]];
    cell.backgroundColor = self.menuTableView.cellBackgroundColor;
    cell.imageView.image = menuItem.image;
    
    self.menuTableView.selectedIndex = indexPath.row;
    
    SIMenuItem *selectedMenuItem = [self.menuTableView.menuItems objectAtIndex:self.menuTableView.selectedIndex];
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    selectedCell.backgroundColor = self.menuTableView.selectedCellBackgroundColor;
    selectedCell.imageView.image = selectedMenuItem.selectedImage ? selectedMenuItem.selectedImage : selectedMenuItem.image;
    
    [oldViewController.view removeFromSuperview];
    [self.view insertSubview:newViewController.view belowSubview:self.menuButton];
    
    [self hideMenuAnimated:YES];
    
    if (self.menuItemSelectedBlock) {
        self.menuItemSelectedBlock(selectedMenuItem, self.menuTableView.selectedIndex);
    }
}

@end
