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
    

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var RecordButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    
    var audioRecorder : AVAudioRecorder?
    var audioPlayer : AVAudioPlayer?
    var audioURL : URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRecorder()
        playButton.isEnabled = false
        addButton.isEnabled = false
        
        
    }
    
    func setupRecorder() {
        do {
            //Create audio session
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try session.overrideOutputAudioPort(.speaker)
            try session.setActive(true)
            
            //Create URL for audio
            let basePath : String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            let pathComponents = [basePath, "audio.m4a"]
            audioURL = NSURL.fileURL(withPathComponents: pathComponents)

            //Create settings for audio recorder
            var settings : [String:AnyObject] = [:]
            settings[AVFormatIDKey] = kAudioFormatMPEG4AAC as AnyObject?
            settings[AVSampleRateKey] = 44100.0 as AnyObject?
            settings[AVNumberOfChannelsKey] = 2 as AnyObject?
        
            // Create AudioRecorder object
            try audioRecorder = AVAudioRecorder(url: audioURL!, settings: settings)
            audioRecorder!.prepareToRecord()
            
        } catch let error as NSError {
            print(error)
        }
    }
    
    @IBAction func recordTapped(_ sender: Any) {
        
        if audioRecorder!.isRecording {
            //stop recording
            audioRecorder?.stop()
            //change button to record
            RecordButton.setTitle("Record", for: .normal)
            playButton.isEnabled = true
            addButton.isEnabled = true
            
        } else {
            //start recording
            audioRecorder?.record()
            //change butt to stop
            RecordButton.setTitle("Stop", for: .normal)
            
        }
        
    }
    @IBAction func playTapped(_ sender: Any) {
        do{
        try audioPlayer = AVAudioPlayer(contentsOf: audioURL!)
        audioPlayer!.play()
        } catch {}
    }
    
    
    
    @IBAction func addTapped(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let sound = Sound(context: context)
        sound.name = nameTextField.text
        
        sound.audio = NSData(contentsOf: audioURL!)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
    }
    
    
    
} //Final Declaration
