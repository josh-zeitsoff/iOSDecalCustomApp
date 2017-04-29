//
//  CodeScannerViewController.swift
//  iOSDecalCustomApp
//
//  Created by Joshua Zeitsoff on 4/5/17.
//  Copyright © 2017 Cathy Pham Le. All rights reserved.
//

import UIKit
import Firebase
import AVFoundation

class CodeScannerViewController: UIViewController, AVCapturePhotoCaptureDelegate {

    @IBOutlet weak var scanButton: UIButton!
    @IBOutlet weak var CameraImageView: UIImageView!
   
    @IBAction func scan(_ sender: UIButton) {
        let settingsForMonitoring = AVCapturePhotoSettings()
        settingsForMonitoring.isAutoStillImageStabilizationEnabled = true
        settingsForMonitoring.isHighResolutionPhotoEnabled = false
        photoOutput.capturePhoto(with: settingsForMonitoring, delegate: self)
        performSegue(withIdentifier: "unwindToMyEvent", sender: self)
    }
    
    var selectedImage = UIImage()
    let captureSession = AVCaptureSession()
    var captureDevice : AVCaptureDevice?
    var previewLayer : AVCaptureVideoPreviewLayer?
    let photoOutput = AVCapturePhotoOutput()
    
    func selectImage(_ image: UIImage) {
        selectedImage = image
    }
    override func viewDidLoad() {
        captureNewSession(devicePosition: AVCaptureDevicePosition.front)
        super.viewDidLoad()

    }
    
    func captureNewSession(devicePosition: AVCaptureDevicePosition) {
        
        if let inputs = captureSession.inputs as? [AVCaptureDeviceInput] {
            for input in inputs {
                captureSession.removeInput(input)
            }
        }
        
        captureSession.stopRunning()
        
        captureSession.sessionPreset = AVCaptureSessionPresetHigh
        
        if let deviceDiscoverySession = AVCaptureDeviceDiscoverySession.init(deviceTypes: [AVCaptureDeviceType.builtInWideAngleCamera], mediaType: AVMediaTypeVideo, position: AVCaptureDevicePosition.unspecified) {
            
            for device in deviceDiscoverySession.devices {
                if (device.hasMediaType(AVMediaTypeVideo)) {
                    if (device.position == devicePosition) {
                        captureDevice = device
                        if captureDevice != nil {
                            do {
                                try captureSession.addInput(AVCaptureDeviceInput(device: captureDevice))
                                
                                if captureSession.canAddOutput(photoOutput) {
                                    captureSession.addOutput(photoOutput)
                                }
                            }
                            catch {
                                print("error: \(error.localizedDescription)")
                            }
                            
                            if let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession) {
                                view.layer.addSublayer(previewLayer)
                                previewLayer.frame = view.layer.frame
                                captureSession.startRunning()
                                
                            }
                        }
                    }
                }
            }
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func capture(_ captureOutput: AVCapturePhotoOutput, didFinishProcessingPhotoSampleBuffer photoSampleBuffer: CMSampleBuffer?, previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {
        if let photoSampleBuffer = photoSampleBuffer {
            // students need to add write this part
            let photoData = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: photoSampleBuffer, previewPhotoSampleBuffer: previewPhotoSampleBuffer)
            selectedImage = UIImage(data: photoData!)!
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

}
