//
//  ContentView.swift
//  MemojiSwiftUI
//
//  Created by wahaj on 03/07/2022.
//

import SwiftUI

struct HomeView: View {
    @State private var showMemojiEditor = true
    @State private var showActivityView = false
    @State private var showingAlert: AlertItem?
    @StateObject private var cardInfo = CardInfo()

    
    var body: some View {
        
        NavigationView {
            VStack{
                HStack{
                    Text("📇")
                        .font(.system(size: 50))
                    Text("Create your personal card")
                        .font(.title2)
                        .fontWeight(.heavy)
                }.padding()
                    .frame(maxWidth: .infinity,alignment: .leading)
                
                Spacer()
            if cardInfo.fullName != ""{
            VStack{
                
                
                ZStack(alignment: .topTrailing){
                    
                    CardView()
                    
                        .padding()
                        .environmentObject(cardInfo)
                    
                    NavigationLink(destination: {
                        EditCardView().environmentObject(cardInfo)
                    }, label: {
                        Image(systemName: "pencil.circle.fill")
                            .resizable()
                            .frame(width: 46, height: 46)
                    })
                    
                }
                Spacer()
                
                Menu {
                    Button(action: {
                        saveImage()
                    }) {
                        Text("Save to camera roll")
                    }
                    Button(action: {
                        self.showActivityView = true
                    }) {
                        Text("Share")
                    }
                } label: {
                    Text("Export")
                        .font(.title3)
                        .padding(7)
                        .frame(width: 230)
                        .background(.ultraThickMaterial)
                        .cornerRadius(10)
                }
                
                Spacer()
                
            }
            .alert(item: $showingAlert) { item in
                item.alert
            }
            .sheet(isPresented: $showActivityView) {
                ShareSheet(item: render())
            }
            } else{
                VStack{
                    Spacer()
                    NavigationLink(destination: {
                        EditCardView().environmentObject(cardInfo)

                    }, label: {
                       Text("Click Here to Create your Card")
                    })
                    Spacer()
                }
            }
            }
            .navigationBarHidden(true)
                
        }
        
        
        
        
    }
    
    struct AlertItem: Identifiable {
        var id = UUID()
        var alert: Alert
    }
    
    struct ShareSheet: UIViewControllerRepresentable {
        var item : Any
        
        func makeUIViewController(context: Context) -> UIActivityViewController {
            let activityItems: [Any] = [item]
            
            let controller = UIActivityViewController(
                activityItems: activityItems,
                applicationActivities: nil)
            
            return controller
        }
        
        func updateUIViewController(_ vc: UIActivityViewController, context: Context) {
        }
    }
    class ImageSaver: NSObject {
        var successHandler: (() -> Void)?
        var errorHandler: ((Error) -> Void)?
        
        func writeToPhotoAlbum(image: UIImage) {
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
        }
        
        @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
            if let error = error {
                errorHandler?(error)
            } else {
                successHandler?()
            }
        }
    }
    
    func saveImage() {
        let imageSaver = ImageSaver()
        
        imageSaver.successHandler = {
            self.showingAlert = AlertItem(alert: Alert(title: Text("Image saved.")))
        }
        imageSaver.errorHandler = {
            self.showingAlert = AlertItem(alert: Alert(title: Text("Faled to save image.")))
            print("Oops: \($0.localizedDescription)")
        }
        
        imageSaver.writeToPhotoAlbum(image: render())
    }
    private func render() -> UIImage {
        CardView()
            .environmentObject(cardInfo)
            .snapshot()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()  .preferredColorScheme(.dark)
    }
}
