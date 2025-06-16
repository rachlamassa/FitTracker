//
//  HomeView.swift
//  FitTracker
//
//  Created by Rachael LaMassa on 6/8/25.
//

// colors: ui black, ui accent gray

import SwiftUI

struct HomeView: View {
    @State var notifications: Bool = true
    @State private var affirmation: String = "affirmation here"
    var body: some View {
        NavigationView {
            VStack(spacing: 0) { // no spacing here
                headerSection(profileImage: Image(systemName: "person.circle")) // use your actual image here
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {
                        greeting(message: "Good Morning!") // TODO: time dependent
                        StreakCard()
                            .padding(.horizontal)
                        todaysWorkouts
                        Spacer()
                        Text(affirmation)
                            .font(.system(size: 20))
                        Spacer()
                        navigationGrid
                    }
                    .padding(.top)
                }
                .background(Color(.systemGray6))
            }
        }
    }
    
    private func headerSection(profileImage: Image) -> some View {
        HStack {
            Text("FitTracker")
                .font(.system(size: 20))
                .fontWeight(.medium)
            Spacer()
            Button {
                // TODO: connect notifications
                notifications.toggle()
            } label: {
                if !notifications {
                    Image(systemName: "bell")
                        .font(.system(size: 20))
                } else {
                    Image(systemName: "bell.fill")
                        .font(.system(size: 20))
                }
            }
            Button {
                // TODO: nav to profile
            } label: {
                // TODO: profile image
                profileImage
                    .resizable()
                    .scaledToFill()
                    .frame(width: 20, height: 20)
                    .clipShape(Circle())
            }
        }
        .padding()
    }
    
    private func greeting(message: String) -> some View {
        // TODO: time dependent messages
        VStack(alignment: .leading, spacing: 15) {
            Text(message)
                .font(.system(size: 28))
                .fontWidth(.standard)
                .fontWeight(.medium)
            Text("Ready to get fit?")
                .font(.system(size: 16))
                .fontWidth(.standard)
                .fontWeight(.medium)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
    
    private var todaysWorkouts: some View {
        // TODO: title, workout card
        VStack (alignment: .leading, spacing: 15) {
            Text("Today's Workouts")    // TODO: based on how many
                .font(.system(size: 20))
                .fontWeight(.medium)
                .padding(.bottom, 10)
            // workout card
        }
        .padding()
    }
    
    private var navigationGrid: some View {
        HStack(spacing: 20){
            NavigationButton(destination: AnyView(BrowseView()), image: "magnifyingglass", text: "Browse")
            NavigationButton(destination: AnyView(BrowseView()), image: "magnifyingglass", text: "Browse")
        }
        .padding(.vertical)
    }
}

struct StreakCard: View {
    var body: some View {
        // TODO: heading text, # days/ months/ years, fire (lit if streak)
        
        HStack {
            VStack(alignment: .leading) {
                Text("Current Streak")
                    .font(.system(size: 16))
                    .fontWidth(.standard)
                    .fontWeight(.medium)
                Text("7 days")
                    .font(.system(size: 28))
                    .fontWidth(.standard)
                    .fontWeight(.medium)
            }
            Spacer()
            Image(systemName: "flame")
                .font(.system(size: 36))
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color(.systemGray4), lineWidth: 1)
        )
        .cornerRadius(15)
    }
}



struct NavigationButton: View {
    var destination: AnyView
    var image: String
    var text: String
    var body: some View {
        NavigationLink(destination: destination) {
            HStack(spacing: 10) {
                Image(systemName: image)
                Text(text)
            }
            .font(.system(size: 20))
            .fontWeight(.semibold)
            .foregroundColor(.primary)
            .padding(.vertical, 16)
            .padding(.horizontal, 24)
            .background(Color(.systemGray6))
            .cornerRadius(10)
        }
    }
}

#Preview {
    HomeView()
}
