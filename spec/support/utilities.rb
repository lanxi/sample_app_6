include ApplicationHelper
require "#{Rails.root}/spec/support/my_spec_checker.rb"
include MySpecChecker
require "#{Rails.root}/spec/support/my_spec_filler.rb"
include MySpecFiller
require "#{Rails.root}/spec/support/my_spec_processor.rb"
include MySpecProcessor
