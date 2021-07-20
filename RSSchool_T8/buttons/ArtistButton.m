//
//  ArtistButton.m
//  RSSchool_T8
//
//  Created by dzmitry ilyin on 7/20/21.
//

#import "ArtistButton.h"

@implementation ArtistButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.layer setCornerRadius:10.0f];
        [self setBackgroundColor: UIColor.whiteColor];
        
        [self.titleLabel setFont:[UIFont fontWithName:@"Montserrat-Medium" size:18.0]];
        [self setTitleColor:[UIColor colorNamed:@"Light Green Sea"] forState:UIControlStateNormal];
        
        [self.layer setShadowColor: [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.25].CGColor];
        [self.layer setShadowOpacity:1.0f];
        [self.layer setShadowOffset: CGSizeZero];
        [self.layer setShadowRadius: 1.0f];
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    
    if (highlighted && self.isEnabled) {
        [self.layer setShadowColor: [UIColor colorNamed:@"Light Green Sea"].CGColor];
    }
    else{
        [self.layer setShadowColor: [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.25].CGColor];
        
    }
}

@end
