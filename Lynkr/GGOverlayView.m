#import "GGOverlayView.h"

@interface GGOverlayView ()
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation GGOverlayView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) return nil;

    self.backgroundColor = [UIColor whiteColor];
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Rejected"]];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.imageView];

    return self;
}

- (void)setMode:(GGOverlayViewMode)mode
{
    if (_mode == mode) return;

    _mode = mode;
    if (mode == GGOverlayViewModeLeft) {
        self.imageView.image = [UIImage imageNamed:@"Rejected"];
    } else {
        self.imageView.image = [UIImage imageNamed:@"Accepted"];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(10, 65, 240, 240);
}

@end