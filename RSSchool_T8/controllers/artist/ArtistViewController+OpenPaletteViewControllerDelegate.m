//
//  ArtistViewController+OpenPaletteViewControllerDelegate.m
//  RSSchool_T8
//
//  Created by dzmitry ilyin on 7/19/21.
//

#import "ArtistViewController+OpenPaletteViewControllerDelegate.h"

@implementation ArtistViewController (OpenPaletteViewControllerDelegate)

- (void)childViewController:(nonnull OpenPaletteViewController *)viewController {
    [viewController willMoveToParentViewController:nil];
    [viewController.view removeFromSuperview];
    [viewController removeFromParentViewController];
}


- (void)drawingsWithViewController:(DrawingsViewController * _Nonnull)viewController {
    [self.navigationController popToRootViewControllerAnimated:NO];
}

@end
