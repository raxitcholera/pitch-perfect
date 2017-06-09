//
//  PlayBackViewController.swift
//  PitchPerfect
//
//  Created by Raxit Cholera on 6/1/17.
//  Copyright © 2017 Raxit Cholera. All rights reserved.
//

import UIKit
import AVFoundation

class PlayBackViewController: UIViewController {
    
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var lowPitchButton: UIButton!
    @IBOutlet weak var highPitchButton: UIButton!
    @IBOutlet weak var slowButton: UIButton!
    @IBOutlet weak var fastButton: UIButton!
    @IBOutlet weak var stopPlayingButton: UIButton!
    
    var audioUrl:NSURL!
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode:AVAudioPlayerNode!
    var stopTimer: Timer!
    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }

    override func viewWillAppear(_ animated: Bool) {
        configureUI(.notPlaying)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Play Audio"
        print(audioUrl)
        setupAudio()
        stopPlayingButton.isEnabled = false
        fitButtons()
    }
    func fitButtons(){
        slowButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        fastButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        echoButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        reverbButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        lowPitchButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        highPitchButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        stopPlayingButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
    }

    @IBAction func playBackSoundForButton(_ sender:UIButton){
        switch(ButtonType(rawValue: sender.tag)!) {
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .chipmunk:
            playSound(pitch: 1000)
        case .vader:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
        
        configureUI(.playing)
    }
    @IBAction func stopButtonPressed(_ sender:UIButton){
        print("Stop Pressed")
        stopAudio()
    }
    
    
}
