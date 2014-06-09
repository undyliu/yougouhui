//
//  ZKHSaleImageListController.m
//  ZheKouHu
//
//  Created by undyliu on 14-6-9.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHImageListPreviewController.h"
#import "ZKHImagePreviewController.h"


@implementation ZKHImageListPreviewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"图片浏览";
    
    if (!self.imageFiles || [self.imageFiles count] == 0) {
        return;
    }
    
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    self.pageController.dataSource = self;
    [[self.pageController view] setFrame:[[self view] bounds]];
    
    files = [[NSMutableArray alloc]initWithArray:self.imageFiles copyItems:YES];
    if (self.currentIndex > 0) {
        id file = [files[self.currentIndex] copy];
        
        [files removeObjectAtIndex:self.currentIndex];
        [files insertObject:file atIndex:0];
    }
    
    ZKHImagePreviewController *initialViewController = [self viewControllerAtIndex:0];
    
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:self.pageController];
    [[self view] addSubview:[self.pageController view]];
    [self.pageController didMoveToParentViewController:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (ZKHImagePreviewController *)viewControllerAtIndex:(NSUInteger)index {
    
    ZKHImagePreviewController *childViewController = [[ZKHImagePreviewController alloc] initWithNibName:@"ZKHImagePreviewController" bundle:nil];

    childViewController.imageFile = files[index];
    childViewController.index = index;
    
    return childViewController;
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(ZKHImagePreviewController *)viewController index];
    if (index == 0) {
        return nil;
    }
    
    index--;
    
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
   NSUInteger index = [(ZKHImagePreviewController *)viewController index];
    
    index++;
    
    if (index == [files count]) {
        return nil;
    }

    return [self viewControllerAtIndex:index];

}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return [files count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    // The selected item reflected in the page indicator.
    return 0;
}

@end
