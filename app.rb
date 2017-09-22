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

  item 'unpaid_sales', description: <<-DESCRIPTION
  Selecionar os valores das vendas que não estão pagas e os nomes dos respectivos
  compradores.
  DESCRIPTION

  item 'products_and_workers', description: <<-DESCRIPTION
  Para cada produto, selecionar a descrição, a área, o nome e a especialidade do
  trabalhador responsável. Para esse item, use produto cartesiano e junção (uma consulta
  para cada).
  DESCRIPTION

  item 'sold_products', description: <<-DESCRIPTION
  Selecionar a descrição dos produtos que já tenham sido vendidos, e o nome e a
  especialidade dos respectivos responsáveis.
  DESCRIPTION

  item 'products_ordered', description: <<-DESCRIPTION
  Para cada produto, selecionar a descrição, área, id do trabalhador, nome e
  especialidade do respectivo responsável. Contudo, o resultado deve ser apresentado em
  ordem decrescente do id do trabalhador e em ordem crescente da área plantada do
  produto.
  DESCRIPTION

  attr_reader :connection

  def initialize(connection)
    @connection = connection
  end

  def each_item
    self.class.items.each do |item|
      yield item.description, item.execute(connection), item.query
    end
  end
end

get '/' do
  connection = Sequel.connect(database_url)
  report = Report.new(connection)
  erb :index, locals: { report: report }
end
