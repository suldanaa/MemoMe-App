
import UIKit

class CalendarViewController: UIViewController {
    private var calendarView: UICalendarView!
    
    @IBOutlet weak var entryLabel: UILabel!
    @IBOutlet weak var entryContentLabel: UILabel!
    
    private var selectedDate: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCalendarView()
        setupLabels()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshCalendarDecorations()
        if let date = selectedDate {
            loadEntryForDate(date)
        }
    }
    
    private func setupLabels() {
        entryContentLabel.numberOfLines = 0
        entryContentLabel.text = "Select a date to view your diary entry"
        entryContentLabel.textColor = UIColor.systemGray
    }
    
    func setupCalendarView() {
        calendarView = UICalendarView()
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        
        // Find the container view for the calendar
        if let containerView = view.subviews.first(where: { $0.backgroundColor?.cgColor.components?.first == 0.98823529480000005 }) {
            containerView.addSubview(calendarView)
            
            NSLayoutConstraint.activate([
                calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                calendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                calendarView.heightAnchor.constraint(equalToConstant: 450)
            ])
        } else {
            // Fallback: add to main view
            view.addSubview(calendarView)
            
            NSLayoutConstraint.activate([
                calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                calendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                calendarView.heightAnchor.constraint(equalToConstant: 450)
            ])
        }
        
        // Configuration
        calendarView.calendar = .current
        calendarView.locale = .current
        calendarView.fontDesign = .serif
        calendarView.delegate = self
        
        // Date selection
        let dateSelection = UICalendarSelectionSingleDate(delegate: self)
        calendarView.selectionBehavior = dateSelection
        
    }
    
    private func refreshCalendarDecorations() {
        let allEntries = DiaryEntry.getEntries()
        let entryDates = allEntries.map { entry in
            Calendar.current.dateComponents([.year, .month, .day], from: entry.date)
        }
        
        // Remove duplicates
        let uniqueDates = Array(Set(entryDates.compactMap { $0 }))
        
        calendarView.reloadDecorations(forDateComponents: uniqueDates, animated: false)
    }
    
    private func loadEntryForDate(_ date: Date) {
        let entries = DiaryEntry.getEntries(for: date)
        
        if let entry = entries.first {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            entryLabel.text = "Entry for \(formatter.string(from: date))"
            entryContentLabel.text = entry.content
            entryContentLabel.textColor = UIColor(red: 0.86, green: 0.65, blue: 0.71, alpha: 1.0)
        } else {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            entryLabel.text = "No entry for \(formatter.string(from: date))"
            entryContentLabel.text = "No diary entry found for this date"
            entryContentLabel.textColor = UIColor.systemGray
        }
    }
}

// MARK: - Calendar Delegate
extension CalendarViewController: UICalendarViewDelegate {
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        guard let date = Calendar.current.date(from: dateComponents) else { return nil }
        
        let entries = DiaryEntry.getEntries(for: date)
        
        if !entries.isEmpty {
            let image = UIImage(systemName: "book.fill")
            return .image(image, color: .systemBlue, size: .large)
        }
        
        return nil
    }
}

// MARK: - Calendar Selection Delegate
extension CalendarViewController: UICalendarSelectionSingleDateDelegate {
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        guard let dateComponents = dateComponents,
              let date = Calendar.current.date(from: dateComponents) else { return }
        
        selectedDate = date
        loadEntryForDate(date)
    }
}
