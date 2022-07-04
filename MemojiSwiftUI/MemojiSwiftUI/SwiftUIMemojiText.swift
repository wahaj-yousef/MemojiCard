//
//  SwiftUIMemojiText.swift
//  MemojiSwiftUI
//
//  Created by wahaj on 03/07/2022.
//

import Foundation
import SwiftUI

class MemojiTextView: UITextView {
    override var textInputContextIdentifier: String? { "" }
    
    override var textInputMode: UITextInputMode? {
        for mode in UITextInputMode.activeInputModes {
            if mode.primaryLanguage == "emoji" {
                return mode
            }
        }
        return nil
    }
}
extension SwiftUIMemojiText {
    class Coordinator: NSObject, UITextViewDelegate {
        @Binding var image: UIImage
        @Binding var imageChose: Bool

        init(image: Binding<UIImage>, imageChose: Binding<Bool>) {
            self._image = image
            self._imageChose = imageChose
        }
        
        func textViewDidChange(_ textView: UITextView) {
            textView.attributedText.enumerateAttributes(in: NSMakeRange(0, textView.attributedText.length), options: []) { (attachment, range, _) in
                attachment.values.forEach({ (value) in
                    if ((value as? NSTextAttachment) != nil) {
                        let textAttachment: NSTextAttachment = value as! NSTextAttachment
                        self.image = textAttachment.image!
                        textView.isEditable = false
                        imageChose = false
                        return
                        
                    }
                })
            }
        }
    }
}
struct SwiftUIMemojiText: UIViewRepresentable {
    @Binding private var image: UIImage
    @Binding private var imageChose: Bool

    private var textView = MemojiTextView()
    
    init(image: Binding<UIImage>, imageChose: Binding<Bool>) {
        textView.allowsEditingTextAttributes = true
        textView.clearsOnInsertion = true
        self._image = image
        self._imageChose = imageChose

    }
    
    func makeUIView(context: Context) -> MemojiTextView {
        textView.delegate = context.coordinator
        return textView
    }
    
    func updateUIView(_ uiView: MemojiTextView, context: Context) {

    }
    
    func makeCoordinator() -> SwiftUIMemojiText.Coordinator {
        return Coordinator(image: $image, imageChose: $imageChose)
        
    }
}
