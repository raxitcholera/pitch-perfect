//
//  playsoundsvViewController.swift
//  Pitch Perfect
//
//  Created by raxit cholera on 10/20/15.
//  Copyright (c) 2015 kodeguide. All rights reserved.
//

import UIKit
import AVFoundation

/*

//Declared globally within PlaySoundsViewController


//Inside viewDidLoad


//Inside playChipmunkAudio


*/

class playsoundsvViewController: UIViewController {

    var audioPlayer = AVAudioPlayer()
    var filepath:NSURL!
    var receivedAudio:AudioModel!
    var audioEngine: AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        filepath = NSURL(fileURLWithPath:NSBundle .mainBundle().pathForResource("movie_quote", ofType: "mp3")!)
//        
        let error:NSError?
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl)
        } catch let error1 as NSError {
            error = error1
//            audioPlayer = nil
        }
        audioPlayer.prepareToPlay()
        audioPlayer.enableRate = true
        audioEngine = AVAudioEngine()
        audioFile = try? AVAudioFile(forReading: receivedAudio.filePathUrl)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func fastAudioBtn(sender: UIButton) {
        playaudioatspeed(2.0)
    }
    @IBAction func stopAudioBtn(sender: UIButton) {
        audioPlayer.stop()
    }

    @IBAction func playDarkVeda(sender: UIButton) {
        playaudioatPitch(-1000)
    }
    @IBAction func slowAudiobtn(sender: UIButton) {
        playaudioatspeed(0.5)

    }
    @IBAction func playChipmunkAudio(sender: UIButton) {
        playaudioatPitch(1000)
        
    }
    func playaudioatspeed(speed:Float)
    {
        audioPlayer.stop()
        audioPlayer.rate = speed;
        audioPlayer.currentTime=0.0;
        audioPlayer.play()
    }
    func playaudioatPitch(pitch:Float)
    {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        let changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        do {
            try audioEngine.start()
        } catch _ {
        }
        audioPlayerNode.play()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
