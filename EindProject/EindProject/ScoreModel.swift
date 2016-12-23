class ScoreModel {
    
    private var medications: [Medication: Int] = [:]
    
    func setDummyData() {
        medications = [:]
        
        let pil1 = Medication(name: "Buscopan", extra: "Krampen", description: "20mg, max 3 per dag")
        let pil2 = Medication(name: "test1", extra: "Krampen", description: "20mg, max 3 per dag")
        let pil3 = Medication(name: "test2", extra: "Krampen", description: "20mg, max 3 per dag")
        let pil4 = Medication(name: "test3", extra: "Krampen", description: "20mg, max 3 per dag")
    

        medications[pil1] = 5
        medications[pil2] = 8
        medications[pil3] = -3
        medications[pil4] = 10
    }
    
    var count: Int {
        return medications.count
    }
    
    func tuple(at index: Int) -> (color: Medication, score: Int) {
        guard index >= 0 && index < medications.count else {
            fatalError("Invalid index into ScoreModel: \(index)")
        }
        let color = medications.keys.sorted()[index]
        let score = medications[color]!
        return (color, score)
    }
    
    func removeTuple(at index: Int) {
        guard index >= 0 && index < medications.count else {
            fatalError("Invalid index into ScoreModel: \(index)")
        }
        let color = medications.keys.sorted()[index]
        medications[color] = nil
    }
    
    subscript(color: Medication) -> Int? {
        get {
            return medications[color]
        }
        set {
            medications[color] = newValue
        }
    }
}
