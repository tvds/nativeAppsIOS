//
//  MedicationModel.swift
//  EindProject
//
//  Created by Thomas Vanderschaeve on 27/12/16.
//  Copyright © 2016 Thomas Vanderschaeve. All rights reserved.
//

import Foundation
import UIKit

class MedicationModel {
    
    var medications = [Medication]()

    func setDummyData(){
        medications = [
            Medication(description:"Behandeling parkinson", name:"Akineton", image: UIImage(named: "Akineton")!),
            Medication(description:"antibioticum", name:"Amoxiclav teva", image: UIImage(named: "Amoxiclav teva")!),
            Medication(description:"Hypertensie", name:"Bisoprolol", image: UIImage(named: "Bisoprolol")!),
            Medication(description:"Spasmolytica, heft verkramping (spasmen) op in maag-darmkanaal, galwegen, urinewegen.", name:"Buscopan (oraal, I.M)"),
            Medication(description:"Antitrombotica/anticoagulantia. Antistolling, behandeling diverse cardiovasculaire problemen", name:"Clexane (subcutaan)"),
            Medication(description:"Behandeling Parkinson", name:"Corbilta", image: UIImage(named: "Corbilta")!),
            Medication(description:"Antibioticum", name:"Clamoxyl I.M"),
            Medication(description:"Opheffen van luchtwegvernauwing bij COPD", name:"Combivent unit dose"),
            Medication(description:"Anti-Alzheimer middelen", name:"Donepezil", image: UIImage(named: "Donepezil")!),
            Medication(description:"Krachtige pijnstiller", name:"Durogesic (pleister)"),
            Medication(description:"Antitrombotica", name:"Eliquis"),
            Medication(description:"Diarree", name:"Enterol")
        ]
    }


    var count: Int {
        return medications.count
    }
    
    func getMedication(at index: Int) -> (Medication) {
        guard index >= 0 && index < medications.count else {
            fatalError("Invalid index into MedicationModel: \(index)")
        }
        return medications[index]
    }
    
    func removeMedication(at index: Int) {
        guard index >= 0 && index < medications.count else {
            fatalError("Invalid index into MedicationModel: \(index)")
        }
        medications.remove(at: index)
    }
}
