/*
 Copyright 2015-present Google Inc. All Rights Reserved.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import <XCTest/XCTest.h>

#import "MaterialSpritedAnimationView.h"

static NSString *const kSpriteList = @"mdc_sprite_list__grid";
static NSString *const kExpectationDescription = @"animatingWithCompletion";

@interface SpritedAnimationViewTests : XCTestCase

@end

@implementation SpritedAnimationViewTests

- (void)setUp {
  [super setUp];
}

- (void)tearDown {
  [super tearDown];
}

- (void)testAnimationCompletion {
  // Sprited animation view.
  UIImage *spriteImage = [UIImage imageNamed:kSpriteList];
  MDFSpritedAnimationView *animationView =
      [[MDFSpritedAnimationView alloc] initWithSpriteSheetImage:spriteImage];

  // Create expectation.
  XCTestExpectation *expectation = [self expectationWithDescription:kExpectationDescription];

  // Fulfill expectation after completion of animation.
  [animationView startAnimatingWithCompletion:^(BOOL completion) {
    [expectation fulfill];
  }];

  [self waitForExpectationsWithTimeout:1.0
                               handler:^(NSError *error) {
                                 XCTAssertEqual(error, nil);
                               }];
}

- (void)testAnimationPerformance {
  NSArray *metrics = [[self class] defaultPerformanceMetrics];
  [self measureMetrics:metrics
      automaticallyStartMeasuring:NO
                         forBlock:^{
                           [self startMeasuring];

                           // Sprited animation view.
                           UIImage *spriteImage = [UIImage imageNamed:kSpriteList];
                           MDFSpritedAnimationView *animationView =
                               [[MDFSpritedAnimationView alloc] initWithSpriteSheetImage:spriteImage];

                           // Create expectation.
                           XCTestExpectation *expectation = [self expectationWithDescription:kExpectationDescription];

                           // Fulfill expectation after completion of animation.
                           [animationView startAnimatingWithCompletion:^(BOOL finished) {
                               [expectation fulfill];
                           }];

                           [self waitForExpectationsWithTimeout:1.0
                                                        handler:^(NSError *error) {
                                                          [self stopMeasuring];
                                                        }];
                         }];
}

@end
