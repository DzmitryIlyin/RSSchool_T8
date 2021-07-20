//
//  ArtistViewController.m
//  RSSchool_T8
//
//  Created by dzmitry ilyin on 7/16/21.
//

#import "ArtistViewController.h"
#import "RSSchool_T8-Swift.h"
#import "OpenPaletteViewController.h"
#import "CanvasView.h"
#import "NSString+EnumParser.h"
#import "ArtistButton.h"

@interface ArtistViewController ()
@property(nonatomic, strong)CanvasView *canvasView;
@end

@implementation ArtistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [[NSUserDefaults standardUserDefaults]setValue:@"Head" forKey:@"selected_drawing"];
    [self setUpCanvas];
    [self setUpButtons];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setUpTopBarItems];
}

- (void)setUpTopBarItems
{
    UILabel *title = [[UILabel alloc] init];
    title.text = @"Artist";
    title.font = [UIFont fontWithName:@"Montserrat-Regular" size:17.0];
    self.navigationItem.titleView = title;
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithTitle:@"Drawings" style: UIBarButtonItemStylePlain target:self action:@selector(drawingHanler:)];
        
    NSDictionary *dict = @{
        NSFontAttributeName:[UIFont fontWithName:@"Montserrat-Regular" size:17.0],
        NSForegroundColorAttributeName: [UIColor colorNamed:@"Light Green Sea"]
    };
    
    [barButton setTitleTextAttributes:dict forState:UIControlStateNormal];
    [barButton setTitleTextAttributes:dict forState:UIControlStateHighlighted];
    
    self.navigationItem.rightBarButtonItems = @[barButton];
}

- (void)drawingHanler:(id)sender
{
    DrawingsViewController *drawingsViewController = [DrawingsViewController new];
    drawingsViewController.delegate = (id<DrawingsViewControllerDelegate>)self;
    [self.navigationController pushViewController:drawingsViewController animated:YES];
}

- (void)backToRootTapped:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)setUpCanvas
{
    [_canvasView removeFromSuperview];
    NSString *selectedDrawing = [[NSUserDefaults standardUserDefaults] stringForKey:@"selected_drawing"];
    ShapeType shapeType = selectedDrawing != nil ? [selectedDrawing shapeTypeEnumFromString] : Head;
    _canvasView = [[CanvasView alloc] initWithFrame:CGRectMake(38.0, 104.0, 300.0, 300.0) andShapeType:shapeType];
    [self.view addSubview:_canvasView];
}

- (void)setUpButtons
{
    [self createButton:@"Open Palette" withOrigin:CGPointMake(20.0, 454.0) withLeftRightPadding:21.0 andWithTopBottmPadding:5.0];
    
    [self createButton:@"Open Timer" withOrigin:CGPointMake(20.0, 506.0) withLeftRightPadding:21.0 andWithTopBottmPadding:5.0];
    
    [self createButton:@"Draw" withOrigin:CGPointMake(243.0, 454.0) withLeftRightPadding:21.0 andWithTopBottmPadding:5.0];
    
    [self createButton:@"Share" withOrigin:CGPointMake(239.0, 506.0) withLeftRightPadding:21.0 andWithTopBottmPadding:5.0];
}

- (void)createButton:(NSString*)title withOrigin:(CGPoint)origin withLeftRightPadding:(float)leftRightPadding andWithTopBottmPadding:(float)topBottmPadding
{
    CGSize titleSize = [title sizeWithAttributes:@{
        NSFontAttributeName:[UIFont fontWithName:@"Montserrat-Medium" size:18.0],
    }];
    ArtistButton *button = [[ArtistButton alloc]initWithFrame:CGRectMake(origin.x, origin.y, titleSize.width + leftRightPadding * 2.0, titleSize.height + topBottmPadding * 2.0)];
    
    if ([title isEqual:@"Share"]) {
        [button setEnabled:NO];
        [button.layer setOpacity:0.5f];
    }

    [button setTitle:title forState:UIControlStateNormal];

    SEL sel = NSSelectorFromString([[NSString stringWithFormat:@"handle%@:", title] stringByReplacingOccurrencesOfString:@" " withString:@""]);
    
    [button addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
}

- (void)handleOpenPalette:(id)sender
{
    OpenPaletteViewController *paletteViewController = [OpenPaletteViewController new];
    paletteViewController.delegate = (id<OpenPaletteViewControllerDelegate>)self;
    [self addChildViewController:paletteViewController];
    
    paletteViewController.view.frame = CGRectMake(0.0, 333.5, 375.0, 375.0);
    [paletteViewController.view.layer setCornerRadius:40.0f];
    [self applyDropShadow:paletteViewController.view];
    
    [self.view addSubview: paletteViewController.view];
    [paletteViewController didMoveToParentViewController:self];
}

- (void)handleOpenTimer:(id)sender
{
    TimerViewController *viewController = [TimerViewController new];
    [self addChildViewController:viewController];
    
    viewController.view.frame = CGRectMake(0.0, 333.5, 375.0, 375.0);
    [viewController.view.layer setCornerRadius:40.0f];
    [self applyDropShadow:viewController.view];
    
    [self.view addSubview: viewController.view];
    [viewController didMoveToParentViewController:self];
}

-(void)handleDraw:(UIButton*)sender
{
    [self setUpCanvas];
    
    if ([sender.titleLabel.text isEqual: @"Draw"]) {
        [sender setTitle:@"Reset" forState:UIControlStateNormal];
        [sender.layer setOpacity:0.5f];
        float sliderValue = (float)[[NSUserDefaults standardUserDefaults] floatForKey:@"slider_value"];
        float timerValue = sliderValue != 0 ? sliderValue : 1.0;
        [_canvasView drawShapeWithTimer:timerValue];
    } else {
        [sender setTitle:@"Draw" forState:UIControlStateNormal];
        [sender.layer setOpacity:1.0f];
        
        for (UIButton *button in self.view.subviews)
        {
            if ([button isKindOfClass:[ArtistButton class]] && [button.titleLabel.text isEqual:@"Share"])
            {
                [button.layer setOpacity:0.5f];
                [button setEnabled:NO];
            }
        }
        
    }
}

- (void)handleShare:(id)sender
{
    UIImage *imageToShare = [_canvasView captureImageOfView];
    NSArray* dataToShare = @[imageToShare];
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc]initWithActivityItems:dataToShare applicationActivities:nil];
    activityViewController.popoverPresentationController.sourceView = self.view;
    [self presentViewController:activityViewController animated:YES completion:^{}];
}

- (void)applyDropShadow:(UIView *)view
{
    [view.layer setShadowColor: [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.25].CGColor];
    [view.layer setShadowOpacity:1.0];
    [view.layer setShadowOffset: CGSizeZero];
    [view.layer setShadowRadius: 4.0f];
}


@end
