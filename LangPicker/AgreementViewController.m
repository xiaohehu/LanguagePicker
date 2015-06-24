//
//  AgreementViewController.m
//  LangPicker
//
//  Created by Xiaohe Hu on 6/24/15.
//  Copyright (c) 2015 Xiaohe Hu. All rights reserved.
//

#import "AgreementViewController.h"
#import "TSLanguageManager.h"
@interface AgreementViewController ()

@end

@implementation AgreementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    [self loadLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadLabel
{
    UILabel *uil_agreement = [[UILabel alloc] initWithFrame:CGRectMake(262, 350, 500, 50)];
    uil_agreement.backgroundColor = [UIColor whiteColor];
    uil_agreement.textAlignment = NSTextAlignmentCenter;
    uil_agreement.textColor = [UIColor blackColor];
    [self.view addSubview: uil_agreement];
    
    UIButton *uib_agree = [UIButton buttonWithType:UIButtonTypeCustom];
    uib_agree.frame = CGRectMake(462, 600, 100, 50);
    uib_agree.backgroundColor = [UIColor whiteColor];
    uib_agree.titleLabel.textAlignment = NSTextAlignmentCenter;
    [uib_agree setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [uib_agree addTarget:self action:@selector(agreed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: uib_agree];
    
    uil_agreement.text = [TSLanguageManager localizedString:@"Agreement Title"];
    [uib_agree setTitle:[TSLanguageManager localizedString:@"Agreement Button"] forState:UIControlStateNormal];
}

- (void)agreed
{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"Agreed"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self dismissViewControllerAnimated:YES completion:^(void){     }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
