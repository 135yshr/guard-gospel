require 'spec_helper'

describe Guard::Gospel do
	describe '.initialize' do
		it 'instanciates with default and custom options' do
			guard_gospel = Guard::GoSpel.new(foo: :bar)
			expect(guard_gospel.options).to eq(foo: :bar)
		end
	end
end