//
//  OpenPaletteViewController.m
//  RSSchool_T8
//
//  Created by dzmitry ilyin on 7/18/21.
//

#import "OpenPaletteViewController.h"
#import "ArtistButton.h"

@interface OpenPaletteViewController () <UIGestureRecognizerDelegate>

@property(nonatomic, strong)NSMutableArray *selectedPallets;
@property(nonatomic, strong)NSTimer *timer;
@property(nonatomic, strong)UIColor *viewColor;

@end

@implementation OpenPaletteViewController

- (void)handleSaveButton:(id)sender
{
    [[NSUserDefaults standardUserDefaults] setObject:_selectedPallets forKey:@"selected_paletts"];
    NSMutableArray *colorValues = [NSMutableArray array];
    for (NSString *value in _selectedPallets)
    {
        int tag = (int)[value intValue];
        UIView *view = [self.view viewWithTag:tag];
        UIColor *color = view.backgroundColor;
        const CGFloat *components = CGColorGetComponents(color.CGColor);
        NSString *colorAsString = [NSString stringWithFormat:@"%f,%f,%f,%f", components[0], components[1], components[2], components[3]];
        [colorValues addObject:colorAsString];
    }
    [[NSUserDefaults standardUserDefaults] setObject:colorValues forKey:@"selected_colors"];

    [[NSUserDefaults standardUserDefaults] synchronize];
    
    id<OpenPaletteViewControllerDelegate> strongDelegate = self.delegate;
    if ([strongDelegate respondsToSelector:@selector(childViewController:)]) {
        [strongDelegate childViewController:self];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:UIColor.whiteColor];
    [self setUpButton];
    
    NSMutableArray *saved = [NSUserDefaults.standardUserDefaults objectForKey:@"selected_paletts"];
    _selectedPallets = saved != nil ? [saved mutableCopy] : [NSMutableArray array];
    
    [self setUpColors];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    [tapGestureRecognizer setCancelsTouchesInView: NO];
    tapGestureRecognizer.delegate = self;
}

- (void)handleTap:(UITapGestureRecognizer *)sender
{
    UIView* view = sender.view;
    CGPoint loc = [sender locationInView:view];
    UIView* subview = [view hitTest:loc withEvent:nil];
    
    if (![subview isKindOfClass:[ArtistButton class]] && ![subview.backgroundColor isEqual:[UIColor whiteColor]] &&
        subview != view)
    {
        if ([_selectedPallets containsObject: [@(subview.tag) stringValue]])
        {
            int index = (int)[_selectedPallets indexOfObject: [@(subview.tag) stringValue]];
            [self updateViewToInitialWithIndex:index];
        }
        
        if (_selectedPallets.count == 3) {
            [self updateViewToInitialWithIndex:0];
        }
        
        UIView *update = [self updateViewToSelected:subview];
        
        UIView *parentView = [subview superview];
        [subview removeFromSuperview];
        [parentView addSubview:update];
        
        if (![_timer isValid]) {
            view.backgroundColor = subview.backgroundColor;
            _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(unhiglightBackground) userInfo:nil repeats:NO];
        }
        
    }
}

- (void)unhiglightBackground
{
    self.view.backgroundColor = UIColor.whiteColor;
    [_timer invalidate];
    _timer = nil;
}

- (void)updateViewToInitialWithIndex:(int)index
{
    UIView *viewToDelete = [self.view viewWithTag:[[_selectedPallets objectAtIndex:index] intValue]];
    UIView *viewToReplace = [self createInitialInnerView];
    [viewToReplace setTag:viewToDelete.tag];
    [viewToReplace setBackgroundColor:viewToDelete.backgroundColor];
                                                    
    [_selectedPallets removeObjectAtIndex:index];
    
    UIView *parentView = [viewToDelete superview];
    [viewToDelete removeFromSuperview];
    [parentView addSubview:viewToReplace];
}

