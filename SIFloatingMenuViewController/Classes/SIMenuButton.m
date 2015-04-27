//
//  SIMenuButton.m
//  SIFloatingMenuViewController
//
//  Created by Shawn Irvin on 4/25/15.
//  Copyright (c) 2015 Shawn Irvin. All rights reserved.
//

#import "SIMenuButton.h"

#define DEFAULT_MENU_BUTTON_SIZE_PERCENTAGE .5

@interface SIMenuButton()

@property (nonatomic) BOOL animateMenuButtonIconToInitialState;
//@property (strong, nonatomic) UIButton *fullContainerButton;

@end

@implementation SIMenuButton

@synthesize buttonIcon = _buttonIcon;

-(instancetype)initWithFrame:(CGRect)frame animateToInitialState:(BOOL)animate
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.animateMenuButtonIconToInitialState = animate;
        self.menuIconSizePercentage = DEFAULT_MENU_BUTTON_SIZE_PERCENTAGE;
        
        self.backgroundColor = [UIColor colorWithRed:134./255. green:190./255. blue:193./255. alpha:0.75];
        self.tintColor = [UIColor whiteColor];
        
        [self addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchDown];
        [self addTarget:self action:@selector(buttonPressFinished:) forControlEvents:UIControlEventTouchUpInside];
        [self addTarget:self action:@selector(buttonPressCancelled:) forControlEvents:UIControlEventTouchUpOutside | UIControlEventTouchCancel];
    }
    
    return self;
}

-(void)buttonPressed:(id)sender {
    if (self.buttonPressedBlock) {
        self.buttonPressedBlock(self);
    }
}

-(void)buttonPressFinished:(id)sender {
    if (self.buttonPressFinishedBlock) {
        self.buttonPressFinishedBlock(self);
    }
}

-(void)buttonPressCancelled:(id)sender {
    if (self.buttonPressCancelledBlock) {
        self.buttonPressCancelledBlock(self);
    }
}

-(void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = MIN(rect.size.height, rect.size.width)/2;
    
    [self addSubview:self.buttonIcon];
}

-(VBFPopFlatButton *)buttonIcon {
    if (!_buttonIcon) {
        _buttonIcon = [[VBFPopFlatButton alloc] initWithFrame:[self calculateButtonFrameWithContainerFrame:self.bounds] buttonType:buttonMenuType buttonStyle:buttonPlainStyle animateToInitialState:self.animateMenuButtonIconToInitialState];
        _buttonIcon.tintColor = self.tintColor;
        _buttonIcon.lineThickness = 1;
        
        [_buttonIcon addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchDown];
        [_buttonIcon addTarget:self action:@selector(buttonPressFinished:) forControlEvents:UIControlEventTouchUpInside];
        [_buttonIcon addTarget:self action:@selector(buttonPressCancelled:) forControlEvents:UIControlEventTouchUpOutside | UIControlEventTouchCancel];
    }
    
    return _buttonIcon;
}

-(void)tintColorDidChange {
    _buttonIcon.tintColor = self.tintColor;
}

-(CGRect)calculateButtonFrameWithContainerFrame:(CGRect)frame {
    CGFloat width = frame.size.width * self.menuIconSizePercentage;
    CGFloat height = frame.size.height * self.menuIconSizePercentage;
    
    CGFloat x = CGRectGetMidX(frame) - width / 2;
    CGFloat y = CGRectGetMidY(frame) - height / 2;
    
    return CGRectMake(x, y, width, height);
}

@end
