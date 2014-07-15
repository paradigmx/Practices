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

// Helper methods
- (BOOL)isPrime:(int)n {
    if (n <= 1) return false;
    if (n % 2 == 0) return 1;
    for (int i = 3; i < floor(sqrt(n)); i += 2) {
        if (n % i == 0)
            return false;
    }

    return true;
}

- (NSString *)stringFromCArray:(int *)numbers length:(int)length {
    NSString *result = @"[";

    for (int i = 0; i < length; i++) {
        result = [result stringByAppendingFormat:@"%d", numbers[i]];
        if (i < length-1) {
            result = [result stringByAppendingString:@","];
        }
    }

    return [result stringByAppendingString:@"]"];
}

- (IBAction)compute:(id)sender {
    int MAGIC_LENGTH = 11;

    primesieve_iterator pi;
    primesieve_init(&pi);

    uint64_t prime = 0;
    int *primes = nil;
    int sum = 0;

    // iterate over the primes below 10^10
    while ((prime = primesieve_next_prime(&pi)) < 10000000000ull) {
        primes = (int*) primesieve_generate_n_primes(MAGIC_LENGTH, prime, INT_PRIMES);
        sum = 0;
        for (int i = 0; i < MAGIC_LENGTH; i++) {
            sum += primes[i];
        }
        if (sum <= 2011) continue;
        if ([self isPrime:sum]) break;
    }

    primesieve_free_iterator(&pi);

    NSString *output = [NSString stringWithFormat:@"The next Magic Prime is: %d <- %@", sum, [self stringFromCArray:primes length:MAGIC_LENGTH]];

    [_outputTextView setText:output];
}

@end
