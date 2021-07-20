//
//  ArtistViewController+OpenPaletteViewControllerDelegate.h
//  RSSchool_T8
//
//  Created by dzmitry ilyin on 7/19/21.
//

#import "ArtistViewController.h"
#import "OpenPaletteViewController.h"
#import "RSSchool_T8-Swift.h"


NS_ASSUME_NONNULL_BEGIN

@interface ArtistViewController (OpenPaletteViewControllerDelegate) <OpenPaletteViewControllerDelegate, DrawingsViewControllerDelegate>

@end

NS_ASSUME_NONNULL_END
