//
//  CameraPreview.swift
//  Campus
//
//  Created by Rolando Rodriguez on 12/17/19.
//  Copyright © 2019 Rolando Rodriguez. All rights reserved.
//

//
//  CameraPreview.swift
//  SwiftCamera
//
//  Created by Rolando Rodriguez on 10/17/20.
//

import SwiftUI
import AVFoundation

struct CameraPreview: UIViewRepresentable {
    class VideoPreviewView: UIView {
        override class var layerClass: AnyClass {
            AVCaptureVideoPreviewLayer.self
        }
        
        // var videoPreviewLayer: AVCaptureVideoPreviewLayer
        var videoPreviewLayer: AVCaptureVideoPreviewLayer {
            return layer as! AVCaptureVideoPreviewLayer
        }
    }
    
    let session: AVCaptureSession
    let service: CameraService    // Added this to object init so that we can store the videoPreviewLayer in the CameraService (so that videoOrientation can be set when the AVCaptureSession is configured)
    
    func makeUIView(context: Context) -> VideoPreviewView {
        print("makeUIView() ")
        
        let view = VideoPreviewView()
        view.backgroundColor = .black
        
        view.videoPreviewLayer.cornerRadius = 0
        view.videoPreviewLayer.session = session
        
        view.videoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        
        // Provide a link to the videoCamerLayer to the CameraService object (so videoOrientation can be set later, after configuration)
        service.videoPreviewLayer = view.videoPreviewLayer
        
        // Trying to detect current device orienation...
        //print("Valid device orientation? \(UIDevice.current.orientation.isValidInterfaceOrientation)")
        
        // Deprecated, but still works
        //print("\(UIApplication.shared.statusBarOrientation.isLandscape)")
        
        /*** The problem: The AVCaptureSession hasn't yet been configured, so there are no connections...
         BUT videoOrientation setting requires a connection...
         SO, setting orientation here WON'T WORK ***/
        
        /* guard let connection = view.videoPreviewLayer.connection else {
            print("no connection...")
            return view
        }
        
        print("connection: \(connection)")
        connection.videoOrientation = .landscapeRight */
        
        // view.videoPreviewLayer.connection?.videoOrientation = .landscapeRight
        return view
    }
    
    func updateUIView(_ uiView: VideoPreviewView, context: Context) {
        // For debugging...
        // print("updateUIView()")
        
        /* guard let connection = uiView.videoPreviewLayer.connection else {
            print("UpdateUIView: no connection...")
            return
        }
        
        uiView.videoPreviewLayer.connection?.videoOrientation = .landscapeRight */
    }
}

struct CameraPreview_Previews: PreviewProvider {
    static var previews: some View {
        CameraPreview(session: AVCaptureSession(), service: CameraService() )
        .frame(height: 300)
    }
}
