// MIT license. Copyright (c) 2021 SwiftyFORM. All rights reserved.
import UIKit

public class TextViewFormItem: FormItem, CustomizableTitleLabel {
	override func accept(visitor: FormItemVisitor) {
		visitor.visit(object: self)
	}

	public var placeholder: String = ""

	@discardableResult
	public func placeholder(_ placeholder: String) -> Self {
		self.placeholder = placeholder
		return self
	}

	public var title: String = ""

    public var titleFont: UIFont = .preferredFont(forTextStyle: .body)
    
    public var titleTextColor: UIColor = Colors.text
    
    public var placeholderTextColor: UIColor = Colors.secondaryText

    public var required: Bool = false

    public var requiredMessage: String = "required"

	typealias SyncBlock = (_ value: String) -> Void
	var syncCellWithValue: SyncBlock = { (string: String) in
		SwiftyFormLog("sync is not overridden")
	}

    var syncErrorMessage: ((_ message: String?) -> Void)?

	internal var innerValue: String = ""
	public var value: String {
		get {
			self.innerValue
		}
		set {
			self.assignValueAndSync(newValue)
		}
	}

	func assignValueAndSync(_ value: String) {
		innerValue = value
		syncCellWithValue(value)
	}

    public func validate() -> Bool {
        if required && innerValue.isEmpty {
            syncErrorMessage?(requiredMessage)
            return false
        }
        return true
    }
}
