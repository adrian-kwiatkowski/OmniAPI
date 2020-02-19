struct TopicDetailsViewModel {
    
    // MARK: - PRIVATE PROPERTIES
    
    private let topic: Topic
    
    // MARK: - PUBLIC PROPERTIES
    var primaryText: String { topic.title }
    var secondaryText: String { topic.type }
    
    // MARK: - INIT
    
    init(_ topic: Topic) {
        self.topic = topic
    }
}
