class LinkedListItem

  include Comparable
  attr_accessor :payload
  attr_reader :next_list_item
  # attr_reader :last

  def initialize(item)
    @payload = item
  end

  def next_list_item= (next_list_item)
    raise(ArgumentError, "Cannot link to self") if next_list_item === self
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

  def === other
    self.object_id == other.object_id
  end

  def <=> other
    m_class = payload.class
    h_class = other.payload.class
    #class Metals
    gold, silver, bronze = Fixnum, String, Symbol

    if m_class == h_class
        payload.to_s <=> other.payload.to_s
    elsif m_class == gold || m_class == silver && h_class == bronze
      -1
    elsif h_class == gold || h_class == silver && m_class == bronze
      1
    end
  end

end