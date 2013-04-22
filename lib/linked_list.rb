# no camel cases in vars, they are used class naming

require 'linked_list_item'

class LinkedList
  attr_reader :first_item

  def initialize(*args)
  #What the * does is put all args after that point into an array.
    @size = 0
    @first_item = nil
    @last_item = nil
    args.each { |x| add_item("#{x}") } unless args.nil?
  end

  def add_item(payload)
    new_item = LinkedListItem.new(payload)
    if self.first_item.nil?
      @first_item = new_item
    else
      @last_item.next_list_item = new_item
    end
    @last_item = new_item
    @size += 1
  end

  def query(n) #returns the whole object
    raise(IndexError, "Bad index query") if n > @size
    # i = 0
    # iLoc = @first_item
    # while i < n
    #   i += 1
    #   iLoc = iLoc.next_list_item
    # end
    # iLoc
    # -or-
    current_item = @first_item
    n.times do
      current_item = current_item.next_list_item
    end
    current_item
  end

  def get(n)
    query(n).payload
  end

  def last
    if @last_item.nil?
      return nil
    else
      @last_item.payload
    end
  end

  def size
    @size
  end

  def to_s
    innards = " "
    current_item = @first_item
    while current_item  # -or- self.size.times do
      innards += current_item.payload
      unless current_item.last?
        innards += ","
      end
      innards += " "
    current_item = current_item.next_list_item
    end
    "|#{innards}|"
  end

  # ========= Bonus ========== #

  def [](n)
    self.get(n)
  end

  def []=(n, new_payload)
    self.query(n).payload = new_payload
  end

  def remove(n)
    raise(IndexError, "Cant remove, does not exist") if n+1 > @size
    if n == 0
      @first_item = query(n+1)
    elsif n == @size #if its the last
      @last_item = query(n-1)
    else
      query(n-1).next_list_item = query(n+1)
    end
    @size -= 1
  end

  # ========= Things to play with ========== #

  def insert(n, payload)
    raise (IndexError, "cant add item there") if n > @size
    @size += 1
    new_item = LinkedListItem.new(payload)
    prev_item = query(n-1)
    shift_up = query(n)
    if n == 0
      @first_item = new_item
      @first_item.next_list_item = shift_up
    elsif n == @size
      @last_item.next_list_item = new_item
      @last_item = new_item
    else
      prev_item.next_list_item = new_item
      new_item.next_list_item = shift_up
    end
  end

  def unshift(*args) #add to the beginning
    i = 0
    args.each { |x|
      insert(i, "#{x}")
      i +=1
    }
  end

  def shift #returns first item and removes it
      item = query(0)
      remove(0)
      item.payload
  end

  def push(*args) #adds to the end
    args.each { |x| add_item("#{x}") }
  end

  def pop #returns last item and removes it
    item = query(@size-1)
    remove(@size-1)
    item.payload
  end

end