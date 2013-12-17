//
//  ViewController.h
//  ProxiTest
//
//  Created by Arnaud Boudou on 28/11/2013.
//  Copyright (c) 2013 Arnaud Boudou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RFduinoManagerDelegate.h"
#import "RfduinoManager.h"

@interface ViewController : UIViewController<RFduinoManagerDelegate> {
    RFduinoManager *rfduinoManager;
    NSTimer *_timer;
    NSMutableArray *_measures01;
    NSMutableArray *_measures02;
    NSMutableArray *_measures03;
}

@property(nonatomic, strong) IBOutlet UITextField *rssiMean01;
@property(nonatomic, strong) IBOutlet UITextField *rssiInst01;
@property(nonatomic, strong) IBOutlet UIProgressView *progress01;
@property(nonatomic, strong) IBOutlet UITextField *last01;

@property(nonatomic, strong) IBOutlet UITextField *rssiMean02;
@property(nonatomic, strong) IBOutlet UITextField *rssiInst02;
@property(nonatomic, strong) IBOutlet UIProgressView *progress02;
@property(nonatomic, strong) IBOutlet UITextField *last02;

@property(nonatomic, strong) IBOutlet UITextField *rssiMean03;
@property(nonatomic, strong) IBOutlet UITextField *rssiInst03;
@property(nonatomic, strong) IBOutlet UIProgressView *progress03;
@property(nonatomic, strong) IBOutlet UITextField *last03;

@end
