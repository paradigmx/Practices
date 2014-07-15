//
//  SuperPrimeViewController.m
//  Practices
//
//  Created by Neo on 7/8/14.
//  Copyright (c) 2014 Paradigm X. All rights reserved.
//

#import "SuperPrimeViewController.h"

#include <primesieve.h>

@interface SuperPrimeViewController ()
- (IBAction)compute:(id)sender;

@property (weak, nonatomic) IBOutlet UITextView *outputTextView;
@end

@implementation SuperPrimeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)compute:(id)sender {
    primesieve_iterator pi;
    primesieve_init(&pi);
    uint64_t sum = 0;
    uint64_t prime = 0;

    // iterate over the primes below 10^10
    while ((prime = primesieve_next_prime(&pi)) < 10000000000ull)
        sum += prime;
    primesieve_free_iterator(&pi);

    NSString *output = [NSString stringWithFormat:@"Sum of the primes below 10^10 = %llu\n", sum];

    [_outputTextView setText:output];
}

@end