- (UIView *)updateViewToSelected:(UIView *)view
{
        
    UIView *updatedView;
    
    if (view.frame.origin.x == 2.0) {
        updatedView = [self createInitialInnerView];
    } else {
        updatedView = [self createSelectedInnerView];
        
        [_selectedPallets addObject: [@(view.tag) stringValue]];
    }
    
    [updatedView setBackgroundColor: view.backgroundColor];
    
    [updatedView setTag:view.tag];
    return updatedView;
}

- (void)setUpButton
{
    ArtistButton *saveButton = [[ArtistButton alloc]initWithFrame:CGRectMake(250.0, 20.0, 85.0, 32.0)];
    [saveButton addTarget:self action:@selector(handleSaveButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [saveButton setTitle:@"Save" forState:UIControlStateNormal];
    
    [self.view addSubview:saveButton];
}

- (void)setUpColors
{
    NSArray *colors = @[
        [UIColor colorWithRed:0.89 green:0.11 blue:0.17 alpha:1.0],
        [UIColor colorWithRed:0.24 green:0.09 blue:0.8 alpha:1.0],
        [UIColor colorWithRed:0.0 green:0.49 blue:0.22 alpha:1.0],
        [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0],
        [UIColor colorWithRed:0.62 green:0.37 blue:0.92 alpha:1.0],
        [UIColor colorWithRed:1.0 green:0.48 blue:0.41 alpha:1.0],
        [UIColor colorWithRed:1.0 green:0.68 blue:0.33 alpha:1.0],
        [UIColor colorWithRed:0.0 green:0.68 blue:0.93 alpha:1.0],
        [UIColor colorWithRed:1.0 green:0.47 blue:0.64 alpha:1.0],
        [UIColor colorWithRed:0.0 green:0.18 blue:0.24 alpha:1.0],
        [UIColor colorWithRed:0.05 green:0.22 blue:0.09 alpha:1.0],
        [UIColor colorWithRed:0.38 green:0.06 blue:0.06 alpha:1.0],
    ];
    
    int axisX = 17.0;
    int axisY = 92.0;
    
    for (int i=0; i<colors.count; i++)
    {
        
        if (axisX > self.view.frame.size.width) {
            axisX = 17.0;
            axisY = 152.0;
        }
        
        UIView *outerView = [[UIView alloc]initWithFrame:CGRectMake(axisX, axisY, 40.0, 40.0)];
        [outerView setUserInteractionEnabled:YES];
        [outerView setBackgroundColor:UIColor.whiteColor];
        [outerView.layer setCornerRadius:10.0f];
        [self applyDropShadow:outerView];
        
        UIView *innerView;
        if ([_selectedPallets containsObject:[@(100+i) stringValue]]) {
            innerView = [self createSelectedInnerView];
        } else {
            innerView = [self createInitialInnerView];
        }
        
        [innerView setBackgroundColor:colors[i]];
        [innerView setTag:100+i];
        [outerView addSubview:innerView];
        
        axisX += 60;
        
        [self.view addSubview:outerView];
    }
}

- (UIView *)createInitialInnerView
{
    UIView *innerView = [[UIView alloc]init];
    [innerView setUserInteractionEnabled:YES];
    [innerView setFrame:CGRectMake(8.0, 8.0, 24.0, 24.0)];
    [innerView.layer setCornerRadius:6.0f];
    return innerView;
}

- (UIView *)createSelectedInnerView
{
    UIView *innerView = [[UIView alloc]init];
    [innerView setUserInteractionEnabled:YES];
    [innerView setFrame:CGRectMake(2.0, 2.0, 36.0, 36.0)];
    [innerView.layer setCornerRadius:7.0f];
    return innerView;
}

- (void)applyDropShadow:(UIView *)view
{
    [view.layer setShadowColor: [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.25].CGColor];
    [view.layer setShadowOpacity:1.0];
    [view.layer setShadowOffset: CGSizeZero];
    [view.layer setShadowRadius: 4.0f];
}

@end
