//
//  ViewController.swift
//  Pitch Perfect
//
//  Created by raxit cholera on 10/19/15.
//  Copyright (c) 2015 kodeguide. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController ,AVAudioRecorderDelegate{

    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordbtn: UIButton!
    @IBOutlet weak var recordinglbl: UILabel!
    
    var audioRecorder:AVAudioRecorder!
    var recordedAudio:AudioModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(animated: Bool) {
        recordbtn.enabled = true;
        recordinglbl.hidden = true;
        stopButton.hidden = true;
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier=="stopRecord"){
            let playSoundsVc:playsoundsvViewController = segue.destinationViewController as! playsoundsvViewController
            let data = sender as! AudioModel
            playSoundsVc.receivedAudio = data
            
        }
    }
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        if(flag){
        recordedAudio = AudioModel()
        recordedAudio.filePathUrl = recorder.url
        recordedAudio.title = recorder.url.lastPathComponent
        self.performSegueWithIdentifier("stopRecord", sender: recordedAudio)
        }
    }
    @IBAction func stopAudioRecordingbtn(sender: UIButton) {
        audioRecorder.stop()
        var audiosession = AVAudioSession.sharedInstance()
        audiosession.setActive(false, error: nil)
        
        recordinglbl.hidden = true;
        stopButton.hidden = true;
    }

    @IBAction func recordAudio(sender: AnyObject) {
        
        //TODO:add function that shows progress
        recordbtn.enabled = false;
        recordinglbl.hidden = false;
        stopButton.hidden = false;
        
        //TODO:add record feature
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String

        let recordingName = "temp.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        print(filePath)
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        audioRecorder = AVAudioRecorder(URL: filePath!, settings: nil,error:nil)
        audioRecorder.meteringEnabled = true
        audioRecorder.delegate = self
        audioRecorder.prepareToRecord()
        audioRecorder.record()
       
    }
}