require 'spec_helper'

describe file('/tmp/test') do
  it {should be_owned_by "#{property[:owner]}"}
end
