import Cocoa
import CreateML

let mrtData = try MLDataTable(contentsOf: URL(fileURLWithPath: "/Users/appletone/Desktop/MRT_201807_p2.csv"))
let columnNames = mrtData.columnNames

let (trainingCSVData, testCSVData) = mrtData.randomSplit(by: 0.8, seed: 0)

let traffic = try MLRegressor(trainingData: mrtData, targetColumn: "Passenger")

let csvMetadata = MLModelMetadata(author: "Louis Chang", shortDescription: "Predict MRT passenger traffic", version: "1.0")
try traffic.write(to: URL(fileURLWithPath: "/Users/appletone/Desktop/MRT.mlmodel"), metadata: csvMetadata)
