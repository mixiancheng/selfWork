//
//  ViewController.h
//  MyGame
//
//  Created by 米宪成 on 14-3-11.
//
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

- (IBAction)takePictureButtonClick:(id)sender;
- (IBAction)captureVideoButtonClick:(id)sender;

@end
