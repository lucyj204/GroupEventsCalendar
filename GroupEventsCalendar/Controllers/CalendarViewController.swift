//
//  CalendarViewController.swift
//  GroupEventsCalendar
//
//  Created by Lucy Joyce on 26/09/2021.
//

import Foundation
import UIKit
import FSCalendar
import SnapKit

class CalendarViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource {

    fileprivate weak var calendar: FSCalendar!

    override func viewDidLoad() {
        super.viewDidLoad()

        // In loadView or viewDidLoad
        let calendar = FSCalendar(frame: CGRect(x: 0, y: 0, width: 320, height: 300))
        calendar.dataSource = self
        calendar.delegate = self
        view.addSubview(calendar)
        self.calendar = calendar


    }

    func calendarUpdate(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendar.snp.updateConstraints { (make) in
            make.height.equalTo(bounds.height)
            // Do other updates
        }
        self.view.layoutIfNeeded()
    }

}



