require 'spec_helper'

describe Hg do
  it 'has a version number' do
    expect(Hg::VERSION).not_to be nil
  end

  it 'generate hash' do
    hash = Hg::Hg.create do |gen|
      gen.headers :x, :y
      gen.body <<-BODY
      1, 2
      3, 4
      5, 6
      BODY
    end.hash

    expect(hash).to eq ({ x: [1,3,5], y: [2,4,6] })
  end

  it 'evaluate cell' do
    hash = Hg::Hg.create do |gen|
      gen.headers :x, :y
      gen.body <<-BODY
      1, 2*2
      3, 4*2
      5, 6*2
      BODY
    end.hash

    expect(hash).to eq ({ x: [1,3,5], y: [2*2,4*2,6*2] })
  end
  
  it 'convert hash to dataframe' do
    hg = Hg::Hg.create do |gen|
      gen.headers :x, :y
      gen.body <<-BODY
      1, 2
      3, 4
      5, 6
      BODY
    end

    require 'daru'
    expect(hg.daru_dataframe).to eq Daru::DataFrame.new( hg.hash )
  end
end
