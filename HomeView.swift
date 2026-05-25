//
//  SecondView.swift
//  ProjectTAC432
//
//  Created by Samantha Reap on 4/4/26.
//

import SwiftUI

struct HomeView: View {
    //global - stays alive as long as app is open (unfort)
    @StateObject private var store = ResumeStore()
    
    //local
    @State private var isSuccess = false
    @State private var title = ""
    @State private var date = ""
    @State private var summary = ""
    
    var body : some View {
        //transition between two screens
        NavigationView {
            //back to front
            ZStack {
                // 1. THE ACTUAL BACKGROUND (bottom)
                Rectangle()
                // Changes from blue to yellow based on isSuccess
                //specific colors from figma
                    .foregroundColor(isSuccess ? Color(red: 0.93, green: 0.84, blue: 0.48) : Color(red: 0.68, green: 0.82, blue: 0.94))
                    .frame(width: 320, height: 500)
                    .cornerRadius(20)
                //transition half second seems good
                    .animation(.easeInOut(duration: 0.5), value: isSuccess)
                
                //stacks eleemtns vertically
                VStack(spacing: 25) {
                    //app title
                    Text("PUZZ-UME")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                    
                    //input fields
                    VStack(spacing: 15) {
                        CustomTextField(placeholder: "Title", text: $title)
                        CustomTextField(placeholder: "Date", text: $date)
                        SummaryTextField(text: $summary)
                    }
                    
                    // Add Button
                    Button(action: {
                        //no empty spaces is trimmingCharacters
                        let titleHastext = !title.trimmingCharacters(in: .whitespaces).isEmpty
                        let dateHasText = !date.trimmingCharacters(in: .whitespaces).isEmpty
                        let summaryHasText = !summary.trimmingCharacters(in: .whitespaces).isEmpty
                        
                        //run if all fields filled
                        if titleHastext && dateHasText && summaryHasText {
                            
                            //package into resumeitem
                            let newItem = ResumeItem(title: title, date: date, summary: summary)
                            //add globally
                            store.items.append(newItem)
                            
                            // Start animation to turn yellow
                            withAnimation {
                                isSuccess = true
                            }
                            
                            // Wait a moment so you see the yellow, then reset
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                                withAnimation {
                                    isSuccess = false
                                    title = ""; date = ""; summary = ""
                                }
                            }
                        }
                    }) {
                        //button appearance
                        Text("ADD TO PUZZ-UME")
                            .font(.headline)
                            .foregroundColor(.black)
                            .frame(width: 200, height: 45)
                            .background(Color(red: 0.93, green: 0.84, blue: 0.48))
                            .cornerRadius(20)
                    }
                    
                    // button off unless all fields are filled
                    .disabled(title.isEmpty || date.isEmpty || summary.isEmpty)
                    
                    //drag-and-drop takes in our global variable
                    NavigationLink(destination: PuzzumeView(store: store)) {
                        HStack {
                            Text("to puzz-ume")
                                .font(.caption)
                            Image(systemName: "arrow.right")
                        }
                        .foregroundColor(.black)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .background(
                            Capsule()
                                .fill(.white)
                        )
                    }
                }
            }
        }
    }
}

//structure for 1-line inputs
struct CustomTextField: View {
    var placeholder: String
    @Binding var text: String //@Binding lets this structure connect with the @State in HomeView struct (bridge)
    
    var body: some View{
        ZStack {
            //white background box
            RoundedRectangle(cornerRadius: 5)
                .fill(.white)
                .frame(width: 250, height: 35)
            
            //actual typing area
            TextField(placeholder, text: $text)
                .font(.subheadline)
                .padding(.horizontal, 10)
                .frame(width: 250)
        }
    }
}

//large multi-line summary input
struct SummaryTextField: View{
    @Binding var text: String
    
    var body: some View {
        //alignment: .topLeading forces typing to start at top left not middle
        ZStack(alignment: .topLeading){
            RoundedRectangle(cornerRadius: 5)
                .fill(.white)
                .frame(width: 250, height: 100)
            //scrollview ensures massive text to scroll
            ScrollView{
                //textfield says to go down like a paragraph
                TextField("text summary", text: $text, axis: .vertical)
                    .font(.subheadline)
                    .padding(10)
                    .frame(width: 250, alignment: .leading)
            }
            .frame(width: 250, height: 100)
            .clipped() //cuts off any text that spills outside  100
        }
    }
}

#Preview{
    HomeView()
}
