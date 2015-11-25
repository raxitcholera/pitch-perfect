//
//  RecorderViewController.swift
//  Pitch Perfect
//
//  Created by raxit cholera on 10/19/15.
//  Copyright (c) 2015 kodeguide. All rights reserved.
//

import UIKit
import AVFoundation


class RecorderViewController: UIViewController ,AVAudioRecorderDelegate{

    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordbtn: UIButton!
    @IBOutlet weak var recordinglbl: UILabel!
    @IBOutlet weak var pauseBtn: UIButton!
    @IBOutlet weak var continueBtn: UIButton!
    
    var audioRecorder:AVAudioRecorder!
    var recordedAudio:AudioModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        recordinglbl.text = "Tap To Record"
    }

    override func viewWillAppear(animated: Bool) {
        recordbtn.enabled = true;
        stopButton.hidden = true;
        pauseBtn.hidden = true;
        continueBtn.hidden = true;
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier=="stopRecord"){
            let playSoundsVc:playsoundsvViewController = segue.destinationViewController as! playsoundsvViewController
            let data = sender as! AudioModel
            playSoundsVc.receivedAudio = data
            
        }
    }
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        if(flag){
        recordedAudio = AudioModel(text: recorder.url.lastPathComponent!)
        recordedAudio.filePathUrl = recorder.url
        self.performSegueWithIdentifier("stopRecord", sender: recordedAudio)
        }
    }
    @IBAction func stopAudioRecordingbtn(sender: UIButton) {
        audioRecorder.stop()
        let audiosession = AVAudioSession.sharedInstance()
        do {
            try audiosession.setActive(false)
        } catch _ {
        }
        recordinglbl.text = "Tap To Record"
        stopButton.hidden = true;
        pauseBtn.hidden = true;
        continueBtn.hidden = true;
    }
    func rearrangeBtns(current:Bool)
    {
        if(current)
        {
            continueBtn.hidden = true;
            pauseBtn.hidden = false;
        }
        else
        {
            continueBtn.hidden = false;
            pauseBtn.hidden = true;
        }
    }
    @IBAction func continueBtnClicked(sender: UIButton) {
        recordinglbl.text = "Recording..."
        rearrangeBtns(true);
        audioRecorder.record()
    }
    @IBAction func PauseRecording(sender: UIButton) {
        audioRecorder.pause()
        recordinglbl.text = "Tap Record to Continue"
        rearrangeBtns(false);
    }
    @IBAction func recordAudio(sender: AnyObject) {
        
        recordbtn.enabled = false;
        recordinglbl.text = "Recording...";
        stopButton.hidden = false;
        rearrangeBtns(true);
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] 

        let recordingName = "temp.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        print(filePath, terminator: "")
        
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        } catch _ {
        }
        
        try! audioRecorder = AVAudioRecorder(URL: filePath!, settings: [:])
        audioRecorder.meteringEnabled = true
        audioRecorder.delegate = self
        audioRecorder.prepareToRecord()
        audioRecorder.record()
       
    }
}