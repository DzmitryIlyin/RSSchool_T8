//
//  OpenPaletteViewController.h
//  RSSchool_T8
//
//  Created by dzmitry ilyin on 7/18/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol OpenPaletteViewControllerDelegate;

@interface OpenPaletteViewController : UIViewController

@property (nonatomic, weak) id<OpenPaletteViewControllerDelegate> delegate;

- (void)handleSaveButton:(id)sender;

@end

@protocol OpenPaletteViewControllerDelegate <NSObject>

- (void)childViewController:(OpenPaletteViewController*)viewController;


@end

NS_ASSUME_NONNULL_END
