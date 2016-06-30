import Foundation

class BookletDAO {
    static func GetDummyBooklets() -> [Booklet] {
        var booklets = [Booklet]()
        
        let today = Date()
        let nextYear = Calendar.current().date(byAdding: .day, value: 1, to: today, options: Calendar.Options.matchFirst)!
        
        booklets.append(Booklet(id: 0, title: "Dixie More Direct", description: "Get dem dealz here", startDate: today, endDate: nextYear))
        booklets.append(Booklet(id: 0, title: "Provo Brovo", description: "Wuddup Brosky?", startDate: today, endDate: nextYear))
        
        return booklets
    }
}
