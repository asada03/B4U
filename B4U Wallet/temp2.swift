//
//  temp2.swift
//  B4U Wallet
//
//  Created by Andres Luis Sada Govela on 05/03/18.
//  Copyright © 2018 Andres Luis Sada Govela. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import Photos

class ViewController: UIViewController {
    
    @IBOutlet weak var cameraView: UIView!
    
    @IBOutlet weak var imageProcessedView: UIImageView!
    var imageProcessed: UIImage?
    let captureSession = AVCaptureSession()
    var captureDevice: AVCaptureDevice?
    var previewLayer: AVCaptureVideoPreviewLayer?
    var stillImageOutput: AVCaptureStillImageOutput = AVCaptureStillImageOutput()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageProcessedView.alpha = 1.0
        captureSession.sessionPreset = AVCaptureSessionPresetPhoto
        backCamera()
    }
    
    
    
    func backCamera()
    {
        let devices = AVCaptureDevice.devices()
        
        for device in devices! {
            if ((device as AnyObject).hasMediaType(AVMediaTypeVideo)){
                captureDevice = device as? AVCaptureDevice
                do {
                    try captureSession.addInput(AVCaptureDeviceInput(device: captureDevice))
                } catch {
                    print("error")
                }
                break
            }
        }
    }
    
    
    
    @IBAction func takePhoto(_ sender: Any) {
        if captureDevice != nil
        {
            imageProcessedView.alpha = 0.0
            previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            self.cameraView.layer.addSublayer(previewLayer!)
            previewLayer?.frame = self.cameraView.layer.bounds
            previewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
            captureSession.startRunning()
            stillImageOutput.outputSettings = [AVVideoCodecKey: AVVideoCodecJPEG]
            
            if captureSession.canAddOutput(stillImageOutput){
                captureSession.addOutput(stillImageOutput)
            }
        }else{
            print("No captureDevice")
        }
        
    }
    
    @IBAction func capturePicture(_ sender: Any) {
        if let videoConnection = stillImageOutput.connection(withMediaType: AVMediaTypeVideo){
            
            var currentDevice: UIDevice
            currentDevice = .current
            UIDevice.current.beginGeneratingDeviceOrientationNotifications()
            var deviceOrientation: UIDeviceOrientation
            deviceOrientation = currentDevice.orientation
            
            var imageOrientation: UIImageOrientation?
            
            if deviceOrientation == .portrait {
                imageOrientation = .up
                print("Device: Portrait")
            }else if (deviceOrientation == .landscapeLeft){
                imageOrientation = .left
                print("Device: LandscapeLeft")
            }else if (deviceOrientation == .landscapeRight){
                imageOrientation = .right
                print("Device LandscapeRight")
            }else if (deviceOrientation == .portraitUpsideDown){
                imageOrientation = .down
                print("Device PortraitUpsideDown")
            }else{
                print("Unknown Device Orientation")
            }
            stillImageOutput.captureStillImageAsynchronously(from: videoConnection, completionHandler: {(imageDataSampleBuffer, error) in
                let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(imageDataSampleBuffer)
                let dataProvider  = CGDataProvider(data: imageData! as CFData)
                let cgImageRef = CGImage(jpegDataProviderSource: dataProvider!, decode: nil, shouldInterpolate: true, intent: CGColorRenderingIntent.defaultIntent )
                self.imageProcessed = UIImage(cgImage: cgImageRef!, scale: 1.0, orientation: imageOrientation!)
                //print("Image Orientation: \(self.imageProcessed?.imageOrientation.rawValue)")
                print("ImageO: \(imageOrientation!.rawValue)")
                
                self.cameraView.backgroundColor = UIColor(patternImage: self.imageProcessed!)
                
                self.captureSession.stopRunning()
            })
        }
    }
    
    
    @IBAction func focusAndExposeTap(_ gestureRecognizer: UITapGestureRecognizer) {
        let devicePoint = self.previewLayer?.captureDevicePointOfInterest(for: gestureRecognizer.location(in: gestureRecognizer.view))
        focus(with: .autoFocus, exposureMode: .autoExpose, at: devicePoint!, monitorSubjectAreaChange: true)
    }
    
    private func focus(with focusMode: AVCaptureFocusMode, exposureMode: AVCaptureExposureMode, at devicePoint: CGPoint, monitorSubjectAreaChange: Bool)
    {
        if let device = captureDevice
        {
            do{
                try device.lockForConfiguration()
                if device.isFocusPointOfInterestSupported && device.isFocusModeSupported(focusMode)
                {
                    device.focusPointOfInterest = devicePoint
                    device.focusMode = focusMode
                }
                if device.isExposurePointOfInterestSupported && device.isExposureModeSupported(exposureMode)
                {
                    device.exposurePointOfInterest = devicePoint
                    device.exposureMode = exposureMode
                }
                device.isSubjectAreaChangeMonitoringEnabled = monitorSubjectAreaChange
                device.unlockForConfiguration()
            }catch{
                print("Could not lock device for configuration: \(error)")
            }
        }
    }
    
    
    @IBAction func showCirclesInPic(_ sender: Any) {
        if imageProcessed != nil {
            previewLayer!.removeFromSuperlayer()
            cameraView.addSubview(imageProcessedView)
            
            if (imageProcessed!.imageOrientation != .up){
                UIGraphicsBeginImageContextWithOptions(imageProcessed!.size, false, imageProcessed!.scale)
                imageProcessed!.draw(in: CGRect(x:0, y:0, width: imageProcessed!.size.width, height: imageProcessed!.size.height))
                imageProcessed = UIGraphicsGetImageFromCurrentImageContext()!
                UIGraphicsEndImageContext()
            }
            imageProcessedView.contentMode = .scaleAspectFit
            imageProcessedView.image = imageProcessed
            //print("ImageProcessed: \(ImageProcessingCV.showCircles(imageProcessed)!)")
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
