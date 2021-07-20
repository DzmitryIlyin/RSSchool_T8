//
//  NSString+EnumParser.h
//  RSSchool_T8
//
//  Created by dzmitry ilyin on 7/20/21.
//

#import <Foundation/Foundation.h>
#import "Shapes.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSString (EnumParser)
- (ShapeType)shapeTypeEnumFromString;
@end

NS_ASSUME_NONNULL_END
