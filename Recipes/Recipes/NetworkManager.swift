//
//  NetworkManager.swift
//  Recipes
//
//  Created by Harshitha GuruRaj on 5/15/24.
//

import Foundation

class NetworkManager: ObservableObject {
    @Published var meals: [Meal] = []
    @Published var mealDetail: MealDetail?

    func fetchMeals() {
//        List fetching API
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert") else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let mealList = try JSONDecoder().decode(MealList.self, from: data)
                    DispatchQueue.main.async {
                        self.meals = mealList.meals.sorted { $0.name < $1.name }
                    }
                } catch {
                    print("Error decoding data: \(error)")
                }
            }
        }.resume()
    }

    func fetchMealDetail(id: String) {
//        Details fetching API
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(id)") else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    print("Data received: \(String(data: data, encoding: .utf8) ?? "No Data")")
                    let mealDetailResponse = try JSONDecoder().decode(MealDetailResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.mealDetail = mealDetailResponse.meals.first
                        print("Meal detail fetched: \(self.mealDetail?.name ?? "No Meal")")
                    }
                } catch {
                    print("Error decoding data: \(error)")
                }
            } else if let error = error {
                print("Network error: \(error)")
            }
        }.resume()
    }
}

struct MealDetailResponse: Decodable {
    let meals: [MealDetail]
}
