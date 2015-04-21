//
//  GifView.swift
//  GifView_Swift
//
//  Created by SkyNullCode on 4/19/15.
//  Copyright (c) 2015 SkyNullCode. All rights reserved.
//

import Cocoa

class GifView: NSView {

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        // Drawing code here.
        
        self.drawGif()
    }
    
    internal func setImage(image:NSImage?) {
        
        if(image != nil) {
             self.image = image;
            // get the image representations, and iterate through them
            var reps:NSArray = self.image!.representations as NSArray
            reps.enumerateObjectsUsingBlock({
                (object:AnyObject!, index:Int, stop:UnsafeMutablePointer<ObjCBool>) -> Void in
                    var rep:NSImageRep? = object as? NSImageRep
                    if(rep != nil) {
                        if (rep!.isKindOfClass(NSBitmapImageRep)) {
                            var numFrameOject: AnyObject? = (rep! as! NSBitmapImageRep).valueForProperty(NSImageFrameCount)
                            var numFrame:Int? = (numFrameOject as! Int)
                            if (numFrame != nil) {
                                // get the number of frames. If it's 0, it's not an animated gif, do nothing
                                if(numFrame == 0) {
                                  //  stop = UnsafeMutablePointer()<true>;
                                } else {
                                    var delayTime:Float = (rep! as! NSBitmapImageRep).valueForProperty(NSImageCurrentFrameDuration) as! Float;
                                    self.currentFrameIdx = 0;
                                    self.gifbitmapRep = rep! as? NSBitmapImageRep;
                                    self.gifTimer = NSTimer.scheduledTimerWithTimeInterval(Double(delayTime),
                                        target: self,
                                        selector:"animateGif",
                                        userInfo: nil,
                                        repeats: true)
                                    if(self.gifTimer != nil) {
                                        NSRunLoop.mainRunLoop().addTimer(self.gifTimer!,
                                            forMode: NSRunLoopCommonModes)
                                    }
                                }
                                
                            }
                            
                        }
                    }
                })

        }
    }
    
    internal func setImageURL(url:String?) {
        if ((url) != nil) {
            let urlRequest = NSMutableURLRequest(URL: NSURL(string: url!)!)
            urlRequest.addValue("image/*",forHTTPHeaderField:"Accept")
            NSURLConnection.sendAsynchronousRequest(urlRequest, queue: NSOperationQueue.mainQueue(), completionHandler: { (respinse:NSURLResponse!, data:NSData!, connetcionError:NSError!) -> Void in
                if((connetcionError) != nil) {
                   // println("Error description :\(connetcionError.localizedDescription)
                     //   ,errorCode = \(connectionError.code) ")
                } else {
                    let image = NSImage(data: data)
                    if ((image) != nil) {
                        self .setImage(image)
                    } else {
                        println("Error:not Image data")
                    }
                }
            })
        }

    }
    
    func animateGif() {
        self.display()
    }
    
    func drawGif() {
    
        if (self.gifbitmapRep != nil) {
            
            var numFrame:Int! = self.gifbitmapRep!.valueForProperty(NSImageFrameCount) as! Int
            
            if (self.currentFrameIdx >= numFrame) {
                self.currentFrameIdx = 0;
            }
            
            self.gifbitmapRep!.setProperty(NSImageCurrentFrame,withValue:self.currentFrameIdx)
    
            var drawGifRect:NSRect;
            if (self.image!.size.width > self.frame.size.width
                || self.image!.size.height > self.frame.size.height) {
                    
                    var hfactor = self.image!.size.width / self.frame.size.width;
                    var vfactor = self.image!.size.height / self.frame.size.height;
                    var factor = fmax(hfactor, vfactor);
                    var newWidth =  self.image!.size.width / factor;
                    var newHeight =  self.image!.size.height / factor;
                    drawGifRect = NSRect(x: (self.frame.size.width - newWidth) / 2.0,y: (self.frame.size.height - newHeight) / 2.0, width: newWidth, height: newHeight);
            } else {
                drawGifRect = NSRect(x: (self.frame.size.width - self.image!.size.width) / 2.0,y: (self.frame.size.height - self.image!.size.height) / 2.0, width: self.image!.size.width, height: self.image!.size.height);
            }
            
            self.gifbitmapRep!.drawInRect(drawGifRect,
                fromRect:NSZeroRect,
                operation:NSCompositingOperation.CompositeSourceOver,
                fraction:1.0,
                respectFlipped:false,
                hints:nil)
            
            self.currentFrameIdx++
        }
    }
    
    private var image:NSImage?
    private var gifbitmapRep:NSBitmapImageRep?
    private var currentFrameIdx:Int = 0
    private var gifTimer:NSTimer?
  
}
