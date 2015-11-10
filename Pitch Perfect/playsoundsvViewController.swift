//
//  playsoundsvViewController.swift
//  Pitch Perfect
//
//  Created by raxit cholera on 10/20/15.
//  Copyright (c) 2015 kodeguide. All rights reserved.
//

import UIKit
import AVFoundation


class playsoundsvViewController: UIViewController {

    var audioPlayer = AVAudioPlayer()
    var filepath:NSURL!
    var receivedAudio:AudioModel!
    var audioEngine: AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        let error:NSError?
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl)
        } catch let error1 as NSError {
            error = error1

        }
        audioPlayer.prepareToPlay()
        audioPlayer.enableRate = true
        audioEngine = AVAudioEngine()
        audioFile = try? AVAudioFile(forReading: receivedAudio.filePathUrl)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    @IBAction func playNormalAudio(sender: AnyObject) {
        playaudioatspeed(1.0)
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
        audioEngine.stop()
        audioEngine.reset()
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
    

}
