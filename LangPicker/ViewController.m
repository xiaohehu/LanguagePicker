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
{
    UIButton        *uib_setting;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateLanguage) name:@"finishedLang" object:nil];
    
    /*
     * Check current language setting
     */
    [TSLanguageManager setSelectedLanguage:kLMDefaultLanguage];
    NSString *language = [NSString new];
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"HasLaunchedOnce"]) {
        language = [[NSUserDefaults standardUserDefaults] objectForKey:@"language"];
    }
    if ([language isEqualToString:@"zh"]) {
        [TSLanguageManager setSelectedLanguage:kLMChinese];
    }
    if ([language isEqualToString:@"en"]) {
        [TSLanguageManager setSelectedLanguage:kLMEnglish];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [self performSelector:@selector(loadLanguagePicker) withObject:nil afterDelay:1.0];
    [self performSelector:@selector(loadSettingBtn) withObject:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{

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

- (void)updateLanguage
{
    NSLog(@"new language is set");
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"HasLaunchedOnce"]) {
        [self loadAgreement];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"HasLaunchedOnce"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else
    {
        [self dismissViewControllerAnimated:YES completion:^(void){ }];
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
        uib_setting = [UIButton buttonWithType: UIButtonTypeCustom];
        uib_setting.frame = CGRectMake(50.0, 668, 50, 50);
        uib_setting.backgroundColor = [UIColor clearColor];
        [uib_setting addTarget:self action:@selector(tapSettingBtn:) forControlEvents:UIControlEventTouchUpInside];
        [uib_setting setImage:[UIImage imageNamed:@"gear_icon.png"] forState:UIControlStateNormal];
        [self.view addSubview: uib_setting];
    }
    else
    {
        return;
    }
}

- (void)tapSettingBtn:(id)sender
{
    SettingViewController *setting = [[SettingViewController alloc] init];
    setting.view.frame = self.view.bounds;
    [self presentViewController:setting animated:YES completion:^(void){    }];
}

@end
