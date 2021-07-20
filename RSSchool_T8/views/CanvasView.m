//
//  CanvasView.m
//  RSSchool_T8
//
//  Created by dzmitry ilyin on 7/19/21.
//

#import "CanvasView.h"
#import "TreeCALayer.h"
#import "HeadCALayer.h"
#import "LandscapeCALayer.h"
#import "PlanetCALayer.h"
#import "ArtistButton.h"

@interface CanvasView()
@property(nonatomic, strong)NSTimer *timer;
@property(nonatomic, assign)float timeInterval;
@property(nonatomic, assign)ShapeType currentShape;
@end

@implementation CanvasView

+(Class)layerClass{
    return [CAShapeLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame andShapeType:(ShapeType)shapeType
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.layer setCornerRadius:8.0f];
        [self setBackgroundColor: UIColor.whiteColor];
        [self.layer setShadowColor:[UIColor colorNamed:@"Chill Sky"].CGColor];
        [self.layer setShadowOpacity:0.25];
        [self.layer setShadowOffset: CGSizeZero];
        [self.layer setShadowRadius: 8.0f];
        ((CAShapeLayer*)self.layer).fillColor = UIColor.clearColor.CGColor;
        CALayer *shape = [self getShape:shapeType];
        self.layer.sublayers = shape.sublayers;
        _currentShape = shapeType;
    }
    return self;
}

-(CALayer*)getShape:(ShapeType)shapeType
{
    switch (shapeType) {
        case Tree:
            return [[TreeCALayer alloc] init];
            break;
        case Head:
            return [[HeadCALayer alloc] init];
            break;
        case Landscape:
            return [[LandscapeCALayer alloc] init];
            break;
        case Planet:
            return [[PlanetCALayer alloc] init];
            break;
    }
}

- (void)drawShapeWithTimer:(float)timeInterval
{
    _timeInterval = timeInterval;
    _timer = [NSTimer scheduledTimerWithTimeInterval:(NSTimeInterval)((1.0 / 60.0)) target:self selector:@selector(shapeAnimation:) userInfo:nil repeats:TRUE];
}

- (void)shapeAnimation:(int)timeInterval
{
    if ( ((CAShapeLayer*)self.layer.sublayers[0]).strokeEnd < 1.0) {
        for (int i=0; i < 3; i++) {
            ((CAShapeLayer*)self.layer.sublayers[i]).strokeEnd += 1.0/(60.0 * _timeInterval);
        }
    } else {
        if (_currentShape == Tree) {
            CAShapeLayer *leafsLayer = ((CAShapeLayer*)((CAShapeLayer*)self.layer).sublayers[0]);
            [leafsLayer setFillColor:leafsLayer.strokeColor];
        }
        [_timer invalidate];
        _timer = nil;
        for (UIButton *button in self.superview.subviews)
        {
            if ([button isKindOfClass:[ArtistButton class]] && [button.titleLabel.text isEqual:@"Reset"])
            {
                [button.layer setOpacity:1.0f];
            }
            
            if ([button isKindOfClass:[ArtistButton class]] && [button.titleLabel.text isEqual:@"Share"])
            {
                [button setEnabled:YES];
                [button.layer setOpacity:1.0f];
            }
        }
    }
}

- (UIImage *)captureImageOfView
{

    UIGraphicsBeginImageContext(self.bounds.size);

    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *anImage = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();

    return anImage;


}


@end
