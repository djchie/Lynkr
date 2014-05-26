//
// Created by guti on 1/17/14.
//
// No bugs for you!
//


#import <Foundation/Foundation.h>

@class GGOverlayView;

@protocol GGDraggableViewDelegate <NSObject>
@required

- (void)cardDecided:(bool)choice;

@end

@interface GGDraggableView : UIView

@property(nonatomic) CGPoint originalPoint;
@property(nonatomic, strong) GGOverlayView *overlayView;

@property (nonatomic, assign) id  delegate;
@property(nonatomic, strong) UILabel *nameLabel;
@property(nonatomic, strong) UIImageView *logoImageView;
@property(nonatomic, strong) UITextView *pitchTextView;
@property(nonatomic, strong) UILabel *locationLabel;

@end