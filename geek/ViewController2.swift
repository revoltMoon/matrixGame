//
//  ViewController2.swift
//  geek
//
//  Created by Влад Купряков on 14.03.17.
//  Copyright © 2017 Влад Купряков. All rights reserved.
//

import UIKit
import AVFoundation
var kubik = 0
var kubik2 = 0
var pers1win: Bool = false
var pers2win: Bool = false
class ViewController2: UIViewController {
    var go_sound = AVAudioPlayer()
    var go_sound2 = AVAudioPlayer()
    func kubic_go() -> Int {
        let k = Int(arc4random_uniform(6)+1)
        let kub_num:String = String(k)+".png"
        let ki: UIImage = UIImage(named:kub_num)!
        kub_img.image=ki
        view.addSubview(kub_img)
        return k
    }
    
    
    
    var x: [Int] = [0,40,80,120,160,200,240,280,280,240,200,160,120,80,40,0,0,40,80,120,160,200,240,280,280,240,200,160,120,80,40,0,0,40,80,120,160,200,240,280,280,240,200,160,120,80,40,0,0,40,80,120,160,200,240,280,280,240,200,160,120,80,40,0]
    var y: [Int] = [300,300,300,300,300,300,300,300,260,260,260,260,260,260,260,260,220,220,220,220,220,220,220,220,180,180,180,180,180,180,180,180,140,140,140,140,140,140,140,140,100,100,100,100,100,100,100,100,60,60,60,60,60,60,60,60,20,20,20,20,20,20,20,20]
    
    @IBOutlet weak var go: UIButton!
    @IBOutlet weak var hot1: UILabel!
    @IBOutlet weak var hot2: UILabel!
    @IBAction func go(_ sender: UIButton) {
        kubik += kubic_go()
        var sound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "pers2go1", ofType: "mp3")!)
        do
        {
            go_sound = try AVAudioPlayer (contentsOf: sound as URL)
            go_sound.prepareToPlay()
            go_sound.play()
        }
        catch{
            print("Error!")
        }
        if (kubik<63){
            if (kubik2 != 63)
            {
            pers1_view()
            go.isEnabled = false
            _ = Timer.scheduledTimer(timeInterval: 3, target: self, selector: Selector("pers2go"), userInfo:nil, repeats: false)
            }
            else{
                //pers2win
                let alert = UIAlertController(title: "You are lose!", message: "Loshara!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title:"Okay",style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                kubik = 0
                pers1_view()
                kubik2 = 0
                pers2_view()
                pers1win = false
                hot2.text = "Current position second player: \(kubik2)"
                pers2win = false
            }
        }
        else{
            if (pers1win != true)
            {
                kubik = 63
                pers1_view()
                pers1win = true
            }
            else{
                //pers1win
                let alert = UIAlertController(title: "You are victory!", message: "Congrats!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title:"Ok",style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                kubik = 0
                pers1_view()
                kubik2 = 0
                pers2_view()
                pers1win = false
                hot2.text = "Current position second player: \(kubik2)"
                
            }
        }
        hot1.text = "Current position first player: \(kubik)"
        
        
    }
    
    func pers2go() {
        kubik2 += kubic_go()
        var sound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "pers2go2" , ofType: "mp3")!)
        do
        {
            go_sound2 = try AVAudioPlayer (contentsOf: sound as URL)
            go_sound2.prepareToPlay()
            go_sound2.play()
        }
        catch{
            print("Error!")
        }
        if (kubik2<63){
            pers2_view()
        }
        else{
            if (pers1win != true)
            {
                kubik2 = 63
                pers2_view()
                pers2win = true
            }
            else{
                kubik2 = 0
                pers2_view()
                kubik = 0
                pers1_view()
                pers2win = false
                hot1.text = "Current position second player: \(kubik2)"
                
            }
        }
        hot2.text = "Current position second player: \(kubik2)"
        go.isEnabled = true
        
    }

    @IBOutlet weak var kub_img: UIImageView!
    let pers1i: UIImage = UIImage(named: "player1.jpg")!
    let pers1v: UIImageView = UIImageView()
    let pers2i: UIImage = UIImage(named: "player2.jpg")!
    let pers2v: UIImageView = UIImageView()
    func pers1_view(){
        pers1v.image = pers1i
        pers1v.frame.size.width = 40
        pers1v.frame.size.height = 40
        UIView.animate(withDuration: 0.8, animations: {
            self.pers1v.frame.origin.x = CGFloat(self.x[kubik])
            self.pers1v.frame.origin.y = CGFloat(self.y[kubik])
        })
            view.addSubview(pers1v)
    }
    
    func pers2_view(){
        pers2v.image = pers2i
        pers2v.frame.size.width = 40
        pers2v.frame.size.height = 40
       
        UIView.animate(withDuration: 0.8, animations: {
            self.pers2v.frame.origin.x = CGFloat(self.x[kubik2])
            self.pers2v.frame.origin.y = CGFloat(self.y[kubik2])
        })
        
         view.addSubview(pers2v)
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        pers2_view()
        pers1_view()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
