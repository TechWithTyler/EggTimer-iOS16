//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

	@IBOutlet weak var timerLabel: UILabel?

	@IBOutlet weak var progressBar: UIProgressView?

	var player: AVAudioPlayer? = nil

	let eggTimes = ["Soft": 300, "Medium": 420, "Hard": 720]

	var totalTime = 0

	var secondsPassed = 0

	var timer = Timer()
    
	@IBAction func hardnessSelected(_ sender: UIButton) {
		let hardness = sender.currentTitle!
		timer.invalidate()
		totalTime = eggTimes[hardness]!
		progressBar?.progress = 0.0
		secondsPassed = 0
		timerLabel?.text = hardness
		timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [self] (timer) in
			if secondsPassed < totalTime {
				secondsPassed += 1
				progressBar?.progress = Float(secondsPassed) / Float(totalTime)
			} else {
				timerLabel?.text = "DONE!"
				timer.invalidate()
				playSound()
			}
		}

	}

	func playSound() {
		guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { fatalError("Sound error") }
		do {
			player = try AVAudioPlayer(contentsOf: url)
			player?.play()
		} catch {
			fatalError("Sound error: \(error)")
		}
	}


}
