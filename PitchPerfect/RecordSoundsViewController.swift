//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Nicholas Park on 5/2/16.
//  Copyright © 2016 Nicholas Park. All rights reserved.
//

import UIKit
import AVFoundation

class HomeViewController: UIViewController, AVAudioRecorderDelegate {

    struct Constants{
        static let StopButton = "Stop"
        static let RecordButton = "Record"
        static let InspectionSegue = "Inspection Segue"
    }
    
    @IBOutlet var recordLabel: UILabel!
    var recording:Bool = false
    var audioRecorder: AVAudioRecorder!
    lazy var stopImage: UIImage? = {
        return UIImage(named: Constants.StopButton)
    }()
    lazy var recordImage: UIImage? = {
        return UIImage(named: Constants.RecordButton)
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }

    
    @IBAction func recordPressed(sender: UIButton) {
        recording = !recording
        if recording{
            recordLabel.text = "Recording..."
            sender.setImage(stopImage, forState: .Normal)
        }else{
            recordLabel.text = "Record"
            sender.setImage(recordImage, forState: .Normal)
        }
        
    }
    
    func startRecording(){
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        try! audioRecorder = AVAudioRecorder(URL: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    

}

