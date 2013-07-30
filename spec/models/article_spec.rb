require 'spec_helper'

describe Article do
  it "defaults to using today's date as a string" do
    notice = Notice.new
    expect(notice.date).to eq(Time.now.utc.to_date)
  end
end
