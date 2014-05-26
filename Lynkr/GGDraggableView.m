#import "GGDraggableView.h"
#import "GGOverlayView.h"

@interface GGDraggableView ()

@property(nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;

@end

@implementation GGDraggableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) return nil;

    self.panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragged:)];
    [self addGestureRecognizer:self.panGestureRecognizer];

    [self loadImageAndStyle];
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(42, 18, 176, 21)];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.nameLabel];
    self.logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(35, 44, 190, 128)];
    self.logoImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.logoImageView];
    self.pitchTextView = [[UITextView alloc] initWithFrame:CGRectMake(22, 198, 216, 110)];
    self.pitchTextView.editable = NO;
    [self addSubview:self.pitchTextView];
    self.locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(42, 329, 176, 21)];
    self.locationLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.locationLabel];
    
    self.overlayView = [[GGOverlayView alloc] initWithFrame:self.bounds];
    self.overlayView.alpha = 0;
    [self addSubview:self.overlayView];
    
    self.backgroundColor = [UIColor whiteColor];

    return self;
}

- (void)loadImageAndStyle
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bar"]];
    [self addSubview:imageView];
    self.layer.cornerRadius = 8;
    self.layer.shadowOffset = CGSizeMake(7, 7);
    self.layer.shadowRadius = 5;
    self.layer.shadowOpacity = 0.5;
}

- (void)dragged:(UIPanGestureRecognizer *)gestureRecognizer
{
    CGFloat xDistance = [gestureRecognizer translationInView:self].x;
    CGFloat yDistance = [gestureRecognizer translationInView:self].y;

    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:{
            self.originalPoint = self.center;
            break;
        };
        case UIGestureRecognizerStateChanged:{
            CGFloat rotationStrength = MIN(xDistance / 320, 1);
            CGFloat rotationAngel = (CGFloat) (2*M_PI/16 * rotationStrength);
            CGFloat scaleStrength = 1 - fabsf(rotationStrength) / 4;
            CGFloat scale = MAX(scaleStrength, 0.93);
            CGAffineTransform transform = CGAffineTransformMakeRotation(rotationAngel);
            CGAffineTransform scaleTransform = CGAffineTransformScale(transform, scale, scale);
            self.transform = scaleTransform;
            self.center = CGPointMake(self.originalPoint.x + xDistance, self.originalPoint.y + yDistance);

            [self updateOverlay:xDistance];

            break;
        };
        case UIGestureRecognizerStateEnded: {
            if (xDistance > 150)
            {
                [self slideRightViewPositionAndTransformations];
            }
            else if (xDistance < -150)
            {
                [self slideLeftViewPositionAndTransformations];
            }
            else
            {
                [self resetViewPositionAndTransformations];
            }
            break;
        };
        case UIGestureRecognizerStatePossible:break;
        case UIGestureRecognizerStateCancelled:break;
        case UIGestureRecognizerStateFailed:break;
    }
}

- (void)updateOverlay:(CGFloat)distance
{
    if (distance > 0) {
        self.overlayView.mode = GGOverlayViewModeRight;
    } else if (distance <= 0) {
        self.overlayView.mode = GGOverlayViewModeLeft;
    }
    CGFloat overlayStrength = MIN(fabsf(distance) / 100, 0.4);
    self.overlayView.alpha = overlayStrength;
}

- (void)resetViewPositionAndTransformations
{
    [UIView animateWithDuration:0.2
                     animations:^{
        self.center = self.originalPoint;
        self.transform = CGAffineTransformMakeRotation(0);
        self.overlayView.alpha = 0;
    }];
}

- (void)slideLeftViewPositionAndTransformations
{
    [UIView animateWithDuration:0.2
                     animations:^{
        self.center = CGPointMake(-300, self.center.y);
        self.overlayView.alpha = 0;
    }];
    
    [self.delegate cardDecided:NO];
}

- (void)slideRightViewPositionAndTransformations
{
    [UIView animateWithDuration:0.2
                     animations:^{
        self.center = CGPointMake(620, self.center.y);
        self.overlayView.alpha = 0;
    }];
    
    [self.delegate cardDecided:YES];
}

- (void)dealloc
{
    [self removeGestureRecognizer:self.panGestureRecognizer];
}

@end