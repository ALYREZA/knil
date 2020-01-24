require 'concurrent'

class Analytic < ApplicationRecord
    include Concurrent::Async
end
