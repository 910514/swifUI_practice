//
//  ContentView.swift
//  app tab test
//
//  Created by 黃士軒 on 2023/2/7.
//

import SwiftUI
extension Color {
    static let cloloABC = Color(hex: "#FFFFFF", alpha: 0.5)

    init(hex: String, alpha: CGFloat = 1.0) {
        var hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        if hex.hasPrefix("#") {
            hex = String(hex.dropFirst())
        }
        assert(hex.count == 3 || hex.count == 6 || hex.count == 8, "Invalid hex code used. hex count is #(3, 6, 8).")
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (r, g, b) = ((int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (r, g, b) = (int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (r, g, b) = (int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (r, g, b) = (1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(alpha)
        )
    }
}

struct ContentView: View {
    let gradient = LinearGradient(colors: [Color.init(hex: "#fbc8d4"),Color.init(hex: "#9795f0")],startPoint: .topLeading,endPoint: .bottomTrailing)
    var body: some View {
        TabView {
            ZStack {
                Color.green
                    .opacity(0.1)
                    .ignoresSafeArea()
                    .background(gradient).ignoresSafeArea()
                
                NavigationView {
                    List {
                        NavigationLink(destination: DetailView()) {
                                Image("connect")
                                .resizable()
                                .frame(width: 20, height: 20)
                                Text(" 連接至伺服器")
                                .frame(width: 200, height: 50, alignment: .leading)
                            }
                            NavigationLink(destination: ScaleFor2X()) {
                                Image("2k")
                                .resizable()
                                .frame(width: 20, height: 20)
                                Text(" 放大4x")
                                    .frame(width: 200, height: 50, alignment: .leading)
                            }
                            NavigationLink(destination: ScaleFor4X()) {
                                Image("4k")
                                .resizable()
                                .frame(width: 20, height: 20)
                                Text(" 放大4x*2")
                                    .frame(width: 200, height: 50, alignment: .leading)
                            }
                    }
                    .scrollContentBackground(.hidden).background(gradient)
                        .navigationBarTitle("RealEsrgan")
                }
                
                VStack {
                    Text("這裡沒打字好像就會出事.")
                        .opacity(0)
                        .padding()
                        .frame(maxHeight: .infinity)
                    
                    Rectangle()
                        .fill(Color.clear)
                        .frame(height: 3)
                        .background(Color.init(hex: "#D8D8D8"))
                }
                .font(.title2)
            }
            .tabItem {
                Image(systemName: "square.grid.2x2")
                Text("Home")
            }
            
            Text("Tab 2")
                .tabItem {
                    Image(systemName: "moon")
                    Text("Tab 2")
                }
            
            Text("Tab 3")
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("About")
                }
        }
    }
}

    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }

struct DetailView: View {
    var body: some View {
        Text("This is the page that for connect to server.")
    }
}

struct ScaleFor2X: View {
    var body: some View {
        Text("This is the page for scale 2X.")
    }
}

struct ScaleFor4X: View {
    var body: some View {
        Text("This is the page for scale 4X.")
    }
}

