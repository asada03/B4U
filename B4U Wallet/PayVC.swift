//
//  PayVC.swift
//  B4U Wallet
//
//  Created by Andres Luis Sada Govela on 01/02/18.
//  Copyright © 2018 Andres Luis Sada Govela. All rights reserved.
//

import UIKit
import AVFoundation

class PayVC: UIViewController, AVCaptureMetadataOutputObjectsDelegate {

    @IBOutlet weak var codeScannerView: UIView!
    
    @IBOutlet weak var toPayTextField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var walletIdTextField: UITextField!
    
    @IBOutlet weak var scannerHeightConstraint: NSLayoutConstraint!
    var captureSession = AVCaptureSession()
    var videoPreviewLayer:AVCaptureVideoPreviewLayer!
    var qrCodeFrameView = UIView()

    var delegate: HashgraphMessages!
    var walletId = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = ""

        // Do any additional setup after loading the view.
        
        // Get the back-facing camera for capturing videos
        guard let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
            print("Failed to get the camera device")
            return
        }
        
        do {
            // Get an instance of the AVCaptureDeviceInput class using the previous device object.
            let input = try AVCaptureDeviceInput(device: captureDevice)
            
            // Set the input device on the capture session.
            captureSession.addInput(input)
            
            // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession.addOutput(captureMetadataOutput)
            
            // Set delegate and use the default dispatch queue to execute the call back
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.aztec]
            
        } catch {
            // If any error occurs, simply print it out and don't continue any more.
            print(error)
            return
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        
        print ("Frame:\(videoPreviewLayer.frame.width), \(videoPreviewLayer.frame.height)")
        videoPreviewLayer.frame = codeScannerView.layer.bounds
        codeScannerView.layer.addSublayer(videoPreviewLayer!)
        
        // Start video capture.
        captureSession.startRunning()
        
        qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
        qrCodeFrameView.layer.borderWidth = 2
        codeScannerView.addSubview(qrCodeFrameView)
        codeScannerView.bringSubview(toFront: qrCodeFrameView)


    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y = -keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0{
            self.view.frame.origin.y = 0
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK - AVCapture delegate
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        // Check if the metadataObjects array is not nil and it contains at least one object.
        if metadataObjects.count == 0 {
            //qrCodeFrameView?.frame = CGRect.zero
            //messageLabel.text = "No QR code is detected"
            return
        }
        
        // Get the metadata object.
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if metadataObj.type == AVMetadataObject.ObjectType.aztec {
            // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
            qrCodeFrameView.frame = barCodeObject!.bounds

            if metadataObj.stringValue != nil {
                print ("got string -\(metadataObj.stringValue!)- from code")
                let messageArray = metadataObj.stringValue?.components(separatedBy: "|")
                if messageArray != nil, messageArray!.count >= 2 {
                    walletIdTextField.text = messageArray![0]
                    nameLabel.text = messageArray![1]
                }
            }
            
            captureSession.stopRunning()
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Actions

    @IBAction func payButtonPressed(_ sender: UIButton) {
        self.view.endEditing(true)
        let message = "TF|\(walletId)|\(walletIdTextField!.text!)|\(toPayTextField!.text!)\n"
        let result = delegate!.messageToHashgraph(message)

        let resultArray = String(result[..<result.index(of: "\n")!]).components(separatedBy: "|")
        if resultArray.count >= 2 {
            if resultArray[0] == "TF" {
                delegate.setBalance(resultArray[1])
                nameLabel!.text = "Transferencia Exitosa"
            }
            else if resultArray[0] == "ER" {
                nameLabel!.text = resultArray[1]
            }
        }

    }
}
