require 'rails_helper'

RSpec.describe Post do
  describe 'hierarchy' do
    let(:parent) { create(:post) }
    let!(:children) { create_list(:post, 2, parent: parent) }

    it 'solves the hierarchy properly' do
      expect(parent.children).to match(children)
    end
  end
end
