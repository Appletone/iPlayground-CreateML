import Foundation
import CreateML


class TextClassifer {
    
    weak var delegate:TextClassiferDelegate?
    
    func begin(_ path:String,_ textColumn:String,_ labelColumn:String) {
        
        do{
            let data = try MLDataTable(contentsOf: URL(fileURLWithPath: path))

            let (trainingData, testingData) = data.randomSplit(by: 0.8, seed: 5)

            let sentimentClassifier =  try MLTextClassifier(trainingData: trainingData, textColumn: textColumn,labelColumn: labelColumn)
            
            // Training accuracy as a percentage
            let trainingAccuracy = (1.0 - sentimentClassifier.trainingMetrics.classificationError) * 100
            
            // Validation accuracy as a percentage
            let validationAccuracy = (1.0 - sentimentClassifier.validationMetrics.classificationError) * 100
            
            print("訓練正確率：\(trainingAccuracy)  驗證正確率：\(validationAccuracy)")
            
            let evaluationMetrics = sentimentClassifier.evaluation(on: testingData)
            let evaluationAccuracy = (1.0 - evaluationMetrics.classificationError) * 100
            
            print("測試正確率：\(evaluationAccuracy)" )
            
            delegate?.trainEnd(trainingAccuracy, validationAccuracy, evaluationAccuracy,sentimentClassifier)
        }catch {
            print("數據格式或者標籤不正確")
        }
    }
}


protocol TextClassiferDelegate:class {
    
    func trainEnd(_ trainingAccuracy:Double,_ validationAccuracy:Double,_ evaluationAccuracy:Double,_ sentimentClassifier:MLTextClassifier ) ->  Void
}
