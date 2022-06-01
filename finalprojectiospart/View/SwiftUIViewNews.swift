//
//  SwiftUIViewNews.swift
//  finalprojectiospart
//
//  Created by Айбек on 23.05.2022.
//

import SwiftUI

struct NewsListView: View {
    let newsList = NewsStore.shared.getAll()
    var body: some View {
        NavigationView {
            List {
                Section(header: HeaderView(text: "Headline")) {
                    let headline = newsList.last!
                    ZStack {
                        // embed as hidden in ZStack to remove right arrow
                        NavigationLink(destination: NewsViewOne(news: headline)) {
                            //
                        }
                        .hidden()
                        NewsHeadlineView(news: headline)
                    }
                }
                Section(header: HeaderView(text: "Latest")) {
                    ForEach (newsList) { row in
                        NavigationLink(destination: NewsViewOne(news: row)) {
                            NewsRowView(news: row)
                        }
                    }
                }
            }
            .navigationBarTitle("Home")
        }
        // prevent iPad split view
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct NewsRowView: View {
    let news: News
    var body: some View {
        HStack(alignment: .top, spacing: 16.0) {
            Image(news.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 120, height: 120)
                .cornerRadius(8.0)
                
            VStack(alignment: .leading, spacing: 4.0, content: {
                Text(news.title).font(.headline).lineLimit(2)
                Text(news.description).lineLimit(2).font(.subheadline)
                Text(news.dateString)
                    .foregroundColor(.gray)
                    .font(.subheadline)
            })
        }
        .padding(8.0)
    }
}

struct NewsHeadlineView: View {
    let news: News
    var body: some View {
        VStack(alignment: .leading, spacing: 16.0) {
            Image(news.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .cornerRadius(8.0)
                
            VStack(alignment: .leading, spacing: 8.0, content: {
                Text(news.title).font(.title).lineLimit(2)
                Text(news.dateString)
                    .foregroundColor(.gray)
                    .font(.subheadline)
                Text(news.description).lineLimit(3).font(.subheadline)
            })
        }
        .padding(8.0)
    }
}

struct NewsListView_Previews: PreviewProvider {
    static var previews: some View {
        NewsListView()
    }
}


struct HeaderView: View {
    let text: String
    var body: some View {
        HStack {
            Text(text).font(.headline).padding(EdgeInsets(top: 24, leading: 28, bottom: 24, trailing: 24))
        }
        .frame(width: UIScreen.main.bounds.width, height: 36, alignment: .leading)
        .background(Color(UIColor.systemBackground))
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(text: "Lorem Ipsum")
    }
}

struct SocialCountView: View {
    @State var showingDetail = false
    @State var isLikes = false
    @State var likesCount = 534
    var likeButtonColor: Color {
        return isLikes ? .blue : Color("customBlack")
    }
    var body: some View {
        HStack(spacing: 24){
            Button(action: {
                isLikes.toggle()
                if isLikes {
                    likesCount += 1
                }
                else {
                    likesCount -= 1
                }
            }) {
                HStack(spacing: 4) {
                    Image(systemName: "heart.fill")
                        .frame(width: 24, height: 24)
                        .foregroundColor(Color.red.opacity(0.6))
                    Text("\(likesCount) Likes").font(.subheadline).foregroundColor(likeButtonColor)
                }
            }
            Button(action: {
                self.showingDetail.toggle()
            }) {
                HStack(spacing: 4) {
                    Image(systemName: "message.fill").frame(width: 24, height: 24).foregroundColor(Color.blue.opacity(0.6))
                    Text("1.4K Comments").font(.subheadline).foregroundColor(Color("customBlack"))
                }
            }
            .sheet(isPresented: $showingDetail) {
                CommentsView()
            }
        }
    }
}

struct SocialCountView_Previews: PreviewProvider {
    static var previews: some View {
        SocialCountView()
    }
}


struct NewsViewOne: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @GestureState private var dragOffset = CGSize.zero
    
    let news: News
    var body: some View {
        // use GeometryReader to get current frame
        GeometryReader { geo in
            ScrollView(.vertical, showsIndicators: false, content: {
                Image(news.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geo.size.width, height: geo.size.width)
                    .clipped()
                VStack(alignment: .leading, spacing: 8.0, content: {
                    Text(news.title).font(.largeTitle).lineLimit(4)
                    Text(news.dateString + " by \(news.author)")
                        .foregroundColor(.gray)
                        .font(.system(size: 14, weight: .medium, design: .default))
                    SocialCountView().padding(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))
                    Text("New York - " + news.description)
                        .font(.subheadline)
                })
                .padding(24)
            })
            .navigationBarTitle("News", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
            // add custom back button and share button
            .navigationBarItems(leading: Button(action : {
                self.mode.wrappedValue.dismiss()
            }){
                Image(systemName: "arrow.left")
            }, trailing:
                Button(action: {
                    print("Share button pressed")
                }) {
                    Image(systemName: "square.and.arrow.up")
                }
            )
            // enable swipe back
            .gesture(DragGesture().updating($dragOffset, body: { (value, state, transaction) in
                if (value.startLocation.x < 20 && value.translation.width > 100) {
                    self.mode.wrappedValue.dismiss()
                }
            }))
        }
        .padding(0)
    }
}

struct NewsViewOne_Previews: PreviewProvider {
    static var previews: some View {
        let news = NewsStore.shared.getAll().first!
        NewsViewOne(news: news)
    }
}

struct CommentsView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    let comments = CommentsStore.shared.getAll()
    var body: some View {
        NavigationView {
            ContainerView() {
                ForEach (comments) { comment in
                    CommentView(comment: comment)
                }
            }
            .navigationBarTitle("Comments")
            .navigationBarItems(leading: Button(action : {
                self.mode.wrappedValue.dismiss()
            }){
                Image(systemName: "xmark")
            })
        }
    }
}

struct CommentsView_Previews: PreviewProvider {
    static var previews: some View {
        CommentsView()
    }
}

struct ContainerView<Content: View>: View {
    var content: () -> Content
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(content: content).padding(.top, 24)
        }
    }
}

struct CommentTextView: View {
    let comment: Comment
    var body: some View {
        VStack(alignment: .leading, spacing: 8.0, content: {
            HStack(spacing: 8.0) {
                Text(comment.userName).font(.headline).lineLimit(2)
                Spacer()
                Text(comment.dateString).lineLimit(4).font(.footnote).foregroundColor(.gray)
            }
            Text(comment.comment).lineLimit(4).font(.subheadline)
            
        })
        .padding(16.0)
    }
}

struct CommentView: View {
    let comment: Comment
    var body: some View {
        HStack(alignment: .top, spacing: 12.0) {
            Image(comment.personImageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 54, height: 54)
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            CommentTextView(comment: comment)
                .background(Color(UIColor.systemGray.withAlphaComponent(0.1)))
                .cornerRadius(16.0)
            Spacer()
        }
        .padding(.leading, 16)
    }
}

