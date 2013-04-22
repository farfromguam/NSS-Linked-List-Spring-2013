class LinkedListItem

  attr_accessor :payload
  attr_reader :next_list_item
  # attr_reader :last

  def initialize(item)
    @payload = item
  end

  def next_list_item= (next_list_item)
    raise(ArgumentError, "Cannot link to self") if next_list_item == self
    @next_list_item = next_list_item
  end

  def last?
    @next_list_item.nil?
    # -or-
    # if @next_list_item == nil
    #   @last = true
    # else
    #   @last = false
    # end
  end

end