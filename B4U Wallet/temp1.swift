//
//  temp1.swift
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
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
        
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
    
    
    //Session starts and preview appears:
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
            
            var deviceOrientation: UIDeviceOrientation
            deviceOrientation = currentDevice.orientation
            
            //variables to set the orientation as parameter like "portrait" and as rawValue like the integer 0 for portrait mode
            var avCaptureOrientation: AVCaptureVideoOrientation
            avCaptureOrientation = .portrait
            
            var orientationValue: Int
            orientationValue = 0
            
            if deviceOrientation == .portrait {
                avCaptureOrientation = .portrait
                orientationValue = 0
                print("Device: Portrait")
            }else if (deviceOrientation == .landscapeLeft){
                avCaptureOrientation = .landscapeLeft
                orientationValue = 3
                print("Device: LandscapeLeft")
            }else if (deviceOrientation == .landscapeRight){
                avCaptureOrientation = .landscapeRight
                orientationValue = 2
                print("Device LandscapeRight")
            }else if (deviceOrientation == .portraitUpsideDown){
                avCaptureOrientation = .portraitUpsideDown
                orientationValue = 1
                print("Device PortraitUpsideDown")
            }else{
                print("Unknown Device Orientation")
            }
            
            stillImageOutput.captureStillImageAsynchronously(from: videoConnection, completionHandler: {(imageDataSampleBuffer, error) in
                let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(imageDataSampleBuffer)
                
                let image = UIImage(data: imageData!)
                self.imageProcessed = image!
                //In this print command always "3" appears
                print("Metadata Orientation: \(image!.imageOrientation.rawValue)")
                //in this view the orientation is correct but later when I use the picture to display it in an imageView it is wrong
                self.cameraView.backgroundColor = UIColor(patternImage: image!)
                
                self.captureSession.stopRunning()
            })
        }
}
