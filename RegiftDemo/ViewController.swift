//
//  ViewController.swift
//  RegiftDemo
//
//  Created by Matthew Palmer on 28/12/2014.
//  Copyright (c) 2014 Matthew Palmer. All rights reserved.
//

import UIKit
import MobileCoreServices
import Regift

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var finishedSelecting: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if !finishedSelecting {
            presentVideoPicker()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UIImagePickerControllerDelegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        // Toggle state
        finishedSelecting = true
        
        // Dismiss the picker
        self.dismissViewControllerAnimated(true, completion: nil)
        
        if let url = info[UIImagePickerControllerMediaURL] as? NSURL {
            createGifFromURL(url)
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        // Toggle state
        finishedSelecting = true

        // Dismiss the picker
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    // MARK: Gif creation
    func createGifFromURL(URL: NSURL) {
        let gifURL = Regift.createGIFFromURL(URL, withFrameCount: 16, delayTime: 0.2)
        
        println("gif URL is \(gifURL)")
    }
    
    // MARK: Picker presentation
    func presentVideoPicker() {
        // Set up our video picker
        let picker = UIImagePickerController()
        
        picker.delegate = self
        
        // Taken on the device's camera
        picker.sourceType = UIImagePickerControllerSourceType.Camera
        
        // Videos only
        picker.mediaTypes = [kUTTypeMovie]
        
        // Present the picker
        self.presentViewController(picker, animated: true, completion: nil)
    }
}
