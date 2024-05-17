//
//  Models.swift
//  Recipes
//
//  Created by Harshitha GuruRaj on 5/15/24.
//

import Foundation

struct Meal: Identifiable, Decodable {
    let id: String
    let name: String
    let thumbnail: String
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case thumbnail = "strMealThumb"
    }
}

struct MealList: Decodable {
    let meals: [Meal]
}


struct MealDetail: Decodable {
    let id: String
    let name: String
    let instructions: String
    var ingredients: [String]
    let measurements: [String]
    let thumbnail: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.instructions = try container.decode(String.self, forKey: .instructions)
        self.thumbnail = try container.decode(String.self, forKey: .thumbnail)
        
        var ingredientsList: [String] = []
        var measurementsList: [String] = []
                
//        for i in 1...20 {
//            print("\(i) \(CodingKeys(stringValue: "strIngredient\(i)"))")
//            if let ingredientKey = CodingKeys(stringValue: "strIngredient\(i)"),
//               let ingredient = try container.decodeIfPresent(String.self, forKey: ingredientKey), !ingredient.isEmpty {
//                print("ingredient \(ingredient)")
//                          ingredientsList.append(ingredient)
//                      }
//                      
//                      if let measurementKey = CodingKeys(stringValue: "strMeasure\(i)"),
//                         let measurement = try container.decodeIfPresent(String.self, forKey: measurementKey), !measurement.isEmpty {
//                          measurementsList.append(measurement)
//                      }
//        }
//        for i in 1...20 {
//                    let ingredientKey = "strIngredient\(i)"
//                    let measurementKey = "strMeasure\(i)"
//                    
//            if let ingredientCodingKey = CodingKeys(stringValue: ingredientKey) {
//                            print("Decoding key: \(ingredientKey)")
//                            if let ingredient = try container.decodeIfPresent(String.self, forKey: ingredientCodingKey), !ingredient.isEmpty {
//                                print("Decoded ingredient: \(ingredient)")
//                                ingredientsList.append(ingredient)
//                            } else {
//                                print("Ingredient \(ingredientKey) is nil or empty")
//                            }
//            } else {
//                    print("Invalid ingredient key: \(ingredientKey)")
//            }
//            if let measurementCodingKey = CodingKeys(stringValue: measurementKey) {
//                            if let measurement = try container.decodeIfPresent(String.self, forKey: measurementCodingKey), !measurement.isEmpty {
//                                print("Decoded measurement: \(measurement)")
//                                measurementsList.append(measurement)
//                            } else {
//                                print("Measurement \(measurementKey) is nil or empty")
//                            }
//                        } else {
//                            print("Invalid measurement key: \(measurementKey)")
//                        }
//        }
        
        let newContainer = try decoder.container(keyedBy: NewCodingKeys.self)
                
                for i in 1...20 {
                    let ingredientKey = NewCodingKeys(stringValue: "strIngredient\(i)")!
                    let measurementKey = NewCodingKeys(stringValue: "strMeasure\(i)")!
                    
                    if let ingredient = try newContainer.decodeIfPresent(String.self, forKey: ingredientKey), !ingredient.isEmpty {
//                        print("ingredient \(ingredient)")
                        ingredientsList.append(ingredient)
                    }
                    
                    if let measurement = try newContainer.decodeIfPresent(String.self, forKey: measurementKey), !measurement.isEmpty {
                        measurementsList.append(measurement)
                    }
                }
        
//        print(ingredientsList)
//        print(measurementsList)
        self.ingredients=ingredientsList
        self.measurements=measurementsList

    }
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case instructions = "strInstructions"
        case thumbnail = "strMealThumb"
    }
    struct NewCodingKeys: CodingKey {
           var stringValue: String
           var intValue: Int?

           init?(stringValue: String) {
               self.stringValue = stringValue
           }

           init?(intValue: Int) {
               return nil
           }
       }

}
