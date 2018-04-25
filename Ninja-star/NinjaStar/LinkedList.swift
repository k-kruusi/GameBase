//a linked list that I will use for the shurikens that the ninja will throw
public class LinkedList<T> {
    
    fileprivate var head: Node<T>?
    private var tail: Node<T>?
    public var size: Int = 0
    
    public var isEmpty: Bool {
        return head == nil
    }
    
    public var first: Node<T>? {
        return head
    }
    
    public var last: Node<T>? {
        return tail
    }
    
    public func append(value: T) {
        size += 1
        let newNode = Node(value: value)
        if let tailNode = tail {
            newNode.previous = tailNode
            tailNode.next = newNode
        } else {
            head = newNode
        }
        tail = newNode
    }
    
    //this will be used to loop through the shurikens
    public func nodeAt(index: Int) -> Node<T>? {
        if index >= 0 {
            var node = head
            var i = index
            while node != nil {
                if i == 0 { return node }
                i -= 1
                node = node!.next
            }
        }
        return nil
    }
    
    //this will be used once the shurikens are out of sight
    public func remove(node: Node<T>) -> T {
        size -= 1
        let previous = node.previous
        let next = node.next
        if let previous = previous {
            previous.next = next
        } else {
            head = next
        }
        next?.previous = previous
        
        if next == nil {
            tail = previous
        }
        
        node.previous = nil
        node.next = nil
        
        return node.value
    }
    
    
    public func removeAll() {
        head = nil
        tail = nil
    }
}
