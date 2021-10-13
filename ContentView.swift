//
//  ContentView.swift
//  ESP32-Wifi
//
//  Created by Christopher Langrio on 19/9/21.
//

import SwiftUI
import AVKit


func GetHttp(_ port: Int, _ value: Int) {
    guard let url = URL(string: "http://192.168.1.241:80/update?relay=" + String(port) + "&state=" + String(value)) else { fatalError("Missing URL") }
        
        let urlRequest = URLRequest(url: url)
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                if let error = error {
                    print("Request error: ", error)
                    return
                }
            }
            dataTask.resume()
    }



struct ContentView: View {
    
    @State var toggleIsOn1: Bool = false
    @State var toggleIsOn2: Bool = false
    @State var toggleIsOn3: Bool = false
    @State var toggleIsOn4: Bool = false
    
    let urlcam = URL (string: "http://192.168.1.29:81/stream")!
    
    
    var body: some View {
        Group {
            VStack{
                
                HStack {Text("Office Room Control")}.padding(.top, 10.0).font(.title)
                
                //ZONE 1 ---------------------------------------------------------------
                HStack {
                Toggle(
                        isOn: $toggleIsOn1,
                        label: {
                            Text("Front Door Lock")
                                .onChange(of: toggleIsOn1, perform: { value in
                                if value == true {
                                    print(" Zone 1 is -> is ON")
                                    GetHttp(5,1)
                                } else {
                                    print(" Zone 1 is -> is OFF")
                                    GetHttp(5,0)
                                }
                                
                            })
                        }
                    )
                    Spacer()
                    Text( toggleIsOn1 ? "ON":"OFF").font(.subheadline)
                }
                .padding(.top, 40.0)
                
                
            //ZONE 2 ---------------------------------------------------------------
                HStack {
                    Toggle(
                        isOn: $toggleIsOn2,
                        label: {
                            Text("Front Door Light")
                                .onChange(of: toggleIsOn2, perform: { value in
                                    if value == true {
                                        print(" Zone 2 is -> is ON")
                                        GetHttp(4,1)
                                    } else {
                                        print(" Zone 2 is -> is OFF")
                                        GetHttp(4,0)
                                    }
                                })
                        }
                    )
                    Spacer()
                    Text( toggleIsOn2 ? "ON":"OFF").font(.subheadline)
                }
                .padding(.top, 20.0)
                
                //ZONE 3 ---------------------------------------------------------------
                HStack {
                    Toggle(
                        isOn: $toggleIsOn3,
                        label: {
                            Text("Zone 2")
                            .onChange(of: toggleIsOn3, perform: { value in
                                if value == true {
                                    print(" Zone 3 is -> is ON")
                                    GetHttp(3,1)
                                } else {
                                    print(" Zone 3 is -> is OFF")
                                    GetHttp(3,0)
                                }
                            })
                        }
                    )
                    Spacer()
                    Text( toggleIsOn3 ? "ON":"OFF").font(.subheadline)
                }
                .padding(.top, 20.0)
                
                //ZONE 4 ---------------------------------------------------------------
                HStack {
                    Toggle(
                        isOn: $toggleIsOn4,
                        label: {
                            Text("Zone 4")
                                .onChange(of: toggleIsOn4, perform: { value in
                                    if value == true {
                                        print(" Zone 4 is -> is ON")
                                        GetHttp(2,1)
                                    } else {
                                        print(" Zone 4 is -> is OFF")
                                        GetHttp(2,0)
                                    }
                                })
                        }
                    )
                    Spacer()
                    Text( toggleIsOn4 ? "ON":"OFF").font(.subheadline)
                }.padding(.top, 20.0)
                NavigationView {
                    VStack {
                        VideoPlayer(player: AVPlayer(url: urlcam))
                    }
                }
            Spacer()
            } .padding(20)
            
        }
    }
}


func WelcomeInfo()
{
    print("System Online. . . . . ")
}

func All_ON(){
    print(" All Zone is -> ON")
    for index in 2...5 {
        GetHttp(index,1)
        sleep(1)
    }
}

func All_OFF(){
    print(" All Zone is -> ON")
    for index in 2...5 {
        GetHttp(index,0)
        sleep(1)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
