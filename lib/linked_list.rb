require 'linked_list_item'

class LinkedList
  attr_reader :first_item

  def initialize (*args)
  #What the * does is put all args after that point into an array.
    @size = 0
    @first_item = nil
    @last_item = nil
    args.each { |payload| add_item payload } # unless args.nil?
  end

  def add_item (payload)
    new_item = LinkedListItem.new payload
    if first_item.nil?
      @first_item = new_item
    else
      @last_item.next_list_item = new_item
    end
    @last_item = new_item
    @size += 1
  end

  def query (n) #returns the whole object
    raise IndexError, "Bad index query" if n > @size
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

  def get (n)
    query(n).payload
  end

  def last
    return nil if @last_item.nil?
    @last_item.payload
  end

  def size
    @size
  end

  def to_s
    innards = " "
    current_item = @first_item
    while current_item  # -or- self.size.times do
      innards += current_item.payload.to_s
      unless current_item.last?
        innards += ","
      end
      innards += " "
      current_item = current_item.next_list_item
    end
    "|#{innards}|"
  end

  # ========= Bonus ========== #

  def [] (n)
    get n
  end

  def []= (n, new_payload)
    query(n).payload = new_payload
  end

  def remove (n)
    raise IndexError, "Cant remove, does not exist" if n+1 > @size
    if n == 0
      @first_item = query 1
    elsif n == @size #if its the last
      @last_item = query n-1
    else
      query(n-1).next_list_item = query n+1
    end
    @size -= 1
  end

  # ========= Things to play with ========== #

  def insert (n, payload)
    raise IndexError, "cant add item there" if n > @size
    @size += 1
    new_item = LinkedListItem.new payload
    prev_item = query n-1
    shift_up = query n
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

  def unshift (*args) #add to the beginning
    i = 0
    args.each { |x| insert i, "#{x}"
      i +=1 }
  end

  def shift #returns first item and removes it
      item = query 0
      remove 0
      item.payload
  end

  def push (*args) #adds to the end
    args.each { |x| add_item "#{x}" }
  end

  def pop #returns last item and removes it
    item = query @size-1
    remove @size-1
    item.payload
  end

  # ========= Index exercise ========== #

  def indexOf(search_term)
    return nil if @size == 0
    item = @first_item
    i = 0
    until search_term == item.payload
      i += 1 #this should be at the bottom, but it only works here
      return nil if (i == @size) && (search_term != item.payload)
      item = item.next_list_item
    end
    i
  end

  # ========= Sorting exercise ========== #

  def sorted?
    in_order = true
    if @size > 1
      #start a loopin and a checking
      i = 0
      a = @first_item
      b = @first_item.next_list_item
      until i == @size-1 #(base 0 check)
        if a > b
          in_order = false
        end
      a = b
      b = b.next_list_item
      i += 1
      end
    end
  in_order
  end

  def sort
    if !sorted?
      x = 1
      while x < @size # do it until you get to the end
        if (get(x-1) <= get(x)) #Compare payloads, if in order
          x += 1 # move that x thing up
        else
          hold = get(x-1) #hold onto object
          remove(x-1) #remove item
          insert(x, hold) # put it back in
          if (x > 1)
            x -= 1 # now take a step back
          end
        end #end if else dance
      end #end loop
    end
    self
  end






end