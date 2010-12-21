When /^I should have the following fields stored for the stream:$/ do |table|
  stream = Stream.last
  table.hashes.each do |row|
    row.keys.each do |header|
      stream.send(header.dehumanize).to_s.should == row[header]
    end
  end
end

When /^I should have the following fields stored for the source:$/ do |table|
  source = Source.last
  table.hashes.each do |row|
    row.keys.each do |header|
      source.send(header.dehumanize).to_s.should == row[header]
    end
  end
end

