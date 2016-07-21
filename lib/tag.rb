class Tag < ActiveRecord::Base
  has_and_belongs_to_many :recipes
  before_save(:down_case_shit)


  private

  def down_case_shit
    self.name=(self.name.downcase)
  end
end
