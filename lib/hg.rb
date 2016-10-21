require "hg/version"

module Hg
  class Hg
    attr_reader :hash

    class << self
      def create
        inst = Hg.new
        yield inst
        inst
      end
    end

    def headers *names
      @names = names
      @hash = names.map { |name| [name.to_sym, []] }.to_h
    end
    
    def body data_str
      data = data_str.split("\n").map do |row_str|
        row_str.split(",").map do |cell_str|
          eval cell_str
        end
      end
      
      data.each do |row|
        row.each_with_index do |cell, index|
          @hash[@names[index]].push cell
        end
      end
    end
    
    def daru_dataframe
      Daru::DataFrame.new(@hash)
    end
  end
end
