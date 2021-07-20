//
//  PlanetCALayer.m
//  RSSchool_T8
//
//  Created by dzmitry ilyin on 7/20/21.
//

#import "PlanetCALayer.h"

@interface PlanetCALayer()
@property(nonatomic, strong)NSMutableArray *colors;
@property(nonatomic, strong)CAShapeLayer *layer1;
@property(nonatomic, strong)CAShapeLayer *layer2;
@property(nonatomic, strong)CAShapeLayer *layer3;
@end

@implementation PlanetCALayer

- (instancetype)init
{
    self = [super init];
    if (self) {
        _colors = [NSMutableArray array];
        [self prepareColors];
        _layer1 = [self createSublayer:[PlanetShape getPath1]];
        [self addSublayer:_layer1];
        _layer2 = [self createSublayer:[PlanetShape getPath2]];
        [self addSublayer:_layer2];
        _layer3 = [self createSublayer:[PlanetShape getPath3]];
        [self addSublayer:_layer3];
    }
    return self;
}

-(CAShapeLayer*)createSublayer:(UIBezierPath*)path
{
    CAShapeLayer *layer = [CAShapeLayer new];
    [layer setFillColor: UIColor.clearColor.CGColor];
    layer.strokeColor = [self getRandomColor].CGColor;
    layer.strokeEnd = 0.0;
    layer.path = path.CGPath;
    layer.contentsGravity = kCAGravityResize;
    return layer;
}

-(UIColor*)getRandomColor
{
    NSUInteger i = arc4random_uniform((int)_colors.count);
    UIColor *color = [_colors objectAtIndex:i];
    [_colors removeObjectAtIndex:i];
    return color;
}

-(void)prepareColors
{
    NSMutableArray<NSString*> *stringColors = [[NSUserDefaults standardUserDefaults] objectForKey:@"selected_colors"];
    if (stringColors)
    {
        for (NSString *value in stringColors)
        {
            [_colors addObject:[self recreateColorFromString:value]];
        }
    }
    if (_colors.count < 3) {
        while (_colors.count < 3)
        {
            [_colors addObject:UIColor.blackColor];
        }
    }
}

-(UIColor *)recreateColorFromString:(NSString*)colorAsString
{
    NSArray *components = [colorAsString componentsSeparatedByString:@","];
    CGFloat r = [[components objectAtIndex:0] floatValue];
    CGFloat g = [[components objectAtIndex:1] floatValue];
    CGFloat b = [[components objectAtIndex:2] floatValue];
    CGFloat a = [[components objectAtIndex:3] floatValue];
    return [UIColor colorWithRed:r green:g blue:b alpha:a];
}

@end
