require 'rails_helper'
  describe Order do
    it "should be valid with normal attributes" do
      order = build(:order)
      expect(order).to be_valid 
    end

    it "should be invalid if no date_sent" do
      order = build(:order, date_sent: '  ')
      expect(order).not_to be_valid
    end
  end
