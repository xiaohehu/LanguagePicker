//
//  ViewController.m
//  LangPicker
//
//  Created by Xiaohe Hu on 6/24/15.
//  Copyright (c) 2015 Xiaohe Hu. All rights reserved.
//

#import "ViewController.h"
#import "LangPickerViewController.h"
#import "AgreementViewController.h"
#import "SettingViewController.h"
#import "TSLanguageManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadAgreement) name:@"finishedLang" object:nil];
    [TSLanguageManager setSelectedLanguage:kLMDefaultLanguage];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self performSelector:@selector(loadLanguagePicker) withObject:nil afterDelay:1.0];
    [self performSelector:@selector(loadSettingBtn) withObject:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"HasLaunchedOnce"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadLanguagePicker
{
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"HasLaunchedOnce"]) {
        
        LangPickerViewController *picker = [[LangPickerViewController alloc] init];
        picker.view.frame = self.view.bounds;
        [self presentViewController:picker animated:YES completion:^{   }];
    }
}

- (void)loadAgreement
{
    NSString *langeType = [[NSUserDefaults standardUserDefaults] objectForKey:@"language"];
    NSLog(@"current lang. is %@", langeType);
    
    AgreementViewController *agreement = [[AgreementViewController alloc] init];
    agreement.view.frame = self.view.bounds;
    [self presentViewController:agreement animated:YES completion:^(void){  }];
}

- (void)loadSettingBtn
{
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"HasLaunchedOnce"])
    {
        SettingViewController *setting = [[SettingViewController alloc] init];
        setting.view.frame = self.view.bounds;
        [self presentViewController:setting animated:YES completion:^(void){    }];
    }
    else
    {
        return;
    }
}

@end
