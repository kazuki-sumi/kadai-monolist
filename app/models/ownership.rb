class Ownership < ApplicationRecord
  # UserはItemに、ItemはUserに所有されている
  belongs_to :user
  belongs_to :item
end
