class CrossReference < ApplicationRecord
  belongs_to :task
  belongs_to :reference
end
