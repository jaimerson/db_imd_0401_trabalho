require_relative 'setup'
require 'sinatra'

class Report
  class << self
    class Item < Struct.new(:identifier, :query, :description)
      def execute(connection)
        connection.fetch(query).map(&:itself)
      end
    end

    attr_accessor :items

    def item(identifier, description: identifier)
      query = File.read("db/queries/#{identifier}.sql")
      self.items ||= []
      self.items << Item.new(identifier, query, description)
    end
  end

  item 'sales_between_50_and_200', description: <<-DESCRIPTION
  Selecionar as vendas cuja quantidade seja superior a 50 e inferior a 200, ou cujo valor
  da venda seja inferior a 60.000,00, projetando os códigos dos produtos vendidos, os
  nomes dos compradores, as quantidades vendidas e os respectivos valores
  DESCRIPTION

  item 'hortelao_jardineiro_or_born_between_80_and_00', description: <<-DESCRIPTION
  Secionar o nome, a especialidade e a data de nascimento dos trabalhadores cuja
  especialidade seja hortelão ou jardineiro, ou cuja data de nascimento esteja entre
  01/01/1980 e 01/01/2000.
  DESCRIPTION

  attr_reader :connection

  def initialize(connection)
    @connection = connection
  end

  def items
    self.class.items.reduce({}) do |result, item|
      result[item.description] = item.execute(connection)
      result
    end
  end

end

get '/' do
  connection = Sequel.connect(database_url)
  report = Report.new(connection)
  erb :index, locals: { report: report }
end
