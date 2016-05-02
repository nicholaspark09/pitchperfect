//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Nicholas Park on 5/2/16.
//  Copyright © 2016 Nicholas Park. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController,AVAudioRecorderDelegate {

    struct Constants{
        static let StopButton = "Stop"
        static let RecordButton = "Record"
        static let StopSegue = "Stop Segue"
        static let FileName = "recordedVoice.wav"
    }
    
    @IBOutlet var recordButton: UIButton!
    @IBOutlet var stopRecordingButton: UIButton!
    @IBOutlet var recordLabel: UILabel!
    var audioRecorder: AVAudioRecorder!
    var stopImage: UIImage?
    var recordImage: UIImage?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopImage = UIImage(named: Constants.StopButton)
        recordImage = UIImage(named: Constants.RecordButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }

    
    @IBAction func recordPressed(sender: UIButton) {
            recordLabel.text = "Recording..."
            stopRecordingButton.enabled = true
            sender.enabled = false
            startRecording()
            stopRecordingButton.hidden = false
    }
    
    @IBAction func stopRecordingPressed(sender: UIButton) {
        recordLabel.text = "Record"
        stopRecording()
        recordButton.enabled = true
        sender.enabled = false
        stopRecordingButton.hidden = true
    }
    
    
    func startRecording(){
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        let recordingName = Constants.FileName
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
    
    func stopRecording(){
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        print("AVAudioRecorder Done")
        if flag{
            performSegueWithIdentifier(Constants.StopSegue, sender: audioRecorder.url)
        }else{
            print("Couldn't save the file")
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == Constants.StopSegue{
            if let psvc = segue.destinationViewController as? PlaySoundsViewController{
                let recordedAudioURL = sender as! NSURL
                psvc.recordedAudioURL = recordedAudioURL
            }
        }
    }
    

}

