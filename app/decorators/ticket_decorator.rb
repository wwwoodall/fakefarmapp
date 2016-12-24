class TicketDecorator

  attr_reader :ticket

  def initialize(ticket)
    @ticket = ticket
  end

  def method_missing(method_name, *args, &block)
    ticket.send(method_name, *args, &block)
  end
end