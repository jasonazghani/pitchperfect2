    //
    //  RecordSoundsViewController.swift
    //  pitchperfect2
    //
    //  Created by jasonazghani on 5/14/15.
    //  Copyright (c) 2015 jasonazghani. All rights reserved.
    //
    
    import UIKit
    import AVFoundation
    
    class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate{
        
        @IBOutlet weak var recordButton: UIButton!
        @IBOutlet weak var recordingInProgress: UILabel!
        @IBOutlet weak var stopButton: UIButton!
        @IBOutlet weak var recordingUnsucessful: UILabel!
        
        var audioRecorder:AVAudioRecorder!
        var recordedAudio: RecordedAudio!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view, typically from a nib.
            updateUI(false)
            
            recordingUnsucessful.hidden = true
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        @IBAction func recordAudio(sender: UIButton) {
            updateUI(true)
            
            let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
            
            var currentDateTime = NSDate()
            var formatter = NSDateFormatter()
            formatter.dateFormat = "ddMMyyyy-HHmmss"
            var recordingName = formatter.stringFromDate(currentDateTime)+".wav"
            var pathArray = [dirPath, recordingName]
            let filePath = NSURL.fileURLWithPathComponents(pathArray)
            
            ///setup audio session
            var  session = AVAudioSession.sharedInstance()
            session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
            ///initialize and prepare the recorder
            audioRecorder = AVAudioRecorder (URL: filePath, settings: nil, error:nil )
            audioRecorder.delegate = self
            audioRecorder.meteringEnabled = true;
            audioRecorder.prepareToRecord()
            audioRecorder.record()
        }
        
        func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool){
            if(flag){
                //save recorded audio
                let  recordedAudio=RecordedAudio(filePathUrl: recorder.url, title: recorder.url.lastPathComponent)
                
                
                // move to the second screen
                self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
            }else{
                recordButton.enabled = true
                stopButton.hidden = true
                recordingUnsucessful.hidden = false
                recordingInProgress.hidden = true
                
            }
        }
        
        override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
            if (segue.identifier == "stopRecording"){
                let playSoundsVC: PlaySoundsViewController = segue.destinationViewController as!
                PlaySoundsViewController
                let data = sender as! RecordedAudio
                playSoundsVC.recievedAudio = data
            }
            
        }
        
        @IBAction func stopAudio(sender: UIButton) {
            updateUI(false)
            
            // stop recording the users voice
            audioRecorder.stop()
            var audioSession = AVAudioSession.sharedInstance();
            audioSession.setActive(false, error: nil)
        }
        
        func updateUI(currentlyRecording: Bool) {
            if (currentlyRecording) {
                //recording
                recordingInProgress.text = "Recording"
                stopButton.hidden = false
                recordingUnsucessful.hidden = true
                recordButton.enabled = false
            } else {
                //not recording
                recordingInProgress.text = "Tap to Record"
                stopButton.hidden = true
                recordButton.enabled = true
            }
        }
    }
    
