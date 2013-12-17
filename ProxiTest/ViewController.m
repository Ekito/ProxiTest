//
//  ViewController.m
//  ProxiTest
//
//  Created by Arnaud Boudou on 28/11/2013.
//  Copyright (c) 2013 Arnaud Boudou. All rights reserved.
//

#import "ViewController.h"
#import "RFduino.h"

@interface ViewController ()

@end


@implementation ViewController

@synthesize rssiInst01, rssiMean01, progress01, last01;
@synthesize rssiInst02, rssiMean02, progress02, last02;
@synthesize rssiInst03, rssiMean03, progress03, last03;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    rfduinoManager = [RFduinoManager sharedRFduinoManager];
    
    rfduinoManager.delegate = self;
    
    _measures01 = [[NSMutableArray alloc] init];
    _measures02 = [[NSMutableArray alloc] init];
    _measures03 = [[NSMutableArray alloc] init];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    CGAffineTransform transform = CGAffineTransformMakeScale(1.0f, 5.0f);
    progress01.transform = transform;
    progress02.transform = transform;
    progress03.transform = transform;
}

#pragma mark - Misc

- (void) refresh:(RFduino *)rfduino withInstField:(UITextField*) instRssi andMeanField:(UITextField *) meanRssi andProgress:(UIProgressView*) progress andMeasures:(NSMutableArray *) measures andLastAdvert:(UITextField *) lastAdvert{

    instRssi.text = [NSString stringWithFormat:@"RSSI : %d dBm", rfduino.advertisementRSSI.intValue];
    lastAdvert.text = [NSString stringWithFormat:@"%@", rfduino.lastAdvertisement];
    
    if ([measures count] < 5) {
        [measures addObject:rfduino.advertisementRSSI];
    } else {
        
        if (rfduino.advertisementRSSI.intValue != 127) {
            [measures setObject:[measures objectAtIndex:1] atIndexedSubscript:0];
            [measures setObject:[measures objectAtIndex:2] atIndexedSubscript:1];
            [measures setObject:[measures objectAtIndex:3] atIndexedSubscript:2];
            [measures setObject:[measures objectAtIndex:4] atIndexedSubscript:3];
            [measures setObject:rfduino.advertisementRSSI atIndexedSubscript:4];
            
            
            int total = 0;
            for (NSNumber *value in measures) {
                total += value.intValue;
            }
            
            int mean = total/5;
            
            meanRssi.text = [NSString stringWithFormat:@"RSSI : %d dBm", mean];
            progress.progress = [self map:mean in_min:-100.0f in_max:-40.0f out_min:0.0f out_max:1.0f];
            
            
            UIColor *color = [[UIColor alloc] initWithRed:[self map:mean in_min:-40.0f in_max:-100.0f out_min:0.0f out_max:1.0f]
                                                    green:[self map:mean in_min:-40.0f in_max:-100.0f out_min:1.0f out_max:0.f]
                                                     blue:0.0f
                                                    alpha:255.0f];

            [progress setTintColor:color];
        }
    }
}

- (void) globalRefresh:(RFduino *)rfduino {
    if ([rfduino.UUID isEqualToString:@"BD3F96F5-A7BB-ADBA-C463-8241EC9DA84F"]) {
        [self refresh:rfduino withInstField:rssiInst01 andMeanField:rssiMean01 andProgress:progress01 andMeasures:_measures01 andLastAdvert:last01];
    } else if ([rfduino.UUID isEqualToString:@"51FB7F62-26BA-642F-A1A0-F2ACF673C3F5"]) {
        [self refresh:rfduino withInstField:rssiInst02 andMeanField:rssiMean02 andProgress:progress02 andMeasures:_measures02 andLastAdvert:last02];
    } else {
        [self refresh:rfduino withInstField:rssiInst03 andMeanField:rssiMean03 andProgress:progress03 andMeasures:_measures03 andLastAdvert:last03];
    }
}


-(float) map:(float)value in_min:(float)in_min  in_max:(float)in_max out_min:(float)out_min out_max:(float)out_max {
    return (value - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
}

#pragma mark - RfduinoDiscoveryDelegate methods

- (void)didDiscoverRFduino:(RFduino *)rfduino { }

- (void)didUpdateDiscoveredRFduino:(RFduino *)rfduino
{
//    NSLog(@"%@", rfduino.UUID);
    [self performSelectorOnMainThread:@selector(globalRefresh:) withObject:rfduino waitUntilDone:YES];

}

- (void)didConnectRFduino:(RFduino *)rfduino { }

- (void)didLoadServiceRFduino:(RFduino *)rfduino { }

- (void)didDisconnectRFduino:(RFduino *)rfduino { }

@end
