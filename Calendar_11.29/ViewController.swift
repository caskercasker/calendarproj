//
//  ViewController.swift
//  Calendar_11.29
//
//  Created by 조우현 on 2019/11/29.
//  Copyright © 2019 조우현. All rights reserved.
//
import Foundation
import UIKit

class Dates {
    //let dateComponents = DateComponents( year: calendar.component(.year, from: self), month: <#T##Int?#>, day: <#T##Int?#>, hour: <#T##Int?#>, minute: <#T##Int?#>, second: <#T##Int?#>, nanosecond: <#T##Int?#>, weekday: <#T##Int?#>, weekdayOrdinal: <#T##Int?#>, quarter: <#T##Int?#>, weekOfMonth: <#T##Int?#>, weekOfYear: <#T##Int?#>, yearForWeekOfYear: <#T##Int?#>)
    var items: Int
    init(){
        items = 1
    }
    class func add(numberOne: Int, numberTwo: Int) -> Int{

        let answer: Int = numberOne + numberTwo
        return answer
   }
}

extension Date{
    //let StartDay = calendar.component(.month, from: rightNow)
    func getCurrentDate() -> Int{
        let calendar = Calendar.current
        let rightNow = Date()
        
        let dateComponents = DateComponents(year: calendar.component(.year, from: self), month: calendar.component(.month, from: self))
        _ = calendar.date(from: dateComponents)!
        
        let day = calendar.component(.day, from: rightNow)
        
        return day
    }
    
    func getCurretDayOfDate() ->  Int {
        return Calendar.current.component(.weekday, from: self)
    }
    
    func startOfMonth() -> Date { //Date 객체 보내기.....
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }

    func endOfMonth() -> Date { //Date 객체보내기...
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
        //달을 한달을 넘기고 하루 뒤에 데이터를 뽑아서 전달의 데이터를 뽑는다.
    }//Create date from Componenets
}


class ViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        //해당주의 데이터를 뿌린다.
        let endOfMonth = Calendar.current.component(.day, from: Date().endOfMonth())
        let c: Int = endOfMonth/7
        for index in 1...(c+1){
        setCollectionItem(week: index)
        }
    }

    var collectionItems = [String]()
    var collectionItems2 = [String]()
    var dic1: Dictionary = [String:Int]()
    
    func setCollectionItem(week: Int){
        
        var result = Dates.add(numberOne: 4, numberTwo: 2)
        let rightNow = Date() //Date 객체 받음
        
        let i = Date().getCurrentDate() //현재날짜 받아오기
        print(i)
        let dayOfDate = Date().getCurretDayOfDate()
        print(dayOfDate)
        
        //날짜 시작일에 해당하는 날짜 객체를 받아와야 한다.
        //let startDate = Date(from: <#T##Decoder#>)
        
        let startOfMonth = Calendar.current.component(.day, from: Date().startOfMonth())//그달의 시작일 정수로 받아오기.
        print(startOfMonth)
        let endOfMonth = Calendar.current.component(.day, from: Date().endOfMonth())
        print(endOfMonth)
        
        let dateOfStartMonth = Calendar.current.component(.weekday, from: Date().startOfMonth())// 그달의 시작 요일
        print(dateOfStartMonth)
        let dateOfEndOfMonth = Calendar.current.component(.weekday, from: Date().endOfMonth())
        print(dateOfEndOfMonth)
        
        
        
        let dayAfter = Calendar.current.date(byAdding: .day, value: -10, to: rightNow) //3일 뒤의 날짜
        let dayAfter3 = Calendar.current.component(.day, from: dayAfter!)//3일 뒤의 날짜 데이터로 받아오기.
        
        let test = Calendar.current.date(byAdding: .day, value: -10, to: Date().startOfMonth())
        print(test)
        
        //이번주 값들 저장
        
        let sevenDayAfter = Calendar.current.date(byAdding:.day, value: (week-1)*7 , to : Date().startOfMonth())
        
        
        //let onDayAfterDay = ondayAfter.getCurrentDate()
        
        print(dayAfter3)
        
        print("djkfdfjeoifjeoifj")
        
        
        var dic1: Dictionary <Int, Int> = [1:0,2:0,3:0,4:0,5:0,6:0,7:0]
        //1,2,3,4,5,6,7
        
        var bufferOfDay = Calendar.current.component(.weekday,from: sevenDayAfter!) // 요일값 정수
        //var bufferOfDay: Int = 0 // 해당 날짜의 요일값을 받아오면 딕셔너리에 저장하는 조건
        var bufferDate = Calendar.current.component(.day, from: sevenDayAfter!) // 날짜값 정수      var day = 0;
        //let b = bufferDate // 뿌리기 기준 날짜
        var keyPoint = 0-bufferOfDay+1 //0일수가 없음

        for _ in 1...8{
        //날짜를 넘기고, 요일을 넘기면
            switch (bufferOfDay){
            case 1:
                dic1.updateValue(bufferDate, forKey: 1)
                //print(day)
                //break
            case 2:
                dic1.updateValue(bufferDate, forKey: 2)
                //print(day)
                //break
            case 3:
                dic1.updateValue(bufferDate, forKey: 3)
                //break
            case 4:
                dic1.updateValue(bufferDate, forKey: 4)
                //break
            case 5:
                dic1.updateValue(bufferDate, forKey: 5)
                //break
            case 6:
                dic1.updateValue(bufferDate, forKey: 6)
                //break
            case 7:
                dic1.updateValue(bufferDate, forKey: 7)
            default:
                print("end")
            }
           
            
            if(keyPoint != 0){
  
                let distance = keyPoint
                print("print index")
                print(keyPoint)
                let c = Calendar.current.date(byAdding: .day, value: distance ,to : sevenDayAfter!)// 다음 날짜 객체 받아오기
                bufferDate = Calendar.current.component(.day, from: c!) // 날짜 받기
                bufferOfDay = Calendar.current.component(.weekday,from: c!) //요일 받기
                print("날짜 데이터")
                print(bufferDate)

                keyPoint += 1
            }else {
                keyPoint += 1;
                //print("0")
            }
            //buf += 1;
            //bufferDate = Calendar.current.date(byAdding: .day, value: b ,to : Date().startOfMonth())
            
            //print(index)
        }
    
        
        for (key,value) in dic1{
            print("\(key):\(value)") // 1:zedd 2:swift 3:iOS 4:fun 5:Hello
        }
        
        
        //print(day) // 일요일을 기준으로 1부터 저장된 딕셔너리에서, 요일값을 기준으로 정렬된 배열에 넣기.
        
        for count in 0...6{
            collectionItems.append(String())
            collectionItems[count+((week-1)*7)] = String(dic1[count+1]!)
            result += 1
        }
    }
        
        ///////////////////////
        
    
    //********** 추가되는 부분 ***************

    //콜렉션 뷰에 셀을 행에다가 7개씩 뿌린다.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let noOfCellsInRow = 7
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout

        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))

        return CGSize(width: size, height: size)
    
    }
    
        // MARK: - CollectionView DataSource

        override func numberOfSections(in collectionView: UICollectionView) -> Int {
                return 1
        }
        override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return collectionItems.count

    }
        override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DateCell", for: indexPath) as! CollectionViewCell
            //  Configure the Cell
            cell.collectionViewTest.text = collectionItems[indexPath.row]
            cell.collectionViewButton.setTitle(collectionItems[indexPath.row],for:.normal)
            cell.collectionViewButton.backgroundColor = .red
            cell.collectionViewButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40) // X, Y, width, height
            
            //cell.CollectionViewButton(UIButton).setTitle = collectionItems[indexPath.row]
            return cell

        }


        //********** 추가되는 부분 ***************

}


