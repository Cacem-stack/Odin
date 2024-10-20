class LinkedList
  attr_accessor :head, :tail

  def initialize
    @head = nil
    @tail = nil
  end

  def append(value)
    if @tail != nil
      @previous_tail = @tail
      @tail = Node.new(value, nil)
      @previous_tail.next_node = @tail
    else
      @tail = Node.new(value, nil)
    end
    @head = @tail if @head == nil
  end

  def prepend(value)
    if @head != nil
      @previous_head = @head
      @head = Node.new(value)
      @head.next_node = @previous_head
    else
      @head = Node.new(value)
    end
    @tail = @head if @tail == nil
  end

  def size
    @tracker = @head
    @index = 0
    loop do
      @index += 1
      @tracker = @tracker.next_node
      return @index + 1 if @tracker.next_node == nil
    end
  end

  def head
    @head
  end

  def tail
    @tail
  end

  def at(index)
    @tracker = @head
    @index = 0
    @array = []
    until @tracker.next_node == nil
      @array.push(@tracker.value)
      @tracker = @tracker.next_node
    end
    @array.push(@tracker.value)
    @array[index]
  end

  def pop
    @tracker = @head
    until @tracker.next_node == @tail
      @tracker = @tracker.next_node
    end
    @tail = @tracker
    @tail.next_node = nil
  end

  def contains?(value)
    @tracker = @head
    loop do
      if @tracker.value == value
        return true
      elsif @tracker.next_node == nil
        return true if @tracker.value == value
        return false
      else
        @tracker = @tracker.next_node
      end
    end
  end

  def find(index)
    @tracker = @head
    @index = index
    @array = []
    @array.push(@tracker.value)
    until @tracker.next_node == nil
      @tracker = @tracker.next_node
      @array.push(@tracker.value)
    end
    @array.index(@index)
  end

  def to_s
    @tracker = @head
    loop do
      print "( #{@tracker.value} ) -> "
      @tail = @head if @tail == nil
      @tracker = @tracker.next_node
      return "( #{@tracker.value} ) -> nil" if @tracker.next_node == nil
    end
  end

end
