//
//  EditCardView.swift
//  MemojiSwiftUI
//
//  Created by wahaj on 03/07/2022.
//

import SwiftUI
import iPhoneNumberField

struct EditCardView: View {
    @EnvironmentObject var cardInfo : CardInfo
    
    @State private var fullname: String = ""

    @State private var isEditing: Bool = false
    @State private var imageChose: Bool = false
    @State private var intrestEdit: Bool = false

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View{
        VStack(alignment: .center){
            
            VStack(alignment: .center){
                
                Button(action: {
                    imageChose=true
                    
                },
                       label: {
                    
                    
                    Image(uiImage: cardInfo.Memoji)
                        .resizable()
                        .scaledToFill()
                        .frame(width: intrestEdit ? 100: 200,height: intrestEdit ? 100:200, alignment: .center)
                        .background(.ultraThickMaterial)
                        .cornerRadius(100)
                    
                }).sheet(isPresented: $imageChose,onDismiss: {imageChose = false}, content: {
                    ZStack{                    SwiftUIMemojiText(image: $cardInfo.Memoji, imageChose: $imageChose)
                            .frame(width: 0, height: 0)
                    }
                    .background(BackgroundClearView())
                })
                
                
                
                
                
                HStack{
                    Spacer()
                    
                    
                    if !intrestEdit {
                        Text("Enter your Memoji Here👆🏼").font(.caption)
                            .foregroundColor(.gray)
                        
                    }
                    Spacer()
                }
                
                
            }
            ScrollView{
                ScrollViewReader { value in

            VStack(alignment: .leading){
                HStack{
                    Text("👤 Personal Info:")
                        .padding(5)
                    Spacer()
                }
                .background(.ultraThickMaterial)
                
                TextField("Full Name", text: cardInfo.fullName != "" ? $cardInfo.fullName : $fullname)
                    .textFieldStyle(.roundedBorder)
                iPhoneNumberField( text: $cardInfo.phoneNo,  isEditing: $isEditing)
                    .flagHidden(false)
                    .maximumDigits(9)
                    .clearButtonMode(.whileEditing)
                    .placeholderColor(_:Color(.gray))
                    .textFieldStyle(.roundedRect)
                TextField("Email", text: $cardInfo.email)
                    .textFieldStyle(.roundedBorder)
                
                Divider()
                HStack{
                    
                    Text("🌟 Intersts:")
                        .padding(5)
                    Spacer()
                }
                .background(.ultraThickMaterial)
                
                TextEditor(text: $cardInfo.interset)
                    .frame(height: 100)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray,lineWidth: 0.2))
                    .onTapGesture {
                        withAnimation { intrestEdit.toggle()
                            value.scrollTo(1)
                            if !intrestEdit{
                                hideKeyboardAndSave()
                            }
                        }
                    }
                Divider()
                    .id(1)

                HStack{
                    
                    Text("🎨 Colors:")
                        .padding(5)
                    Spacer()
                }
                .background(.ultraThickMaterial)
                
                VStack{
                                  ColorPicker("background color", selection: $cardInfo.BgColor)
                                  ColorPicker("Text color", selection: $cardInfo.TextColor)
                }.padding()
            }
            }
            }
            Button(action: {
                hideKeyboardAndSave()
                if fullname != ""{
                cardInfo.fullName = fullname
                }
                presentationMode.wrappedValue.dismiss()

            }, label: {
                Text("Done")
                    .font(.title3)
                    .fontWeight(.regular)
                    .frame(width: 200)
            }).buttonStyle(.bordered)
        }.padding()
            .navigationTitle("Card Editor")
            .navigationBarTitleDisplayMode(.inline)
    }
       
    private func hideKeyboardAndSave() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        intrestEdit = false
    }
    struct BackgroundClearView: UIViewRepresentable {
        func makeUIView(context: Context) -> UIView {
            let view = UIView()
            DispatchQueue.main.async {
                view.superview?.superview?.backgroundColor = .clear
            }
            return view
        }
        
        func updateUIView(_ uiView: UIView, context: Context) {}
    }
}

struct EditCardView_Previews: PreviewProvider {
    static var previews: some View {
        EditCardView()  .preferredColorScheme(.dark)
    }
}
