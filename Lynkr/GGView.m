#import "GGView.h"
#import "GGDraggableView.h"


@interface GGView ()
@end

@implementation GGView

- (id)init
{
    self = [super init];
    if (!self) return nil;

    self.backgroundColor = [UIColor whiteColor];

    [self loadDraggableCustomView];

    return self;
}

- (void)loadDraggableCustomView
{
    self.draggableView = [[GGDraggableView alloc] initWithFrame:CGRectMake(30, 95, 260, 330)];

    [self addSubview:self.draggableView];
}

@end