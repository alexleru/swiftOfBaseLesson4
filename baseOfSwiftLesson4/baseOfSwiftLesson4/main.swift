//На прошлом занятие было объявлено, что не обязательно точно выполнять задания, главное использовать весь материал, который ранее был объявлен.
//Решил считать сколько проедет машина при заданной скорости и заданом объеме бака. Поэтому решил сделать так: родительский класс Машина имеет общие store property и функцию, которая будет переопределена в дочерних классах. Задача функции хранить математическую функцию для расчета расхода топлива. Как оказалась эта функция близка к функции описывающей парабалу, вот она и будет у каждого дочернего класса своя. Ну и другие штуки делал, что бы не забывать материал уроков
import Foundation
enum TypeOfOil : String {
    case disel = "Дизель"
    case naturalGasoline = "Аи-92"
    case superGasoline = "Аи-95"
    case gas = "Газ"
}

class Car {
    let volumeOfTank : Int
    let numbersOfWheels : Int
    let minSpeed = 0
    let maxSpeed : Int
    var currentVolumeOfTunk : Double = 0.0
    //var averageSpeed : Double
    //var pathLength : Double
    let typeOfOil : TypeOfOil
    
    init(volumeOfTank : Int, numbersOfWheels : Int, maxSpeed : Int, typeOfOil : TypeOfOil) {
        self.volumeOfTank = volumeOfTank
        self.numbersOfWheels = numbersOfWheels
        self.maxSpeed = maxSpeed
        self.typeOfOil = typeOfOil
        
        print("Параметры: Макс. скорость \(maxSpeed) км/ч, кол-во колес \(numbersOfWheels), тип топлива \(typeOfOil.rawValue) и размер бака \(volumeOfTank) л.")
    }
    
    func howManyLitersFor100KM (averageSpeed : Double) -> Double {
        return 0.0
        //a * pow(averageSpeed, 2) + b * averageSpeed + c
    }
    
    func howFarCarCanGo (averageSpeed : Double, pathLenght : Double) {
        if averageSpeed <= Double(maxSpeed) && averageSpeed >= Double(minSpeed) {
            let howFarCarCanGo = Double (100 * currentVolumeOfTunk / self.howManyLitersFor100KM(averageSpeed: averageSpeed))
            checkConditionAndMessage(howFarCarCanGo: howFarCarCanGo, pathLenght: pathLenght, averageSpeed: averageSpeed)
        }else{
            print("Машина не может двигаться с такой скоростью!")
        }
        
    }
    
    private func checkConditionAndMessage(howFarCarCanGo: Double, pathLenght: Double, averageSpeed: Double){
        if (howFarCarCanGo) > pathLenght {
            print ("Машина, которая едет со средней скоростью  \(averageSpeed) км/ч при \(currentVolumeOfTunk) л. в баке проедет \(howFarCarCanGo) км. Расход \(self.howManyLitersFor100KM(averageSpeed: averageSpeed)) л. на 100 км.")
        }else{
            print("В баке не достаточно бензина или вы слишком далеко хотите уехать")
        }
    }
    
    
    func fillCar(howMany : Double){
        if howMany > (Double(volumeOfTank) - currentVolumeOfTunk){
            print("В бак вашего автомобиля не поместиться столько бензина. В ваш бак может поместить еще \(Double(volumeOfTank) - currentVolumeOfTunk) л.")
        }else{
            currentVolumeOfTunk += howMany
            print("В бак вашего автомобиля пополнили на \(howMany) л. Теперь в нем \(currentVolumeOfTunk) л. бензина")
        }
    }
}

class PessangerCar: Car {
    override init(volumeOfTank: Int, numbersOfWheels: Int, maxSpeed: Int, typeOfOil: TypeOfOil) {
        print("Создан класс пассажирского автомобиля PessangerCar.")
        super.init(volumeOfTank: volumeOfTank, numbersOfWheels: numbersOfWheels, maxSpeed: maxSpeed, typeOfOil: typeOfOil)
    }
    override func howManyLitersFor100KM(averageSpeed: Double) -> Double {
        let a = 0.045
        let b = -4.1
        let c = 5.5
        return pow((a*averageSpeed + b), 2) + c
    }
}

class TrunkCar: Car {
    let isTrailer : Bool
    init(volumeOfTank: Int, numbersOfWheels: Int, maxSpeed: Int, typeOfOil: TypeOfOil, isTrailer: Bool) {
        self.isTrailer = isTrailer
        print("Создан класс машины грузовика TrunkCar")
        super.init(volumeOfTank: volumeOfTank, numbersOfWheels: numbersOfWheels, maxSpeed: maxSpeed, typeOfOil: typeOfOil)
    }
    
    override func howManyLitersFor100KM(averageSpeed: Double) -> Double {
        let a = 0.045
        let b = -3.1
        let c = 15.5
        return pow((a*averageSpeed + b), 2) + c
    }
}

var car1 = PessangerCar(volumeOfTank: 50, numbersOfWheels: 4, maxSpeed: 150, typeOfOil: .naturalGasoline)
car1.fillCar(howMany: 55)
car1.fillCar(howMany: 40)
car1.howFarCarCanGo(averageSpeed: 150, pathLenght: 400)
print()
var car2 = TrunkCar(volumeOfTank: 350, numbersOfWheels: 8, maxSpeed: 130, typeOfOil: .disel, isTrailer: true)
car2.fillCar(howMany: 280)
car2.fillCar(howMany: 30)
car2.howFarCarCanGo(averageSpeed: 90, pathLenght: 400)
car2.howFarCarCanGo(averageSpeed: 85, pathLenght: 2100)
