#import "GGView.h"
#import "GGDraggableView.h"


@interface GGView ()
@end

@implementation GGView

- (id)init
{
    self = [super init];
    if (!self) return nil;

    [self loadDraggableCustomView];

    return self;
}

- (void)loadDraggableCustomView
{
    self.topDraggableView = [[GGDraggableView alloc] initWithFrame:CGRectMake(30, 95, 260, 370)];
    self.nextDraggableView = [[GGDraggableView alloc] initWithFrame:CGRectMake(30, 95, 260, 370)];

    [self addSubview:self.nextDraggableView];
    [self addSubview:self.topDraggableView];
    
}

@end