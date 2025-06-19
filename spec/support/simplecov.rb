require 'simplecov'

SimpleCov.start 'rails' do
  enable_coverage :branch
  add_filter '/spec/'
  add_filter '/app/jobs/'
  add_filter '/app/mailers/'
end
