//
//  BearUINavigationController.m
//

#import "BearUINavigationController.h"
#import "UIImage-Helpers.h"

#define DEFAULT_NAV_BG_COLOR           [UIColor colorWithRed:0.09 green:0.09 blue:0.09 alpha:1]

@interface BearUINavigationController ()

- (UIBarButtonItem *)createBackBarButonItem;
- (void)popSelf;

@end

@implementation BearUINavigationController

- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        _isCustomNavBar = YES;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (_isCustomNavBar) {
        [self setNavigationBarHidden:YES animated:NO];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initNavigationBar];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return [self.topViewController preferredStatusBarStyle];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)initNavigationBar
{
    NSDictionary* attrs =  @{ NSForegroundColorAttributeName:[UIColor whiteColor],
                              NSFontAttributeName:[UIFont boldSystemFontOfSize:20],
                              NSShadowAttributeName:[[NSShadow alloc] init]
                              };
    [self.navigationBar setTitleTextAttributes:attrs];
    
    [self.navigationBar setBackgroundImage:[UIImage imageWithColor:DEFAULT_NAV_BG_COLOR] forBarMetrics:UIBarMetricsDefault];
}

#pragma mark - 自定义返回按钮

- (void)popSelf
{
    [self popViewControllerAnimated:YES];
}

- (UIBarButtonItem *)createBackBarButonItem
{
    UIButton * backBarButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 74/3.0, 74/3.0)];
    [backBarButton setImage:[UIImage imageNamed:@"left"]
                   forState:UIControlStateNormal];
    [backBarButton setImage:[UIImage imageNamed:@"left"]
                   forState:UIControlStateHighlighted];
    
    [backBarButton addTarget:self
                      action:@selector(popSelf)
            forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBarButton];
    backBarButtonItem.style = UIBarButtonItemStylePlain;
    
    return backBarButtonItem;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];
    
    [viewController didMoveToParentViewController:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
