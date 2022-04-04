//
//  HomeView.swift
//  MusicAppAnimationChallenge
//
//  Created by Ali Aghamirbabaei on 4/3/22.
//

import SwiftUI

struct HomeView: View {
    @State var currentIndex: Int = 0
    @Environment(\.colorScheme) var scheme
    @Namespace var animation
    @State var detailMusic: Music?
    @State var showDetailView: Bool = false
    @State var currentCardSize: CGSize = .zero
    @State var randomMusicCollection = musics.shuffled()
    
    var body: some View {
        ZStack {
            BGView()
            
            GeometryReader {proxy in
                let size = proxy.size
                
                VStack {
                    VStack {
                        SnapCarousel(spacing: 20, trailingSpace: 110, index: $currentIndex, items: musics) { music in
                            GeometryReader { proxy in
                                let size = proxy.size
                                
                                VStack {
                                    Image(music.artwork)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: size.width, height: size.height)
                                        .cornerRadius(20)
                                        .matchedGeometryEffect(id: music.id, in: animation)
                                        .onTapGesture {
                                            currentCardSize = size
                                            detailMusic = music
                                            withAnimation(.easeInOut) {
                                                showDetailView = true
                                            }
                                        }
                                    
                                    Text(music.musicName)
                                        .font(Font.custom("DevilBreezeBook", size: 20))
                                }
                            }
                        }
                        .padding(.top, 70)
                        
                        CustomIndicator()
                    }
                    .frame(height: size.height / 2)
                    
                    VStack {
                        HStack {
                            Text("Popular")
                                .font(Font.custom("DevilBreezeBold", size: 20))
                                .frame(alignment: .leading)
                            
                            Spacer()
                        }
                        
                        ScrollView(.vertical, showsIndicators: false) {
                            ForEach(randomMusicCollection) { music in
                                HStack(spacing: 20) {
                                    Image(music.artwork)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 70, height: 70)
                                        .cornerRadius(10)
                                    
                                    Text(music.musicName)
                                        .font(Font.custom("DevilBreezeBold", size: 17))
                                    
                                    Spacer()
                                }
                            }
                        }
                    }
                    .padding()
                }
                .overlay(
                    VStack {
                        if showDetailView {
                            if let music = detailMusic {
                                DetailView(music: music, animation: animation, showDetailView: $showDetailView, detailMusic: $detailMusic, currentCardSize: $currentCardSize)
                            }
                        }
                    }
                )
                
            }
        }
        .ignoresSafeArea(edges: .bottom)
    }
    // MARK: Custom Indicator
    @ViewBuilder
    func CustomIndicator() -> some View {
        HStack(spacing: 0) {
            ForEach(musics.indices, id: \.self) { index in
                Circle()
                    .fill(currentIndex == index ? .blue : .gray.opacity(0.5))
                    .frame(width: currentIndex == index ? 10 : 6, height: currentIndex == index ? 10 : 6)
                    .padding(2)
            }
        }
        .animation(.easeInOut, value: currentIndex)
    }
    
    // MARK: Blurred BG
    @ViewBuilder
    func BGView()-> some View {
        GeometryReader { proxy in
            let size = proxy.size
            
            TabView(selection: $currentIndex) {
                ForEach(musics.indices, id: \.self) { index in
                    Image(musics[index].artwork)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width, height: size.height)
                        .clipped()
                        .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .animation(.easeInOut, value: currentIndex)
            
            let color: Color = (scheme == .dark ? .black : .white)
            LinearGradient(colors: [
                .black,
                .clear,
                color.opacity(0.15),
                color.opacity(0.5),
                color.opacity(0.8),
                color,
                color
            ], startPoint: .top, endPoint: .bottom)
            
            Rectangle()
                .fill(.ultraThinMaterial)
        }
        .ignoresSafeArea()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.dark)
    }
}
