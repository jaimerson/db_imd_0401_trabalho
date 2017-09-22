require_relative 'setup'
require 'sinatra'

class Report
  class << self
    class Item < Struct.new(:identifier, :query)
      def execute(connection)
        connection.fetch(query).map(&:itself)
      end
    end

    attr_accessor :items

    def item(identifier)
      query = File.read("db/queries/#{identifier}.sql")
      self.items ||= []
      self.items << Item.new(identifier, query)
    end
  end

  item 'sales_between_50_and_200'

  attr_reader :connection

  def initialize(connection)
    @connection = connection
  end

  def items
    self.class.items.reduce({}) do |result, item|
      result[item.identifier] = item.execute(connection)
      result
    end
  end

end

get '/' do
  connection = Sequel.connect(database_url)
  report = Report.new(connection)
  erb :index, locals: { report: report }
end
