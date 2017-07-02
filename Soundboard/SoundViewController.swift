//
//  SoundViewController.swift
//  Soundboard
//
//  Created by Joshua Martin on 7/2/17.
//  Copyright © 2017 Joshua Martin. All rights reserved.
//

import UIKit
import AVFoundation


class SoundViewController: UIViewController {

    @IBOutlet weak var TextField: UITextField!
    @IBOutlet weak var RecordButton: UIButton!
    
    var audioRecorder : AVAudioRecorder?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRecorder()
        
    }
    
    func setupRecorder() {
        
        //Create audio session
        let session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        session.overrideOutputAudioPort(.speaker)
        session.setActive(true)
        
        //Create URL for audio
        
        //Create settings for audio recorder
        
        // Create AudioRecorder object
        
        try audioRecorder = AVAudioRecorder(url: <#T##URL#>, settings: <#T##[String : Any]#>)

    }
    
    @IBAction func recordTapped(_ sender: Any) {
    }
    
    @IBAction func addTapped(_ sender: Any) {
    }
    
    
    
} //Final Declaration
