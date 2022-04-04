//
//  DetailView.swift
//  MusicAppAnimationChallenge
//
//  Created by Ali Aghamirbabaei on 4/4/22.
//

import SwiftUI

struct DetailView: View {
    var music: Music
    var animation : Namespace.ID
    @Binding var showDetailView: Bool
    @Binding var detailMusic: Music?
    @Binding var currentCardSize: CGSize
    @State var showDetailContent: Bool = false
    @State var offset: CGFloat = 0
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack {
                Image(music.artwork)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: currentCardSize.width, height: currentCardSize.height)
                    .cornerRadius(15)
                    .matchedGeometryEffect(id: music.id, in: animation)
                
                Text("\(music.artist) - \(music.musicName)")
                    .font(Font.custom("DevilBreezeBold", size: 20))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 25)
                
                VStack(spacing: 15) {
                    Text("Lyrics")
                        .font(Font.custom("DevilBreezeBold", size: 25))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 25)
                    
                    Text(music.lyrics)
                        .multilineTextAlignment(.leading)
                }
                .opacity(showDetailContent ? 1 : 0)
                .offset(y: showDetailContent ? 1 : 0)
            }
            .padding()
            .padding(.bottom)
            .modifier(OffsetModifier(offset: $offset))
        }
        .coordinateSpace(name: "SCROLL")
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background{
            Rectangle()
                .fill(.ultraThinMaterial)
                .ignoresSafeArea()
        }
        .onAppear {
            withAnimation(.easeInOut) {
                showDetailContent = true
            }
        }
        .onChange(of: offset) { newValue in
            if newValue > 120 {
                withAnimation(.easeInOut) {
                    showDetailContent = false
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                    withAnimation(.easeInOut) {
                        showDetailView = false
                    }
                }
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
