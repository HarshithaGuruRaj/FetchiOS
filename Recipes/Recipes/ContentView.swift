//
//  ContentView.swift
//  Recipes
//
//  Created by Harshitha GuruRaj on 5/15/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var networkManager = NetworkManager()
    
    var body: some View {
        NavigationView {
            List(networkManager.meals) { meal in
                NavigationLink(destination: MealDetailView(mealID: meal.id)) {
                    HStack {
                        AsyncImage(url: URL(string: meal.thumbnail)) { image in
                            image.resizable()
                                 .scaledToFit()
                                 .frame(width: 50, height: 50)
                        } placeholder: {
                            ProgressView()
                        }
                        Text(meal.name)
                    }
                }
            }
            .navigationTitle("Desserts")
            .onAppear {
                networkManager.fetchMeals()
            }
        }
    }
}

struct MealDetailView: View {
    let mealID: String
    @StateObject var networkManager = NetworkManager()
    
    var body: some View {
            ScrollView {
                VStack(alignment: .leading) {
                    if let meal = networkManager.mealDetail {
                        AsyncImage(url: URL(string: meal.thumbnail)) { image in
                            image.resizable()
                                 .scaledToFit()
                                 .frame(maxWidth: .infinity)
                        } placeholder: {
                            ProgressView()
                        }
                        .padding()
                        
                        Text(meal.name)
                            .font(.largeTitle)
                            .padding()
                        
                        Text("Instructions")
                            .font(.headline)
                            .padding([.top, .leading, .trailing])
                        
                        Text(meal.instructions)
                            .padding([.leading, .trailing, .bottom])
                        
                        Text("Ingredients/Measurements")
                            .font(.headline)
                            .padding([.top, .leading, .trailing])
                        
                        ForEach(Array(zip(meal.ingredients, meal.measurements)), id: \.0) { ingredient, measurement in
                            HStack {
                                Text(ingredient)
                                Spacer()
                                Text(measurement)
                            }
                            .padding(.leading)
                        }
                    } else {
                        ProgressView()
                            .onAppear {
                                networkManager.fetchMealDetail(id: mealID)
                            }
                    }
                }
            }
            .navigationTitle("Meal Details")
        }
}


#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
