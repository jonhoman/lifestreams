require 'vcr'

VCR.config do |c|
  c.cassette_library_dir     = 'fixtures/cassette_library'
  c.stub_with                :webmock
  c.ignore_localhost         = true
  c.default_cassette_options = { :record => :once, :re_record_interval => 7.days }
end

