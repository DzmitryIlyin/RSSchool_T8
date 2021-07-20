//
//  CanvasView.h
//  RSSchool_T8
//
//  Created by dzmitry ilyin on 7/19/21.
//

#import <UIKit/UIKit.h>
#import "Shapes.h"

NS_ASSUME_NONNULL_BEGIN

@interface CanvasView : UIView

-(instancetype)initWithFrame:(CGRect)frame andShapeType:(ShapeType)shapeType;
- (void)drawShapeWithTimer:(float)timeInterval;
-(UIImage*)captureImageOfView;

@end

NS_ASSUME_NONNULL_END
