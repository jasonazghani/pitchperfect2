//
//  PlaySoundsViewController.swift
//  pitchperfect2
//
//  Created by jasonazghani on 5/16/15.
//  Copyright (c) 2015 jasonazghani. All rights reserved.
//

import UIKit
import AVFoundation


class PlaySoundsViewController: UIViewController {

    @IBOutlet weak var stopSound: UIButton!
    
    var audioPlayer:AVAudioPlayer!
    var recievedAudio: RecordedAudio!
    
    var audioEngine: AVAudioEngine!
    var audioFile: AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       // if  var filePath = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3")
            //{
          //  var filePathUrl = NSURL.fileURLWithPath(filePath)
           //  audioPlayer = AVAudioPlayer(contentsOfURL: filePathUrl, error: nil)
          //  audioPlayer.enableRate=true
            
       // }else {
        //    println("the filePath is empty")
      //  }
    
        audioPlayer = AVAudioPlayer( contentsOfURL: recievedAudio.filePathUrl, error: nil)
       audioPlayer.enableRate = true
        
        
        audioEngine = AVAudioEngine()
       audioFile = AVAudioFile ( forReading: recievedAudio.filePathUrl, error: nil)
    }
    
    
    
    @IBAction func playSlowSound(sender: UIButton) {
        playAudioWithVariableSpeed  (0.5)
        
    }
        
    
    @IBAction func fast2xiphone(sender: UIButton) {
        playAudioWithVariableSpeed  ( 1.5)
       
    }
    
    
    
    func playAudioWithVariableSpeed(speed: Float) {
        audioPlayer.stop()
        audioPlayer.rate = speed
        audioPlayer.currentTime=0
        audioPlayer.play()
        
    }
    
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    
    func playAudioWithVariablePitch (pitch: Float ) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()


        var audioPlayerNode = AVAudioPlayerNode()
         audioEngine.attachNode ( audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch ()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile ( audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
        
    }
    
    
    @IBAction func stopSound(sender: UIButton) {
        audioPlayer.stop()
    }
    
    

        override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
        
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


