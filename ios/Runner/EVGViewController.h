
#import <UIKit/UIKit.h>
#include <sys/cdefs.h>
#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>
#import <Evergage/Evergage.h>

@interface EVGViewController:FlutterViewController

@property EVGCampaign *campaign;

- (void)viewWillAppear:(BOOL)animated;

@end
