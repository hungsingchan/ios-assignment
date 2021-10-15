//
//  HomeView.swift
//  ios assignment
//
//  Created by xdeveloper on 15/10/2021.
//

import SwiftUI

struct HomeView: View {
    @State private var malls: [Malls] = []
        
        var body: some View {
            if #available(iOS 15.0, *) {
//                List(malls) { mallsItem in
//                    AsyncImage(url: URL(string: mallsItem.image)){ image in
//                            image.resizable()
//                        } placeholder: {
//                            ProgressView()
//                        }
//                        .scaledToFit()
//                        Text(mallsItem.title)
//                }
//                .onAppear(perform: startLoad)
//                .refreshable {
//                    startLoad()
//                }
            } else {
                // Fallback on earlier versions
                List(malls) { mallsItem in
                    VStack (alignment: .leading) {
                        RemoteImageView(urlString: mallsItem.image)
                        Text(mallsItem.restaurant)
                        Text(mallsItem.title)
                        Text("Coins: \(mallsItem.coin)")
                    }
                }
                    .onAppear(perform: startLoad)
            }
        }
    }

    struct HomeView_Previews: PreviewProvider {
        static var previews: some View {
            HomeView()
        }
    }

    struct Malls: Identifiable {
        let id: Int
        let title: String
        let detail: String
        let image: String
        let coin: Int
        let restaurant: String
    }

    extension HomeView {
        
        func handleClientError(_: Error) {
            return
        }
        
        func handleServerError(_: URLResponse?) {
            return
        }
        
        func startLoad() {
            
            let url = URL(string: "https://comp4097-2021ass1.herokuapp.com/")!
            
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                
                if let error = error {
                    self.handleClientError(error)
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                          self.handleServerError(response)
                          return
                      }
                //if let data = data, let string = String(data: data, encoding: .utf8) {
                //
                //    self.news = [News(id: 0, title: string, detail: "", image: "")]
                //}
                if let data = data, let malls = try? JSONDecoder().decode([Malls].self, from: data) {
                    
                    self.malls = malls
                }
            }
            
            task.resume()
        }
    }

    extension Malls: Decodable {}

    struct RemoteImageView: View {
        
        var urlString: String
        @State var image: UIImage = UIImage()
        
        var body: some View {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .onAppear {
                    loadImage(for: urlString)
                }
        }
        
        func loadImage(for urlString: String) {
            guard let url = URL(string: urlString) else { return }
            
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data else { return }
                self.image = UIImage(data: data) ?? UIImage()
            }
            task.resume()
        }
    }
