//
//  BearChoosePhotoManager.m
//  AFNetworking
//
//  Created by Chobits on 2017/11/15.
//

#import "BearChoosePhotoManager.h"

@interface BearChoosePhotoManager () <UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    UIViewController *_inVC;
}
@end

@implementation BearChoosePhotoManager

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        
    }
    
    return self;
}

- (void)showActionViewInVC:(UIViewController *)inVC
{
    NSAssert(inVC, @"请传入inVC");
    
    if (!inVC) {
        return;
    }
    _inVC = inVC;
    
    UIActionSheet *photoAS = [[UIActionSheet alloc] initWithTitle:nil
                                                         delegate:self
                                                cancelButtonTitle:@"取消"
                                           destructiveButtonTitle:nil
                                                otherButtonTitles:@"拍照", @"相册", nil];
    [photoAS showInView:inVC.view];
}

#pragma mark - UIActionSheet Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        [self presentCameraInVC:_inVC];
    }
    else if (buttonIndex == 1)
    {
        [self presentPhotoLibraryInVC:_inVC];
    }
}

- (void)presentCameraInVC:(UIViewController *)inVC
{
    _inVC = inVC;
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.modalTransitionStyle = UIModalPresentationPopover;
    imagePickerController.allowsEditing = YES;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    [inVC presentViewController:imagePickerController animated:YES completion:^{
    }];
}

- (void)presentPhotoLibraryInVC:(UIViewController *)inVC
{
    _inVC = inVC;
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.modalTransitionStyle = UIModalPresentationPopover;
    imagePickerController.allowsEditing = YES;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [inVC presentViewController:imagePickerController animated:YES completion:^{
    }];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = nil;
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera)
    {
        image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        UIImageWriteToSavedPhotosAlbum(image,self,
                                       @selector(image:didFinishSavingWithError:contextInfo:),
                                       nil);
    }
    image = [info objectForKey: @"UIImagePickerControllerEditedImage"];
    
    
    [_inVC dismissViewControllerAnimated:YES completion:^{
        if (image && self.selectedImageBlock) {
            self.selectedImageBlock(image);
        }
    }];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error != nil) {
        NSLog(@"Image Can not be saved");
    }
    else {
        NSLog(@"Successfully saved Image");
    }
}

@end
