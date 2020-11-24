//
//  EVGViewController.m
//  Runner
//
//  Created by Mark Mukherjee on 21/11/20.
//
#import "EVGViewController.h"
#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>
#import <Evergage/Evergage.h>

@implementation EVGViewController:FlutterViewController
- (instancetype) init
{
    self = [super init];
    return self;
        
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    __weak typeof(self) weakSelf = self;
    EVGCampaignHandler handler = ^(EVGCampaign * __nonnull campaign) {
        // Safest to perform a single method/operation on weakSelf, which will simply be a no-op if weakSelf is nil:
        [weakSelf handleCampaign:campaign];
    };
    
    // The target string uniquely identifies the expected data schema - here, a featured product:
    //[self.evergageScreen setCampaignHandler:handler forTarget:@"cumulusFeaturedProduct"];
    
}

- (void)handleCampaign:(nonnull EVGCampaign *)campaign {
    self.campaign = campaign;
    NSString *featuredProductName = campaign.data[@"featuredProductName"];
}

@end


