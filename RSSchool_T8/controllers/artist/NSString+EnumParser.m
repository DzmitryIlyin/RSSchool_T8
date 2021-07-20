//
//  NSString+EnumParser.m
//  RSSchool_T8
//
//  Created by dzmitry ilyin on 7/20/21.
//

#import "NSString+EnumParser.h"

@implementation NSString (EnumParser)

- (ShapeType)shapeTypeEnumFromString
{
    NSDictionary<NSString*, NSNumber*> *shapes = @{
        @"Tree": @(Tree),
        @"Head": @(Head),
        @"Landscape": @(Landscape),
        @"Planet": @(Planet)
    };
    return (int)shapes[self].integerValue;
}

@end
